#!/usr/bin/env Rscript
#diff_datos_V2.R

library("optparse")



option_list <- list(
  make_option(c("-l","--datasetLeft", type="character", default = NULL),
              help="path to first dataset. Datasets are called 'left' and 'right' to reference join actions",
              metavar="character"),
  make_option(c("-r", "--datasetRight"), type="character", default = NULL,
              help="path to second dataset.",
              metavar="character"),
  make_option(c("-o", "--pathOut"), type="character", default = NULL,
              help="path to output files. Directory should exist previously.",
              metavar="character")
)


opt_parser <- OptionParser(usage = "Usage: %prog -l <first dataset path> -r <second dataset path> -o <output path>",
                           description = "Description:
                           This program calculates overlapping between two RDF datasets in turtle (.ttl). Only simple triples (<s> <p> <o> .) are allowed. See 2.1 section at https://www.w3.org/TR/turtle/ 
                           3 datasets are generated corresponding to 3 actions: 1) Inner join. 2) Left exclude join. 3) Right exclude join.
                           Standard output also returns a summary about results with next structure:
                            - conjunto: name's comparison done. It is composed by each input file name. 
                            - nrow_left: amount of rows (triples) at firt dataset.
                            - nrow_right: amount of rows (triples) at second dataset.
                            - ratioInnerJoin_left: percentage of triples from first dataset which remain after inner join operation.
                            - ratioInnerJoin_right: percentage of triples from second dataset which remain after inner join operation.
                            - innerJoin: amount of rows (triples) found after inner join operation. It means that these triples only can be found in both input datasets.
                            - left_exclude_right: amount of rows (triples) found after left exclude operation. It means that these triples only can be found in first dataset.
                            - right_exclude_left: amount of rows (triples) found after right exclude operation. It means that these triples only can be found in second dataset.",
                           epilogue = "Examples: 
                           %prog -l myDatasets/dummyTypes1.ttl myDatasets/myOtherDummyTypes2.ttl -o myTests/lookingForDifferences/dummyTypes/",
                           option_list=option_list)


opt <- parse_args(opt_parser)

if(is.null(opt$datasetLeft)){
  print_help(opt_parser)
  stop("datasetLeft argument must be supplied (first file's path) using -o or --pathOut options", call.=FALSE)
}

if(is.null(opt$datasetRight)){
  print_help(opt_parser)
  stop("datasetRight argument must be supplied (second file's path) using -o or --pathOut options", call.=FALSE)
}

if(is.null(opt$pathOut)){
  print_help(opt_parser)
  stop("pathOut argument must be supplied (files output's path) using -o or --pathOut options", call.=FALSE)
}


