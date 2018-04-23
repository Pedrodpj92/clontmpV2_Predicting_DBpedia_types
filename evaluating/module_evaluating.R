#!/usr/bin/env Rscript
#module_evaluating.R


source(paste(getwd(),"/evaluating/evaluate_complete.R",sep=""))

evalua <- function(pathDT_GeneradoCompleto,
                   pathDT_ReservadoCompleto,
                   pathNivelesCompleto,
                   pathSalida){
  print("comienzo el modulo de evaluacion")
  evalua_completo(pathDT_GeneradoCompleto, pathDT_ReservadoCompleto, pathNivelesCompleto, pathSalida)
  print("acabo el modulo de evaluacion")
}




