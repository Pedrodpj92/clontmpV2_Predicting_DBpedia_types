#!/usr/bin/env Rscript
#main_predicting_DBpedia_types_P_M_E.R
#P.M.E: Preprocesa, Modela, Evalua

#Habrá otras dos versiones, ..._M_E.R (Modela y Evalua) y ..._Predice.R

library("optparse")
source(paste(getwd(),"/preparating/module_preparating.R",sep=""))
source(paste(getwd(),"/modeling/module_modeling.R",sep=""))
source(paste(getwd(),"/evaluating/module_evaluating.R",sep=""))



option_list <- list(
  make_option(c("-a", "--approach"), type="character", default=NULL, 
              help="approach selected. <global_ap1 | multilevel_ap2 | cascade_ap3>
              global_ap1     - First approach, it learns from most specific type from each resource
              multilevel_ap2 - Second approach, Local Classifiers per Level with binary decisions per level aimed to solve partial depth issue
              cascade_ap3    - Third approach, Local Classifiers per Level with binary decisions per level and cascade process aimed to solve partial depth issue and reduce hierarchy inconcistencies",
              metavar="character"),
  make_option(c("-l", "--algorithm"), type="character", default = NULL,
              help="algorithm used for the approach selected. <NB | C5.0 | DL | RF>.
              NB   - Naïve Bayes. Only in global approach
              C5.0 - Only in multilevel approach
              DL   - Deep Learning
              RF   - Random Forest",
              metavar="character"),
  make_option(c("-c","--cross_validation", type="logical", default = NULL),
              help="notify if divide process should be a simple split (train/test) or should be a cross_validation. <TRUE | FALSE>",
              metavar="logical"),
  make_option(c("-t","--test_ingoingCondition", type="integer", default = NULL),
              help="minimum amount of properties per resource reserved for tests. Only available on simple split (-c FALSE)",
              metavar="integer"),
  make_option(c("-n","--number_casesOrFolds", type="integer", default = NULL),
              help="Points out the number of cases or the folds used depending on -cv condition option",
              metavar = "integer"),
  make_option(c("-d","--domain", type="character", default = NULL),
              help="how starts URI's DBpedia resources. <EN | ES>",
              metavar="character"),#esto seguramente deba modificarlo
  make_option(c("-v","--versionOntology", type="character", default = NULL),
              help="DBpedia ontology version. <39 | 2014 | 201610>",
              metavar="character"),
  make_option(c("-m","--mapping_based_properties", type="character", default = NULL),
              help="path to input mapping_based_properties.ttl. In modern DBpedia versions it may be mapping_based_objects.ttl, it works well so.",
              metavar="character"),
  make_option(c("-i","--instance_types", type="character", default = NULL),
              help="path to input instance_types.ttl In modern DBpedia versions it may be splitted in 2 files, transitive and 'ending' (leves) types.
              This main program assumes that types file are completed, so in case of divided files, should be merged previously",
              metavar="character"),
  make_option(c("-o", "--pathOut"), type="character", default = NULL,
              help="path to output files. Directory should exist previously",
              metavar="character"),
  make_option(c("-f", "--fileOut"), type="character", default = "output",
              help="files' output identifier or name to track files about same experiment [default= %default]",
              metavar="character"),
  make_option(c("-s","--seed"), type="integer", default = 1234,
              help="random number generator seed for algorithms that are dependent on randomization [default= %default]",
              metavar = "integer"),
  make_option(c("-x","--executionMode"), type="integer", default = NULL,
              help="this main is divided in 3 modules: preprocesing, modeling, evaluating (predicting). Flag -x or --executionMode specify where should start this main script. <P_M_E | M_E | E>",
              metavar = "integer")
)


opt_parser <- OptionParser(usage = "Usage: %prog <options>",
                           description = "Description:
                           updating........",
                           epilogue = "Examples:
                             -> using multilevel approach (2) with Random Forest algorithm and fiveFold test. Check out input folder is the first path showed with -i flag and generated files will be located at second path, as -o flag shows. Look for files with 'output_ap2_5f_execution1' to find related outputs with your experiment.
                           %prog -a multilevel_ap2 -l RF -t fiveFold -i /home/myExperiments/aboutDBpedia_hierarchyClasssifiers/approach2/crossValidation/ -o /home/myExperiments/aboutDBpedia_hierarchyClasssifiers/approach2/crossValidation/output/ -f output_ap2_5f_execution1
                             -> using cascade approach (3) with Deep Learning algorithm and test 25 (resources with at least 25 ingoing properties). Watch out in this example where related paths are used instance of absolute paths. 
                           %prog -a cascade_ap3 -l DL -t test25 -i ./data/ap3/t25/ -o ./output/ap3_t25/ -f out_ap3_t25_execution7
                           
                           ACTUALIZAR....
                           
                           Ejemplo nuevo, integrar cuando sea posible
                           ./main_predicting_DBpedia_types_V2.R -a multilevel_ap2 -l RF -c FALSE -t 10 -n 3000 -d ES -v 39 -m path_dummy_properties -i path_dummy_types -o path_dummy_output


                           otro ejemplo....
                           ./main_predicting_DBpedia_types_V2.R -a multilevel_ap2 -l RF -c TRUE -n 5 -d ES -v 2014 -m path_dummy_properties -i path_dummy_types -o path_dummy_output",
                           option_list=option_list)