getDiff_dt <-function(pathLeft, pathRight, pathOutput){
  library(sqldf)
  
  pathDividido_dt1 <- strsplit(x = pathLeft, split = '/')
  # aproximacionUsada <- pathDividido_dt1[[1]][length(pathDividido_dt1[[1]])-1]
  dt1_nombreArchivo <- pathDividido_dt1[[1]][length(pathDividido_dt1[[1]])]
  pathDividido_dt2 <- strsplit(x = pathRight, split = '/')
  dt2_nombreArchivo <- pathDividido_dt2[[1]][length(pathDividido_dt2[[1]])]
  
  dt1 <- read.csv(file=pathLeft, header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  dt1$V4 <- NULL
  names(dt1) <- c("s","p","o")
  dt1$p <- NULL
  # dt1 <- dt1[-1,]
  
  dt2 <- read.csv(file=pathRight, header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  dt2$V4 <- NULL
  names(dt2) <- c("s","p","o")
  dt2$p <- NULL
  #depende de la situacion, ojo con los conjuntos
  # dt2 <- dt2[-1,]
  
  #como sdtypes saca tipos para todo, en este caso concreto hay que limitar los casos a los recursos que se tienen de prueba
  #esta función debería ser externa y dar los conjuntos ya listos, pero bueno......
  dt2 <- dt2[dt2$s %in% dt1$s,]
  
  
  #inner join
  innerJoin <- sqldf('SELECT dt2.s, dt2.o FROM dt2 INNER JOIN dt1 ON dt2.s = dt1.s AND dt2.o = dt1.o')
  innerJoin$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  innerJoin[,c(1,2,3)] <- innerJoin[,c(1,3,2)]
  write.csv(innerJoin, file = paste(pathOutput,'innerJoin_',
                                    # aproximacionUsada,#OJO, cambiar esto para que funcione bien, meter los datos en variable para que vaya bien
                                    '_',
                                    dt1_nombreArchivo,
                                    '-',
                                    dt2_nombreArchivo,
                                    sep = ''),#si, soy consciente de que podría poner en el split directamente '_', pero así controlo si entre cada sección quisiera alterar _ por otro símbolo
            fileEncoding = "UTF-8", row.names=FALSE)
  
  #left outer join with exclusion
  leftOuter_ex <- sqldf('SELECT * FROM dt1 EXCEPT SELECT * FROM dt2')
  # resumen_leftOuter_ex <- as.data.frame(table(leftOuter_ex$o))
  leftOuter_ex$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  leftOuter_ex[,c(1,2,3)] <- leftOuter_ex[,c(1,3,2)]
  write.csv(leftOuter_ex, file = paste(pathOutput,'leftOuter_ex_',
                                       # aproximacionUsada,
                                       '_',
                                       dt1_nombreArchivo,
                                       '-',
                                       dt2_nombreArchivo,
                                       sep = ''),
            fileEncoding = "UTF-8", row.names=FALSE)
  
  
  #right outer join with exclusion
  rightOuter_ex <- sqldf('SELECT * FROM dt2 EXCEPT SELECT * FROM dt1')
  # resumen_rightOuter_ex <- as.data.frame(table(rightOuter_ex$o))
  rightOuter_ex$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  rightOuter_ex[,c(1,2,3)] <- rightOuter_ex[,c(1,3,2)]
  write.csv(rightOuter_ex, file = paste(pathOutput,'rightOuter_ex_',
                                        # aproximacionUsada,
                                        '_',
                                        dt1_nombreArchivo,
                                        '-',
                                        dt2_nombreArchivo,
                                        sep = ''),
            fileEncoding = "UTF-8", row.names=FALSE)
  
  
  
  n0 <- c("auxiliar",100,100,100,100,100,100,100)
  resultados <- data.frame(t(n0))
  colnames(resultados) <- c("conjunto","nrow_left","nrow_right","ratioInnerJoin_left","ratioInnerJoin_right","innerJoin","left_exclude_right","right_exclude_left")
  resultados$conjunto <- as.character(resultados$conjunto)
  resultados$nrow_left <- as.character(resultados$nrow_left)
  resultados$nrow_right <- as.character(resultados$nrow_right)
  resultados$ratioInnerJoin_left <- as.character(resultados$ratioInnerJoin_left)
  resultados$ratioInnerJoin_right <- as.character(resultados$ratioInnerJoin_right)
  resultados$innerJoin <- as.character(resultados$innerJoin)
  resultados$left_exclude_right <- as.character(resultados$left_exclude_right)
  resultados$right_exclude_left <-as.character(resultados$right_exclude_left)
  # resultados <- rbind(resultados, c(paste(aproximacionUsada,
  #                                         '_',
  #                                         dt1_nombreArchivo,
  #                                         '-',
  #                                         dt2_nombreArchivo,
  #                                         sep = ''),
  #                                   nrow(dt1),nrow(dt2),round(nrow(innerJoin)/nrow(dt1),digits = 2),
  #                                   nrow(innerJoin),nrow(leftOuter_ex),nrow(rightOuter_ex)))
  resultados <- rbind(resultados, c(paste(dt1_nombreArchivo,
                                          '-',
                                          dt2_nombreArchivo,
                                          sep = ''),
                                    nrow(dt1),nrow(dt2),
                                    round(nrow(innerJoin)/nrow(dt1),digits = 2),round(nrow(innerJoin)/nrow(dt2),digits = 2),
                                    nrow(innerJoin),nrow(leftOuter_ex),nrow(rightOuter_ex)))
  resultados <- resultados[-1,]
  
  return(resultados)
}

solucion <- getDiff_dt(pathLeft = opt$datasetLeft,
                        pathRight = opt$datasetRight,
                        pathOutput = opt$pathOut)

print(solucion)
write.csv(solucion, file = paste(opt$pathOutput,solucion,sep = ''),
          fileEncoding = "UTF-8", row.names=FALSE)



