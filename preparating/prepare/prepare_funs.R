#!/usr/bin/env Rscript
#prepareData


#About "domain_resourcesURI" parameter
# DBpedia in english '^<http://dbpedia.org/resource/'
# DBpedia in Spanish '^<http://es.dbpedia.org/resource/'
#Other stuff, it does not need a parameter because it won't change
#'^<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>'
#'^<http://dbpedia.org/ontology/'


prepare_properties <- function(file_properties_In,
                               file_object_propertiesMatrix_Out,
                               domain_resourcesURI){
  
  library(reshape2)
  # original_resources <- read.csv(file=file_properties_In,
  #                                header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE, quote = "")
  original_resources <- read.csv(file=file_properties_In,
                                 header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE, quote = "")
  
  # print(nrow(original_resources))
  original_resources <- original_resources[grep(domain_resourcesURI,original_resources$V3),]
  original_resources$V4 <- NULL
  names(original_resources) <- c("s","p","o")
  original_resources$s <- as.factor(original_resources$s)
  original_resources$p <- as.factor(original_resources$p)
  original_resources$o <- as.factor(original_resources$o)
  # print(nrow(original_resources))
  
  
  conversion_Matriz <- original_resources[,c(3,2)]
  conversion_Matriz <- dcast(conversion_Matriz, o ~ p, fill=0)#ojo, puede tardar bastante
  # print(nrow(conversion_Matriz))
  write.csv(conversion_Matriz, file = file_object_propertiesMatrix_Out,
            fileEncoding = "UTF-8", row.names=FALSE)
  
  rm(list=ls())
  gc(verbose = TRUE)
  
  return(0)
}


