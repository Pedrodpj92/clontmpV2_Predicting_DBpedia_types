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
              help="approach selected. <global_ap1 | multilevel_ap2 | cascade_ap3>.
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
              help="decide whether the divide process should be a simple split (train/test) or should be a cross_validation. <TRUE | FALSE>",
              metavar="logical"),
  make_option(c("-t","--test_ingoingCondition", type="integer", default = NULL),
              help="minimum amount of properties per resource reserved for tests. Only available on simple split (-c FALSE)",
              metavar="integer"),
  make_option(c("-n","--number_casesOrFolds", type="integer", default = NULL),
              help="the number of cases or the folds used depending on -c condition option",
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
              help="path to input instance_types.ttl In modern DBpedia versions it may be splitted in 2 files, transitive and 'ending' (leaves) types.
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
  make_option(c("-x","--executionMode"), type="character", default = NULL,
              help="this main is divided in 3 modules: preprocesing, modeling, evaluating (predicting). Flag -x or --executionMode specify where this main script should start. This is useful, for instance, to generate the same train/validation data once and execute several approaches and/or algorithms. <P_M_E | M_E | E>",
              metavar = "character")
)


opt_parser <- OptionParser(usage = "Usage: %prog <options>",
                           description = "Description:
                           This software provides a complete Data Mining workflow for inferring new DBpedia types on resources which are found as objects.
                           ",
                           epilogue = "Examples:
                             ./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 1 -n 2500 -d ES -v 201610 -m ~/inputData/mappingbased_objects_uncleaned_es.ttl -i ~/inputData/instance_types_completo_es.ttl -o ~/outputData/ -f ejecucion1_app1_DL_test1 -s 1234 -x P_M_E
                            
                            In this case, The program will use first approach (global) with a deep learning algoritm, with one train/validate split where 2500 validation cases have at least 1 ingoing property. This case is used on EsDBpedia with the 2016-10 ontology. After that, we specify both input data (properties and types) followed by output path, and files identifier. All processes will use '1234' as random seed. The -x option will indicate a full workflow (preprocesing, modeling and evaluating)
                           ",
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
ontologia_owl <- "dbpedia_3.9.owl"
if(opt$versionOntology %in% c("39")){
  ontologia <- "39"
  ontologia_owl <- "dbpedia_3.9.owl"
}else if(opt$versionOntology %in% c("2014")){
  ontologia <- "2014"
  ontologia_owl <- "dbpedia_2014.owl"
}else if(opt$versionOntology %in% c("201610")){
  ontologia <- "201610"
  ontologia_owl <- "dbpedia_2016-10.owl"
}else{
  print("error, mejorar aviso, aunque nunca debería llegar a este punto")
}

if(opt$approach %in% c("global_ap1")){
  isApproach1 <- TRUE
} else{
  isApproach1 <- FALSE
}


if(opt$executionMode %in% c("P_M_E")){
  preprocessing(file_mapping_based_properties_In = opt$mapping_based_properties,
                file_instance_types_In = opt$instance_types,
                domain_resources = dominio,
                path_levels = paste(getwd(),"/levels_ontology/",ontologia,"/",sep=""),
                isCrossValidation = as.logical(opt$cross_validation),
                isApproach1 = isApproach1,
                path_splits_Out = paste(getwd(),"/intermediateData/",sep=""),
                path_files_trainValidate_Out = paste(getwd(),"/intermediateData/",sep=""),
                file_training_Out = "trainingTest.csv",
                file_validating_Out = "validatingTest.csv",
                randomSeed = opt$seed,
                nSplits = opt$number_casesOrFolds,
                n_cases_validating = opt$number_casesOrFolds,
                test1_10_25 = opt$test_ingoingCondition,
                tr_l2 = "trainingTest_knownResources_L2.csv", #Al tratarse de archivos intermedios se puede dejar así, aunque estaría bien mejorar esta parte
                vl_l2 = "validatingTest_knownResources_L2.csv",
                tr_l3 = "trainingTest_knownResources_L3.csv",
                vl_l3 = "validatingTest_knownResources_L3.csv",
                tr_l4 = "trainingTest_knownResources_L4.csv",
                vl_l4 = "validatingTest_knownResources_L4.csv",
                tr_l5 = "trainingTest_knownResources_L5.csv",
                vl_l5 = "validatingTest_knownResources_L5.csv",
                tr_l6 = "trainingTest_knownResources_L6.csv",
                vl_l6 = "validatingTest_knownResources_L6.csv",
                reserved = "reserva.ttl")
  
  if(isApproach1){
    
    
    
    
    system(command = paste("java -jar ",
                           getwd(),"/levels_ontology/dbotypes.jar ",
                           getwd(),"/levels_ontology/",ontologia_owl,
                           " ",
                           paste(getwd(),"/intermediateData/reserva.ttl",sep=""),
                           sep=""))
    system(command = paste("mv ",
                           paste(getwd(),"/intermediateData/reserva.ttl.extended.csv",sep=""),
                           " ",
                           paste(getwd(),"/intermediateData/reserva.ttl",sep=""),sep=""))
  }
}

# system(command = paste("cp ",
#                        paste(getwd(),"/intermediateData/reserva.ttl",sep=""),
#                        " ",
#                        paste(getwd(),"/intermediateData/reserva_a_ver_que_tiene.ttl",sep=""),
#                        sep=""))


if(opt$executionMode %in% c("P_M_E","M_E")){
  modeling(approachSelected = opt$approach,
           algorithmSelected = opt$algorithm,
           randomSeed = opt$seed,
           isCrossValidation = as.logical(opt$cross_validation),
           nSplits = opt$number_casesOrFolds,
           ontology = ontologia_owl,
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
    evaluating(pathDT_GeneratedCompleted = paste(opt$pathOut,"fold",i,"/",opt$fileOut,".ttl",sep=""),
               pathDT_ReservedCompleted = paste(getwd(),"/intermediateData/","fold",i,"/","reserva.ttl",sep=""),
               pathLevelsCompleted = paste(getwd(),"/levels_ontology/",ontologia,"/",sep=""),
               pathOutput = paste(opt$pathOut,"fold",i,"/","evaluacion_",opt$fileOut,".csv",sep=""))
  }
}else{
  evaluating(pathDT_GeneratedCompleted = paste(opt$pathOut,opt$fileOut,".ttl",sep=""),
             pathDT_ReservedCompleted = paste(getwd(),"/intermediateData/reserva.ttl",sep=""),
             pathLevelsCompleted = paste(getwd(),"/levels_ontology/",ontologia,"/",sep=""),
             pathOutput = paste(opt$pathOut,"evaluacion_",opt$fileOut,".csv",sep=""))
}