opt <- parse_args(opt_parser)

#options restrictions
if(is.null(opt$approach) || !(opt$approach %in% c("global_ap1","multilevel_ap2","cascade_ap3"))){
  print_help(opt_parser)
  stop("Please, select one approach using -a or --approach options: <global_ap1 | multilevel_ap2 | cascade_ap3>", call.=FALSE)
}
if(is.null(opt$algorithm) || !(opt$algorithm %in% c("NB","C5.0","DL","RF"))){
  print_help(opt_parser)
  stop("Please, select one algorithm using -l or --algorithm options: <NB | C5.0 | DL | RF>", call.=FALSE)
}
if(is.null(opt$cross_validation) || !(as.character(opt$cross_validation) %in% c("TRUE","FALSE"))){
  print_help(opt_parser)
  stop("Please, select one validation mode using -c or --cross_validation otpions: <TRUE | FALSE>", call.=FALSE)
}
if(is.null(opt$test_ingoingCondition) && !(as.logical(opt$cross_validation))){
  print_help(opt_parser)
  stop("test_ingoingCondition argument must be supplied if cross_validation is FALSE", call.=FALSE)
}
if(is.null(opt$number_casesOrFolds)){
  print_help(opt_parser)
  stop("number_casesOrFolds argument must be supplied", call.=FALSE)
}
if(is.null(opt$domain) || !(opt$domain %in% c("EN","ES"))){
  print_help(opt_parser)
  stop("Please, select one DBpedia language using -d or --domain options : <EN | ES>", call.=FALSE)
}
if(is.null(opt$versionOntology) || !(opt$versionOntology %in% c("39","2014","201610"))){
  print_help(opt_parser)
  stop("Please, select one DBpedia ontolgy version using -v or --versionOntology options : <39 | 2014 | 201610>", call.=FALSE)
}
if(is.null(opt$mapping_based_properties)){
  print_help(opt_parser)
  stop("mapping_based_properties argument must be supplied using -m or --mapping_based_properties options", call.=FALSE)
}
if(is.null(opt$instance_types)){
  print_help(opt_parser)
  stop("instance_types argument must be supplied using -i or --instance_types options", call.=FALSE)
}
if(is.null(opt$pathOut)){
  print_help(opt_parser)
  stop("pathOut argument must be supplied (files output's path) using -o or --pathOut options", call.=FALSE)
}
if(is.null(opt$executionMode)){
  print_help(opt_parser)
  stop("Please, select one execution mode using -x or --executionMode options : <P_M_E | M_E | E>", call.=FALSE)
}

#second round
if(opt$approach %in% c("global_ap1") && !(opt$algorithm %in% c("NB","DL","RF"))){
  print_help(opt_parser)
  stop("global approach (approach1) can just be executed with Naive Bayes, Deep Learning or Random Forest.", call.=FALSE)
}
if(opt$approach %in% c("multilevel_ap2") && !(opt$algorithm %in% c("C5.0","DL","RF"))){
  print_help(opt_parser)
  stop("multilevel approach (approach2) can just be executed with C5.0, Deep Learning or Random Forest.", call.=FALSE)
}
#modificar acordemente
if(!(opt$approach %in% c("multilevel_ap2")) && opt$test %in% c("fiveFold")){
  print_help(opt_parser)
  stop("fiveFold test can just be executed with multilevel approach (approach2).", call.=FALSE)
}
if(opt$approach %in% c("cascade_ap3") && !(opt$algorithm %in% c("DL","RF"))){
  print_help(opt_parser)
  stop("cascade approach (approach3) can just be executed with Deep Learning or Random Forest.", call.=FALSE)
}
if(!is.null(opt$test_ingoingCondition) && as.logical(opt$cross_validation)){
  print_help(opt_parser)
  stop("test_ingoingCondition argument should not be supplied if cross_validation is TRUE", call.=FALSE)
}



dominio <- '^<http://dbpedia.org/resource/' #de momento, inglés por defecto
if(opt$domain %in% c("ES")){
  dominio <- '^<http://es.dbpedia.org/resource/'
}else if(opt$domain %in% c("EN")){
  dominio <- '^<http://dbpedia.org/resource/'
} else{
  print("error, mejorar aviso, aunque nunca debería llegar a este punto")
}