prepare_app2and3 <- function(file_object_propertiesMatrix_In, file_instance_types_In,
                             file_learningSet_Out,
                             path_levels,
                             domain_resourcesURI){
  library(reshape2)
  conversion_Matriz <- read.csv(file=file_object_propertiesMatrix_In,
                                header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(conversion_Matriz) <- conversion_Matriz[1,]
  conversion_Matriz <- conversion_Matriz[-1,]
  conversion_Matriz[,c(2:(ncol(conversion_Matriz)))] <- sapply(conversion_Matriz[,c(2:(ncol(conversion_Matriz)))], as.numeric)
  
  original_types <- read.csv(file=file_instance_types_In,
                             header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  original_types <- original_types[grep(domain_resourcesURI,original_types$V1),]
  original_types <- original_types[grep('^<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>',original_types$V2),]
  original_types <- original_types[grep('^<http://dbpedia.org/ontology/',original_types$V3),]
  original_types$V4 <- NULL
  names(original_types) <- c("s","p","o")
  guarda_original_types <- original_types
  original_types$s <- as.factor(original_types$s)
  original_types$p <- as.factor(original_types$p)
  original_types$o <- as.factor(original_types$o)
  
  nivel1 <- read.csv(file=paste(path_levels,"nivel1.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  nivel2 <- read.csv(file=paste(path_levels,"nivel2.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  nivel3 <- read.csv(file=paste(path_levels,"nivel3.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  nivel4 <- read.csv(file=paste(path_levels,"nivel4.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  nivel5 <- read.csv(file=paste(path_levels,"nivel5.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  nivel6 <- read.csv(file=paste(path_levels,"nivel6.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  
  recursos_conTipo <- conversion_Matriz[conversion_Matriz$o %in% original_types$s,]
  
  
  tipos_todos <- original_types[,c(1,3)]
  
  #Separación de tipos en niveles
  tipos_nivel1 <- tipos_todos[tipos_todos$o %in% nivel1$nivel1,]
  tipos_nivel2 <- tipos_todos[tipos_todos$o %in% nivel2$nivel2,]
  tipos_nivel3 <- tipos_todos[tipos_todos$o %in% nivel3$nivel3,]
  tipos_nivel4 <- tipos_todos[tipos_todos$o %in% nivel4$nivel4,]
  tipos_nivel5 <- tipos_todos[tipos_todos$o %in% nivel5$nivel5,]
  tipos_nivel6 <- tipos_todos[tipos_todos$o %in% nivel6$nivel6,]
  
  tipos_resto <- tipos_todos[!(tipos_todos$o %in% nivel1$nivel1),]
  tipos_resto <- tipos_resto[!(tipos_resto$o %in% nivel2$nivel2),]
  tipos_resto <- tipos_resto[!(tipos_resto$o %in% nivel3$nivel3),]
  tipos_resto <- tipos_resto[!(tipos_resto$o %in% nivel4$nivel4),]
  tipos_resto <- tipos_resto[!(tipos_resto$o %in% nivel5$nivel5),]
  tipos_resto <- tipos_resto[!(tipos_resto$o %in% nivel6$nivel6),]
  
  colnames(recursos_conTipo)[1] <- "s"
  
  datosObjetivo <- merge(x = recursos_conTipo, y = tipos_nivel1, by = 's')
  colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class1"
  # if(nrow(datosObjetivo[is.na(datosObjetivo$Class),]$Class1)>0){
  # datosObjetivo[is.na(datosObjetivo$Class),]$Class1 <- 'desconocido'#a nivel 1 no hay desconocidos  
  # }
  
  datosObjetivo$Class1 <- as.factor(datosObjetivo$Class1)
  
  datosObjetivo <- merge(x = datosObjetivo, y = tipos_nivel2, by = 's', all.x =  TRUE )
  colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class2"
  datosObjetivo$Class2 <- as.character(datosObjetivo$Class2)
  datosObjetivo[is.na(datosObjetivo$Class2),]$Class2 <- 'desconocido'
  datosObjetivo$Class2_Bin <- rep(datosObjetivo$Class2)
  datosObjetivo[datosObjetivo$Class2_Bin!="desconocido",]$Class2_Bin <- 'conocido'
  datosObjetivo$Class2 <- as.factor(datosObjetivo$Class2)
  datosObjetivo$Class2_Bin <- as.factor(datosObjetivo$Class2_Bin)
  
  datosObjetivo <- merge(x = datosObjetivo, y = tipos_nivel3, by = 's', all.x =  TRUE )
  colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class3"
  datosObjetivo$Class3 <- as.character(datosObjetivo$Class3)
  datosObjetivo[is.na(datosObjetivo$Class3),]$Class3 <- 'desconocido'
  datosObjetivo$Class3_Bin <- rep(datosObjetivo$Class3)
  datosObjetivo[datosObjetivo$Class3_Bin!="desconocido",]$Class3_Bin <- 'conocido'
  datosObjetivo$Class3 <- as.factor(datosObjetivo$Class3)
  datosObjetivo$Class3_Bin <- as.factor(datosObjetivo$Class3_Bin)
  
  datosObjetivo <- merge(x = datosObjetivo, y = tipos_nivel4, by = 's', all.x =  TRUE )
  colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class4"
  datosObjetivo$Class4 <- as.character(datosObjetivo$Class4)
  datosObjetivo[is.na(datosObjetivo$Class4),]$Class4 <- 'desconocido'
  datosObjetivo$Class4_Bin <- rep(datosObjetivo$Class4)
  datosObjetivo[datosObjetivo$Class4_Bin!="desconocido",]$Class4_Bin <- 'conocido'
  datosObjetivo$Class4 <- as.factor(datosObjetivo$Class4)
  datosObjetivo$Class4_Bin <- as.factor(datosObjetivo$Class4_Bin)
  
  datosObjetivo <- merge(x = datosObjetivo, y = tipos_nivel5, by = 's', all.x =  TRUE )
  colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class5"
  datosObjetivo$Class5 <- as.character(datosObjetivo$Class5)
  datosObjetivo[is.na(datosObjetivo$Class5),]$Class5 <- 'desconocido'
  datosObjetivo$Class5_Bin <- rep(datosObjetivo$Class5)
  datosObjetivo[datosObjetivo$Class5_Bin!="desconocido",]$Class5_Bin <- 'conocido'
  datosObjetivo$Class5 <- as.factor(datosObjetivo$Class5)
  datosObjetivo$Class5_Bin <- as.factor(datosObjetivo$Class5_Bin)
  
  datosObjetivo <- merge(x = datosObjetivo, y = tipos_nivel6, by = 's', all.x =  TRUE )
  colnames(datosObjetivo)[ncol(datosObjetivo)] <- "Class6"
  datosObjetivo$Class6 <- as.character(datosObjetivo$Class6)
  datosObjetivo[is.na(datosObjetivo$Class6),]$Class6 <- 'desconocido'
  datosObjetivo$Class6_Bin <- rep(datosObjetivo$Class6)
  # if(nrow(datosObjetivo[datosObjetivo$Class6_Bin!="desconocido",]$Class6_Bin)>0){
  datosObjetivo[datosObjetivo$Class6_Bin!="desconocido",]$Class6_Bin <- 'conocido'
  # }
  datosObjetivo$Class6 <- as.factor(datosObjetivo$Class6)
  datosObjetivo$Class6_Bin <- as.factor(datosObjetivo$Class6_Bin)
  
  datosObjetivo <- datosObjetivo[!duplicated(datosObjetivo$s),]
  
  write.csv(datosObjetivo, file = file_learningSet_Out,
            fileEncoding = "UTF-8", row.names=FALSE)
  
  #interesting for analysis, not for continue de workflow, commented
  # datosObjetivo$auxCountIngoing <- rowSums(datosObjetivo[,2:(ncol(datosObjetivo)-11)])
  # countingIngoing <- datosObjetivo[,c(1,ncol(datosObjetivo))]
  # datosObjetivo$auxCountIngoing <- NULL
  # write.csv(countingIngoing, file = pathOtro, fileEncoding = "UTF-8", row.names=FALSE)
  
  rm(list=ls())
  gc(verbose = TRUE)
  
  return(0) 
}


prepare_app1 <- function(file_object_propertiesMatrix_In, file_instance_types_In,
                         file_learningSet_Out,
                         path_levels,
                         domain_resourcesURI){
  library(reshape2)
  conversion_Matriz <- read.csv(file=file_object_propertiesMatrix_In,
                                header=FALSE, sep=",", encoding = "UTF-8", stringsAsFactors = FALSE)
  colnames(conversion_Matriz) <- conversion_Matriz[1,]
  conversion_Matriz <- conversion_Matriz[-1,]
  conversion_Matriz[,c(2:(ncol(conversion_Matriz)))] <- sapply(conversion_Matriz[,c(2:(ncol(conversion_Matriz)))], as.numeric)
  
  
  original_types <- read.csv(file=file_instance_types_In,
                             header=FALSE, sep=" ", encoding = "UTF-8", stringsAsFactors = FALSE)
  original_types <- original_types[grep(domain_resourcesURI, original_types$V1),]
  original_types <- original_types[grep('^<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>',original_types$V2),]
  original_types <- original_types[grep('^<http://dbpedia.org/ontology/',original_types$V3),]
  original_types$V4 <- NULL
  names(original_types) <- c("s","p","o")
  guarda_original_types <- original_types
  original_types$s <- as.factor(original_types$s)
  original_types$p <- as.factor(original_types$p)
  original_types$o <- as.factor(original_types$o)
  
  
  nivel1 <- read.csv(file=paste(path_levels,"nivel1.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel2 <- read.csv(file=paste(path_levels,"nivel2.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel3 <- read.csv(file=paste(path_levels,"nivel3.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel4 <- read.csv(file=paste(path_levels,"nivel4.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel5 <- read.csv(file=paste(path_levels,"nivel5.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  nivel6 <- read.csv(file=paste(path_levels,"nivel6.csv",sep=""),
                     header=TRUE, sep=" ", encoding = "UTF-8")
  
  
  original_types <- original_types[,c(1,3)]
  
  soloNivel6 <- original_types[original_types$o %in% nivel6$nivel6, ] 
  
  soloNivel5 <- original_types[original_types$o %in% nivel5$nivel5, ]
  soloNivel5 <- soloNivel5[!(soloNivel5$s %in% soloNivel6$s), ]
  
  soloNivel4 <- original_types[original_types$o %in% nivel4$nivel4, ]
  soloNivel4 <- soloNivel4[!(soloNivel4$s %in% soloNivel5$s), ]
  soloNivel4 <- soloNivel4[!(soloNivel4$s %in% soloNivel6$s), ]
  
  soloNivel3 <- original_types[original_types$o %in% nivel3$nivel3, ]
  soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel4$s), ]
  soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel5$s), ]
  soloNivel3 <- soloNivel3[!(soloNivel3$s %in% soloNivel6$s), ]
  
  soloNivel2 <- original_types[original_types$o %in% nivel2$nivel2, ]
  soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel3$s), ]
  soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel4$s), ]
  soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel5$s), ]
  soloNivel2 <- soloNivel2[!(soloNivel2$s %in% soloNivel6$s), ]
  
  soloNivel1 <- original_types[original_types$o %in% nivel1$nivel1, ]
  soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel2$s), ]
  soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel3$s), ]
  soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel4$s), ]
  soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel5$s), ]
  soloNivel1 <- soloNivel1[!(soloNivel1$s %in% soloNivel6$s), ]
  
  hojas_recursosTypes <- rbind(soloNivel1, soloNivel2, soloNivel3, soloNivel4, soloNivel5, soloNivel6)
  
  #cambiamos la o de object por la s de subject para facilitar el merge en la función posterior
  colnames(conversion_Matriz)[1] <- 's'
  learning_Hojas <- merge(x = conversion_Matriz, y = hojas_recursosTypes, by = 's')
  
  colnames(learning_Hojas)[ncol(learning_Hojas)] <- 'Class'
  write.csv(learning_Hojas, file = file_learningSet_Out, fileEncoding = "UTF-8", row.names=FALSE)
  
  #interesting for analysis, not for continue de workflow, commented
  # datosObjetivo$auxCountIngoing <- rowSums(datosObjetivo[,2:(ncol(datosObjetivo)-11)])
  # countingIngoing <- datosObjetivo[,c(1,ncol(datosObjetivo))]
  # datosObjetivo$auxCountIngoing <- NULL
  # write.csv(countingIngoing, file = pathOtro, fileEncoding = "UTF-8", row.names=FALSE)
  
  rm(list=ls())
  gc(verbose = TRUE)
  
  return(0)
}




