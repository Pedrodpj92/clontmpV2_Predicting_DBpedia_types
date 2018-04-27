#!/usr/bin/env Rscript
#module_modeling.R

#TO-DO: terminar llamadas de cross-validation (con app2) y testeo simple (con app2 y app3) HECHO
#TO-DO: añadir módulo de evaluación (module_evaluating.R), llamará a evalua_completo() y a las funciones de cálculo de medias y desviación típica cuando sea validación cruzada
#TO-DO: añadir los 3 modulos (preparación, modelado y evaluación) al main
#EXTRA: cuando todo eso esté, añadir al módulo de modelado una fase de predicción para cargar modelos ya entrenados para saltarnos ese paso


source(paste(getwd(),"/modeling/approach1/approach1_globalApproach.R",sep=""))
source(paste(getwd(),"/modeling/approach2/approach2_multilevel.R",sep=""))
source(paste(getwd(),"/modeling/approach3/approach3_multilevel_onCascade.R",sep=""))

modeling <- function(approachSelected,
                     algorithmSelected,
                     randomSeed,
                     isCrossValidation,
                     nSplits, #only if isCrossValidation == TRUE
                     ontology,
                     pathInput,
                     pathOutput,
                     pathOutputModel,
                     nameOutputFile,
                     tr,
                     vl,
                     tr_l2, vl_l2, tr_l3, vl_l3, tr_l4, vl_l4, tr_l5, vl_l5, tr_l6, vl_l6){
  
  # print("comienzo el modulo de modelado")
  if(as.logical(isCrossValidation)){
    if(approachSelected %in% c("multilevel_ap2")){
      nSplits <- as.numeric(nSplits)
      print("numero nSplits: ")
      print(nSplits)
      if(algorithmSelected %in% c("C5.0")){
        for(i in 1:nSplits){
          print("empiezo la iteracion: ")
          print(i)
          dir.create(paste(pathOutput,"fold",i,sep=""))
          app2_C50(randomSeed = randomSeed,
                   pathInput = paste(pathInput,"fold",i,"/",sep=""),
                   pathOutputModel = paste(pathOutputModel,"fold",i,"/",sep=""),
                   pathOutput = paste(pathOutput,"fold",i,"/",sep=""),
                   nameOutputFile = nameOutputFile,
                   tr = tr, vl = vl,
                   tr_l2 = tr_l2, vl_l2 = tr_l2,
                   tr_l3 = tr_l3, vl_l3 = tr_l3,
                   tr_l4 = tr_l4, vl_l4 = tr_l4,
                   tr_l5 = tr_l5, vl_l5 = tr_l5)
        }
      }else if(algorithmSelected %in% c("DL")){
        for(i in 1:nSplits){
          dir.create(paste(pathOutput,"fold",i,sep=""))
          app2_DL(randomSeed = randomSeed,
                  pathInput = paste(pathInput,"fold",i,"/",sep=""),
                  pathOutputModel = paste(pathOutputModel,"fold",i,"/",sep=""),
                  pathOutput = paste(pathOutput,"fold",i,"/",sep=""),
                  nameOutputFile = nameOutputFile,
                  tr = tr, vl = vl,
                  tr_l2 = tr_l2, vl_l2 = tr_l2,
                  tr_l3 = tr_l3, vl_l3 = tr_l3,
                  tr_l4 = tr_l4, vl_l4 = tr_l4,
                  tr_l5 = tr_l5, vl_l5 = tr_l5)
        }
      }else if(algorithmSelected %in% c("RF")){
        for(i in 1:nSplits){
          dir.create(paste(pathOutput,"fold",i,sep=""))
          print("empiezo a iteracion: ")
          print(i)
          app2_RF(randomSeed = randomSeed,
                  pathInput = paste(pathInput,"fold",i,"/",sep=""),
                  pathOutputModel = paste(pathOutputModel,"fold",i,"/",sep=""),
                  pathOutput = paste(pathOutput,"fold",i,"/",sep=""),
                  nameOutputFile = nameOutputFile,
                  tr = tr, vl = vl,
                  tr_l2 = tr_l2, vl_l2 = tr_l2,
                  tr_l3 = tr_l3, vl_l3 = tr_l3,
                  tr_l4 = tr_l4, vl_l4 = tr_l4,
                  tr_l5 = tr_l5, vl_l5 = tr_l5)
        }
      }else{
        stop("multilevel approach (approach2) can just be executed with C5.0, Deep Learning or Random Forest.", call.=FALSE)
      }
    }
  }
  else{
    if(approachSelected %in% c("global_ap1")){
      if(algorithmSelected %in% c("NB")){
        app1_nb(randomSeed = randomSeed,
                pathInput = pathInput,
                pathOutput = pathOutput,
                pathOutputModel = pathOutputModel,
                nameOutputFile = nameOutputFile,
                tr = tr,
                vl = vl)
        # system(command = paste("java -jar ",getwd(),"/levels_ontology/dbotypes.jar ",
        #                        getwd(),"/levels_ontology/dbpedia_3.9.owl ",paste(pathOutput,
        #                                                                          nameOutputFile,"_nb.ttl",sep = ""),sep=""))
      }else if(algorithmSelected %in% c("DL")){
        app1_dl(randomSeed = randomSeed,
                pathInput = pathInput,
                pathOutput = pathOutput,
                pathOutputModel = pathOutputModel,
                nameOutputFile = nameOutputFile,
                tr = tr,
                vl = vl)
        # system(command = paste("java -jar ",getwd(),"/levels_ontology/dbotypes.jar ",
        #                        getwd(),"/levels_ontology/dbpedia_3.9.owl ",paste(pathOutput,
        #                                                                          nameOutputFile,"_nb.ttl",sep = ""),sep=""))
      }else if(algorithmSelected %in% c("RF")){
        app1_rf(randomSeed = randomSeed,
                pathInput = pathInput,
                pathOutput = pathOutput,
                pathOutputModel = pathOutputModel,
                nameOutputFile = nameOutputFile,
                tr = tr,
                vl = vl)
        # system(command = paste("java -jar ",getwd(),"/levels_ontology/dbotypes.jar ",
        #                        getwd(),"/levels_ontology/dbpedia_3.9.owl ",paste(pathOutput,
        #                                                                          nameOutputFile,"_rf.ttl",sep = ""),sep=""))
      }else{
        stop("global approach (approach1) can just be executed with Naive Bayes, Deep Learning or Random Forest.", call.=FALSE)
      }
      system(command = paste("java -jar ",
                             getwd(),"/levels_ontology/dbotypes.jar ",
                             getwd(),"/levels_ontology/",ontology,
                             " ",
                             paste(pathOutput,
                                   nameOutputFile,".ttl",sep = ""),sep=""))
      system(command = paste("mv ",
                             paste(pathOutput,
                                   nameOutputFile,".ttl.extended.csv",sep = ""),
                             " ",
                             paste(pathOutput,
                                   nameOutputFile,".ttl",sep = ""),sep=""))
    }else if(approachSelected %in% c("multilevel_ap2")){
      if(algorithmSelected %in% c("C5.0")){
        app2_C50(randomSeed = randomSeed,
                 pathInput = pathInput,
                 pathOutputModel = pathOutputModel,
                 pathOutput = pathOutput,
                 nameOutputFile = nameOutputFile,
                 tr = tr, vl = vl,
                 tr_l2 = tr_l2, vl_l2 = tr_l2,
                 tr_l3 = tr_l3, vl_l3 = tr_l3,
                 tr_l4 = tr_l4, vl_l4 = tr_l4,
                 tr_l5 = tr_l5, vl_l5 = tr_l5)
      }else if(algorithmSelected %in% c("DL")){
        app2_DL(randomSeed = randomSeed,
                pathInput = pathInput,
                pathOutputModel = pathOutputModel,
                pathOutput = pathOutput,
                nameOutputFile = nameOutputFile,
                tr = tr, vl = vl,
                tr_l2 = tr_l2, vl_l2 = tr_l2,
                tr_l3 = tr_l3, vl_l3 = tr_l3,
                tr_l4 = tr_l4, vl_l4 = tr_l4,
                tr_l5 = tr_l5, vl_l5 = tr_l5)
      }else if(algorithmSelected %in% c("RF")){
        app2_RF(randomSeed = randomSeed,
                pathInput = pathInput,
                pathOutputModel = pathOutputModel,
                pathOutput = pathOutput,
                nameOutputFile = nameOutputFile,
                tr = tr, vl = vl,
                tr_l2 = tr_l2, vl_l2 = tr_l2,
                tr_l3 = tr_l3, vl_l3 = tr_l3,
                tr_l4 = tr_l4, vl_l4 = tr_l4,
                tr_l5 = tr_l5, vl_l5 = tr_l5)
      }else{
        stop("multilevel approach (approach2) can just be executed with C5.0, Deep Learning or Random Forest.", call.=FALSE)
      }
    }else if(approachSelected %in% c("cascade_ap3")){
      if(algorithmSelected %in% c("DL")){
        app3_DL(randomSeed = randomSeed,
                pathInput = pathInput,
                pathOutputModel = pathOutputModel,
                pathOutput = pathOutput,
                nameOutputFile = nameOutputFile,
                tr = tr, vl = vl,
                tr_l2 = tr_l2, vl_l2 = tr_l2,
                tr_l3 = tr_l3, vl_l3 = tr_l3,
                tr_l4 = tr_l4, vl_l4 = tr_l4,
                tr_l5 = tr_l5, vl_l5 = tr_l5)
      }else if(algorithmSelected %in% c("RF")){
        app3_RF(randomSeed = randomSeed,
                pathInput = pathInput,
                pathOutputModel = pathOutputModel,
                pathOutput = pathOutput,
                nameOutputFile = nameOutputFile,
                tr = tr, vl = vl,
                tr_l2 = tr_l2, vl_l2 = tr_l2,
                tr_l3 = tr_l3, vl_l3 = tr_l3,
                tr_l4 = tr_l4, vl_l4 = tr_l4,
                tr_l5 = tr_l5, vl_l5 = tr_l5)
      }else{
        stop("cascade approach (approach3) can just be executed with Deep Learning or Random Forest.", call.=FALSE)
      }
    }else{
      stop("not proper approach selected, please, select one avaliable <global_ap1 | multilevel_ap2 | cascade_ap3> ", call.=FALSE)
    }
  }
  
  # print("acabo el modulo de modelado")
}

predice <- function(approachSelected,
                    algorithmSelected,
                    randomSeed,
                    pathInput,
                    pathOutput,
                    pathOutputModel,
                    nameOutputFile,
                    tr,
                    vl,
                    tr_l2, vl_l2, tr_l3, vl_l3, tr_l4, vl_l4, tr_l5, vl_l5, tr_l6, vl_l6){
  
  
  
}