ontologia <- "39"
if(opt$versionOntology %in% c("39")){
  ontologia <- "39"
}else if(opt$versionOntology %in% c("2014")){
  ontologia <- "2014"
}else if(opt$versionOntology %in% c("201610")){
  ontologia <- "201610"
}else{
  print("error, mejorar aviso, aunque nunca debería llegar a este punto")
}

if(opt$approach %in% c("global_ap1")){
  isApproach1 <- TRUE
} else{
  isApproach1 <- FALSE
}


if(opt$executionMode %in% c("P_M_E")){
  preprocesa(file_mapping_based_properties_In = opt$mapping_based_properties,
             file_instance_types_In = opt$instance_types,
             domain_resources = dominio,
             path_levels = paste(getwd(),"/levels_ontology/",ontologia,"/",sep=""),
             isCrossValidation = as.logical(opt$cross_validation),
             isApproach1 = isApproach1,
             path_splits_Out = paste(getwd(),"/intermediateData/",sep=""),
             path_files_trainValidate_Out = paste(getwd(),"/intermediateData/",sep=""),
             file_training_Out = "trainingTest.csv",
             file_validating_Out = "validatingTest.csv",
             semilla = opt$seed,
             nSplits = opt$number_casesOrFolds,
             n_cases_validating = opt$number_casesOrFolds,
             test1_10_25 = opt$test_ingoingCondition,
             tr_l2 = "trainingTest_knownResources_L2.csv", #Al tratarse de archivos intermedios el usuario no tiene por qué saber de su existencia
             vl_l2 = "validatingTest_knownResources_L2.csv",
             tr_l3 = "trainingTest_knownResources_L3.csv",
             vl_l3 = "validatingTest_knownResources_L3.csv",
             tr_l4 = "trainingTest_knownResources_L4.csv",
             vl_l4 = "validatingTest_knownResources_L4.csv",
             tr_l5 = "trainingTest_knownResources_L5.csv",
             vl_l5 = "validatingTest_knownResources_L5.csv",
             tr_l6 = "trainingTest_knownResources_L6.csv",
             vl_l6 = "validatingTest_knownResources_L6.csv",
             reservados = "reserva.ttl")
}


if(opt$executionMode %in% c("P_M_E","M_E")){
  modela(approachSelected = opt$approach,
         algorithmSelected = opt$algorithm,
         semilla = opt$seed,
         isCrossValidation = as.logical(opt$cross_validation),
         nSplits = opt$number_casesOrFolds,
         pathInput = paste(getwd(),"/intermediateData/",sep=""),
         pathOutput = opt$pathOut,
         pathOutputModel = opt$pathOut,
         nameOutputFile = opt$fileOut,
         tr = "trainingTest.csv",
         vl = "validatingTest.csv",
         tr_l2 = "trainingTest_knownResources_L2.csv",
         vl_l2 = "validatingTest_knownResources_L2.csv",
         tr_l3 = "trainingTest_knownResources_L3.csv",
         vl_l3 = "validatingTest_knownResources_L3.csv",
         tr_l4 = "trainingTest_knownResources_L4.csv",
         vl_l4 = "validatingTest_knownResources_L4.csv",
         tr_l5 = "trainingTest_knownResources_L5.csv",
         vl_l5 = "validatingTest_knownResources_L5.csv",
         tr_l6 = "trainingTest_knownResources_L6.csv",
         vl_l6 = "validatingTest_knownResources_L6.csv")
}

# #TO-DO: función que coja de entrada la carpeta con los modelos y un conjunto de datos y realice predicciones
# if(opt$executionMode %in% c("E")){
#   #predice(...)
# }


if(as.logical(opt$cross_validation)){
  for(i in 1:as.numeric(opt$number_casesOrFolds)){
    evalua(pathDT_GeneradoCompleto = paste(opt$pathOut,"fold",i,"/",opt$fileOut,".ttl",sep=""),
           pathDT_ReservadoCompleto = paste(getwd(),"/intermediateData/","fold",i,"/","reserva.ttl",sep=""),
           pathNivelesCompleto = paste(getwd(),"/levels_ontology/",ontologia,"/",sep=""),
           pathSalida = paste(opt$pathOut,"fold",i,"/","evaluacion_",opt$fileOut,".csv",sep=""))
  }
}else{
  evalua(pathDT_GeneradoCompleto = paste(opt$pathOut,opt$fileOut,".ttl",sep=""),
         pathDT_ReservadoCompleto = paste(getwd(),"/intermediateData/reserva.ttl",sep=""),
         pathNivelesCompleto = paste(getwd(),"/levels_ontology/",ontologia,"/",sep=""),
         pathSalida = paste(opt$pathOut,"evaluacion_",opt$fileOut,".csv",sep=""))
}

