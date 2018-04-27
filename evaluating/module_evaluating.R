#!/usr/bin/env Rscript
#module_evaluating.R


source(paste(getwd(),"/evaluating/evaluate_complete.R",sep=""))

evaluating <- function(pathDT_GeneratedCompleted,
                   pathDT_ReservedCompleted,
                   pathLevelsCompleted,
                   pathOutput){
  print("comienzo el modulo de evaluacion")
  evalua_completed(pathDT_GeneratedCompleted, pathDT_ReservedCompleted, pathLevelsCompleted, pathOutput)
  print("acabo el modulo de evaluacion")
}




