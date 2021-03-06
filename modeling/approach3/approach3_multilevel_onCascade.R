#!/usr/bin/env Rscript
#approach3_multilevel_onCascade.R
source(paste(getwd(),"/monitoring/monitor_funs.R",sep=""))

app3_DL <- function(randomSeed, pathInput, pathOutput, pathOutputModel, nameOutputFile,
                    tr, vl, tr_l2, vl_l2, tr_l3, vl_l3, tr_l4, vl_l4, tr_l5, vl_l5){
  
  
  library(h2o)
  h2o.init(
    nthreads=-1            ## -1: use all available threads
    #max_mem_size = "2G"
  )
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_DL",isAfter = FALSE)
  
  df_training <- h2o.importFile(path = normalizePath(paste(pathInput,tr,sep = '')), header = TRUE)
  df_validating <- h2o.importFile(path = normalizePath(paste(pathInput,vl,sep = '')), header = TRUE)
  
  df_training_sinDesc_N2 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l2,sep = '')), header = TRUE)
  df_validating_sinDesc_N2 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l2,sep = '')), header = TRUE)
  df_training_sinDesc_N3 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l3,sep = '')), header = TRUE)
  df_validating_sinDesc_N3 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l3,sep = '')), header = TRUE)
  df_training_sinDesc_N4 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l4,sep = '')), header = TRUE)
  df_validating_sinDesc_N4 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l4,sep = '')), header = TRUE)
  df_training_sinDesc_N5 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l5,sep = '')), header = TRUE)
  df_validating_sinDesc_N5 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l5,sep = '')), header = TRUE)
  
  train <- h2o.assign(df_training, "train.hex") 
  valid <- h2o.assign(df_validating, "valid.hex")
  
  train_sinDesc_N2 <- h2o.assign(df_training_sinDesc_N2, "train_sinDesc_N2.hex") 
  valid_sinDesc_N2 <- h2o.assign(df_validating_sinDesc_N2, "valid_sinDesc_N2.hex")
  train_sinDesc_N3 <- h2o.assign(df_training_sinDesc_N3, "train_sinDesc_N3.hex") 
  valid_sinDesc_N3 <- h2o.assign(df_validating_sinDesc_N3, "valid_sinDesc_N3.hex")
  train_sinDesc_N4 <- h2o.assign(df_training_sinDesc_N4, "train_sinDesc_N4.hex") 
  valid_sinDesc_N4 <- h2o.assign(df_validating_sinDesc_N4, "valid_sinDesc_N4.hex")
  train_sinDesc_N5 <- h2o.assign(df_training_sinDesc_N5, "train_sinDesc_N5.hex") 
  valid_sinDesc_N5 <- h2o.assign(df_validating_sinDesc_N5, "valid_sinDesc_N5.hex")
  
  
  dl_n1 <- h2o.deeplearning(
    model_id="dl_n1",
    training_frame=train,
    validation_frame=valid[,2:(ncol(valid)-10)],
    x=2:(ncol(train)-11),
    y=(ncol(train)-10),
    stopping_rounds = 0,
    seed = randomSeed)
  # summary(dl_nivel1_v2)
  h2o.saveModel(dl_n1, path=pathOutputModel)
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_DL level 1",isAfter = TRUE)
  
  # h2o.init(
  #   nthreads=-1            ## -1: use all available threads
  #   #max_mem_size = "2G"
  # )
  ##Nivel 2
  dl_n2_m1 <- h2o.deeplearning(
    model_id="dl_n2_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-8))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-8),
    stopping_rounds = 0,
    seed = randomSeed)
  # summary(dl_n2_m1)
  h2o.saveModel(dl_n2_m1, path=pathOutputModel)
  # h2o.init(
  #   nthreads=-1            ## -1: use all available threads
  #   #max_mem_size = "2G"
  # )
  dl_n2_m4 <- h2o.deeplearning(
    model_id="dl_n2_m4",
    training_frame=train_sinDesc_N2,
    validation_frame=valid_sinDesc_N2[,c(2:(ncol(valid_sinDesc_N2)-10),(ncol(valid_sinDesc_N2)-9))],
    x=2:(ncol(train_sinDesc_N2)-10),
    y=(ncol(train_sinDesc_N2)-9),
    stopping_rounds = 0,
    seed = randomSeed)
  # summary(dl_n2_m4)
  h2o.saveModel(dl_n2_m4, path=pathOutputModel)
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_DL level 2",isAfter = TRUE)
  
  # h2o.init(
  # nthreads=-1            ## -1: use all available threads
  #max_mem_size = "2G"
  # )
  ###Nivel 3
  dl_n3_m1 <- h2o.deeplearning(
    model_id="dl_n3_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-6))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-6),
    stopping_rounds = 0,
    seed = randomSeed)
  #summary(dl_n3_m1)
  h2o.saveModel(dl_n3_m1, path=pathOutputModel)
  
  # h2o.init(
  #   nthreads=-1            ## -1: use all available threads
  #   #max_mem_size = "2G"
  # )
  dl_n3_m4 <- h2o.deeplearning(
    model_id="dl_n3_m4",
    training_frame=train_sinDesc_N3,
    validation_frame=valid_sinDesc_N3[,c(2:(ncol(valid_sinDesc_N3)-8),(ncol(valid_sinDesc_N3)-7))],
    x=2:(ncol(train_sinDesc_N3)-8),
    y=(ncol(train_sinDesc_N3)-7),
    stopping_rounds = 0,
    seed = randomSeed)
  #summary(dl_n3_m4)
  h2o.saveModel(dl_n3_m4, path=pathOutputModel)
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_DL level 3",isAfter = TRUE)
  
  # h2o.init(
  #   nthreads=-1            ## -1: use all available threads
  #   #max_mem_size = "2G"
  # )
  ###Nivel 4
  dl_n4_m1 <- h2o.deeplearning(
    model_id="dl_n4_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-6),(ncol(valid)-4))],
    x=2:(ncol(train)-6),
    y=(ncol(train)-4),
    stopping_rounds = 0,
    seed = randomSeed)
  #summary(dl_n4_m1)
  h2o.saveModel(dl_n4_m1, path=pathOutputModel)
  
  # h2o.init(
  #   nthreads=-1            ## -1: use all available threads
  #   #max_mem_size = "2G"
  # )
  dl_n4_m4 <- h2o.deeplearning(
    model_id="dl_n4_m4",
    training_frame=train_sinDesc_N4,
    validation_frame=valid_sinDesc_N4[,c(2:(ncol(valid_sinDesc_N4)-6),(ncol(valid_sinDesc_N4)-5))],
    x=2:(ncol(train_sinDesc_N4)-6),
    y=(ncol(train_sinDesc_N4)-5),
    stopping_rounds = 0,
    seed = randomSeed)
  #summary(dl_n4_m4)
  h2o.saveModel(dl_n4_m4, path=pathOutputModel)
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_DL level 4",isAfter = TRUE)
  
  # h2o.init(
  #   nthreads=-1            ## -1: use all available threads
  #   #max_mem_size = "2G"
  # )
  ###Nivel 5
  dl_n5_m1 <- h2o.deeplearning(
    model_id="dl_n5_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-2))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-2),
    stopping_rounds = 0,
    seed = randomSeed)
  #summary(dl_n5_m1)
  h2o.saveModel(dl_n5_m1, path=pathOutputModel)
  
  # h2o.init(
  #   nthreads=-1            ## -1: use all available threads
  #   #max_mem_size = "2G"
  # )
  dl_n5_m4 <- h2o.deeplearning(
    model_id="dl_n5_m4",
    training_frame=train_sinDesc_N5,
    validation_frame=valid_sinDesc_N5[,c(2:(ncol(valid_sinDesc_N5)-4),(ncol(valid_sinDesc_N5)-3))],
    x=2:(ncol(train_sinDesc_N5)-3),
    y=(ncol(train_sinDesc_N5)-3),
    stopping_rounds = 0,
    seed = randomSeed)
  #summary(dl_n5_m4)
  h2o.saveModel(dl_n5_m4, path=pathOutputModel)
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_DL level 5",isAfter = TRUE)
  
  #####predicción
  validation_dl <- valid[,1:(ncol(valid)-11)]
  
  test_n1 <- h2o.predict(object = dl_n1, newdata = validation_dl[,2:(ncol(validation_dl))])
  validation_dl <- h2o.cbind(validation_dl,test_n1$predict)
  colnames(validation_dl)[ncol(validation_dl)] <- "Class1"
  
  test_n2_m4 <- h2o.predict(object = dl_n2_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  validation_dl <- h2o.cbind(validation_dl,test_n2_m4$predict)
  colnames(validation_dl)[ncol(validation_dl)] <- "Class2"
  
  test_n2_m1 <- h2o.predict(object = dl_n2_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)-2))])
  validation_dl <- h2o.cbind(validation_dl,test_n2_m1$predict)
  colnames(validation_dl)[ncol(validation_dl)] <- "Class2_Bin"
  
  test_n3_m4 <- h2o.predict(object = dl_n3_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  validation_dl <- h2o.cbind(validation_dl,test_n3_m4$predict)
  colnames(validation_dl)[ncol(validation_dl)] <- "Class3"
  
  test_n3_m1 <- h2o.predict(object = dl_n3_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)-4))])
  validation_dl <- h2o.cbind(validation_dl,test_n3_m1$predict)
  colnames(validation_dl)[ncol(validation_dl)] <- "Class3_Bin"
  
  test_n4_m4 <- h2o.predict(object = dl_n4_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  validation_dl <- h2o.cbind(validation_dl,test_n4_m4$predict)
  colnames(validation_dl)[ncol(validation_dl)] <- "Class4"
  
  test_n4_m1 <- h2o.predict(object = dl_n4_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)-1))])
  validation_dl <- h2o.cbind(validation_dl,test_n4_m1$predict)
  colnames(validation_dl)[ncol(validation_dl)] <- "Class4_Bin"
  
  test_n5_m4 <- h2o.predict(object = dl_n5_m4, newdata = validation_dl[,c(2:(ncol(validation_dl)))])
  validation_dl <- h2o.cbind(validation_dl,test_n5_m4$predict)
  colnames(validation_dl)[ncol(validation_dl)] <- "Class5"
  
  test_n5_m1 <- h2o.predict(object = dl_n5_m1, newdata = validation_dl[,c(2:(ncol(validation_dl)-8))])
  validation_dl <- h2o.cbind(validation_dl,test_n5_m1$predict)
  colnames(validation_dl)[ncol(validation_dl)] <- "Class5_Bin"
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_DL predictions",isAfter = TRUE)
  
  #transform into table
  test <- cbind(as.data.frame(valid[,1]),     #1
                as.data.frame(test_n1$predict),    #2
                as.data.frame(test_n2_m1$predict), #3
                as.data.frame(test_n2_m4$predict), #4
                as.data.frame(test_n3_m1$predict), #5
                as.data.frame(test_n3_m4$predict), #6
                as.data.frame(test_n4_m1$predict), #7
                as.data.frame(test_n4_m4$predict), #8
                as.data.frame(test_n5_m1$predict), #9
                as.data.frame(test_n5_m4$predict)) #10
  colnames(test) <- c("s",          #1
                      "Class1",     #2
                      "Class2_m1",  #3
                      "Class2_m4",  #4
                      "Class3_m1",  #5
                      "Class3_m4",  #6
                      "Class4_m1",  #7
                      "Class4_m4",  #8
                      "Class5_m1",  #9
                      "Class5_m4")  #10
  
  write.csv(test, file = paste(pathOutput,nameOutputFile,".csv", sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
  
  salida_test1_n1 <- test[,c(1,2)]
  colnames(salida_test1_n1) <- c("s","o")
  salida_test1_n2 <- test[test$Class2_m1!="desconocido",c(1,4)]
  colnames(salida_test1_n2) <- c("s","o")
  salida_test1_n3 <- test[test$Class3_m1!="desconocido",c(1,6)]
  colnames(salida_test1_n3) <- c("s","o")
  salida_test1_n4 <- test[test$Class4_m1!="desconocido",c(1,8)]
  colnames(salida_test1_n4) <- c("s","o")
  salida_test1_n5 <- test[test$Class5_m1!="desconocido",c(1,10)]
  colnames(salida_test1_n5) <- c("s","o")
  
  salida_test1 <- rbind(salida_test1_n1,
                        salida_test1_n2,
                        salida_test1_n3,
                        salida_test1_n4,
                        salida_test1_n5)
  
  
  
  salida_test1$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  salida_test1[,c(1,2,3)] <- salida_test1[,c(1,3,2)]
  colnames(salida_test1) <- c("s","p","o")
  write.table(salida_test1, file = paste(pathOutput,nameOutputFile,".ttl", sep = ''),
              fileEncoding = "UTF-8", sep = " ", row.names=FALSE, col.names=FALSE, quote = FALSE)
  
  h2o.removeAll()
  h2o.shutdown(prompt=FALSE)
  return(0)
}




app3_RF <- function(randomSeed, pathInput, pathOutput, pathOutputModel, nameOutputFile,
                    tr, vl, tr_l2, vl_l2, tr_l3, vl_l3, tr_l4, vl_l4, tr_l5, vl_l5){
  library(h2o)
  h2o.init(
    nthreads=-1            ## -1: use all available threads
    #max_mem_size = "2G"
  )
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_RF",isAfter = FALSE)
  
  df_training <- h2o.importFile(path = normalizePath(paste(pathInput,tr,sep = '')), header = TRUE)
  df_validating <- h2o.importFile(path = normalizePath(paste(pathInput,vl,sep = '')), header = TRUE)
  
  df_training_sinDesc_N2 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l2,sep = '')), header = TRUE)
  df_validating_sinDesc_N2 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l2,sep = '')), header = TRUE)
  df_training_sinDesc_N3 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l3,sep = '')), header = TRUE)
  df_validating_sinDesc_N3 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l3,sep = '')), header = TRUE)
  df_training_sinDesc_N4 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l4,sep = '')), header = TRUE)
  df_validating_sinDesc_N4 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l4,sep = '')), header = TRUE)
  df_training_sinDesc_N5 <- h2o.importFile(path = normalizePath(paste(pathInput,tr_l5,sep = '')), header = TRUE)
  df_validating_sinDesc_N5 <- h2o.importFile(path = normalizePath(paste(pathInput,vl_l5,sep = '')), header = TRUE)
  
  train <- h2o.assign(df_training, "train.hex") 
  valid <- h2o.assign(df_validating, "valid.hex")
  
  train_sinDesc_N2 <- h2o.assign(df_training_sinDesc_N2, "train_sinDesc_N2.hex") 
  valid_sinDesc_N2 <- h2o.assign(df_validating_sinDesc_N2, "valid_sinDesc_N2.hex")
  train_sinDesc_N3 <- h2o.assign(df_training_sinDesc_N3, "train_sinDesc_N3.hex") 
  valid_sinDesc_N3 <- h2o.assign(df_validating_sinDesc_N3, "valid_sinDesc_N3.hex")
  train_sinDesc_N4 <- h2o.assign(df_training_sinDesc_N4, "train_sinDesc_N4.hex") 
  valid_sinDesc_N4 <- h2o.assign(df_validating_sinDesc_N4, "valid_sinDesc_N4.hex")
  train_sinDesc_N5 <- h2o.assign(df_training_sinDesc_N5, "train_sinDesc_N5.hex") 
  valid_sinDesc_N5 <- h2o.assign(df_validating_sinDesc_N5, "valid_sinDesc_N5.hex")
  
  
  ###Nivel1
  rf_n1 <- h2o.randomForest(
    model_id="rf_n1",
    training_frame=train,
    validation_frame=valid[,2:(ncol(valid)-10)],
    x=2:(ncol(train)-11),
    y=(ncol(train)-10),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = 1234)
  h2o.saveModel(rf_n1, path=pathOutputModel)
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_RF level 1",isAfter = TRUE)
  
  ###Nivel 2
  rf_n2_m1 <- h2o.randomForest(
    model_id="rf_n2_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-8))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-8),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = 1234)
  #summary(rf_n2_m1)
  h2o.saveModel(rf_n2_m1, path=pathOutputModel)
  
  rf_n2_m4 <- h2o.randomForest(
    model_id="rf_n2_m4",
    training_frame=train_sinDesc_N2,
    validation_frame=valid_sinDesc_N2[,c(2:(ncol(valid_sinDesc_N2)-10),(ncol(valid_sinDesc_N2)-9))],
    x=2:(ncol(train_sinDesc_N2)-10),
    y=(ncol(train_sinDesc_N2)-9),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = 1234)
  #summary(rf_n2_m4)
  h2o.saveModel(rf_n2_m4, path=pathOutputModel)
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_RF level 2",isAfter = TRUE)
  
  ###Nivel 3
  rf_n3_m1 <- h2o.randomForest(
    model_id="rf_n3_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-6))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-6),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = 1234)
  #summary(rf_n3_m1)
  h2o.saveModel(rf_n3_m1, path=pathOutputModel)
  
  rf_n3_m4 <- h2o.randomForest(
    model_id="rf_n3_m4",
    training_frame=train_sinDesc_N3,
    validation_frame=valid_sinDesc_N3[,c(2:(ncol(valid_sinDesc_N3)-8),(ncol(valid_sinDesc_N3)-7))],
    x=2:(ncol(train_sinDesc_N3)-8),
    y=(ncol(train_sinDesc_N3)-7),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = 1234)
  #summary(rf_n3_m4)
  h2o.saveModel(rf_n3_m4, path=pathOutputModel)
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_RF level 3",isAfter = TRUE)
  
  ###Nivel 4
  rf_n4_m1 <- h2o.randomForest(
    model_id="rf_n4_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-6),(ncol(valid)-4))],
    x=2:(ncol(train)-6),
    y=(ncol(train)-4),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = 1234)
  #summary(rf_n4_m1)
  h2o.saveModel(rf_n4_m1, path=pathOutputModel)
  
  rf_n4_m4 <- h2o.randomForest(
    model_id="rf_n4_m4",
    training_frame=train_sinDesc_N4,
    validation_frame=valid_sinDesc_N4[,c(2:(ncol(valid_sinDesc_N4)-6),(ncol(valid_sinDesc_N4)-5))],
    x=2:(ncol(train_sinDesc_N4)-6),
    y=(ncol(train_sinDesc_N4)-5),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = 1234)
  #summary(rf_n4_m4)
  h2o.saveModel(rf_n4_m4, path=pathOutputModel)
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_RF level 4",isAfter = TRUE)
  
  ###Nivel 5
  rf_n5_m1 <- h2o.randomForest(
    model_id="rf_n5_m1",
    training_frame=train,
    validation_frame=valid[,c(2:(ncol(valid)-11),(ncol(valid)-2))],
    x=2:(ncol(train)-11),
    y=(ncol(train)-2),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = 1234)
  #summary(rf_n5_m1)
  h2o.saveModel(rf_n5_m1, path=pathOutputModel)
  
  rf_n5_m4 <- h2o.randomForest(
    model_id="rf_n5_m4",
    training_frame=train_sinDesc_N5,
    validation_frame=valid_sinDesc_N5[,c(2:(ncol(valid_sinDesc_N5)-4),(ncol(valid_sinDesc_N5)-3))],
    x=2:(ncol(train_sinDesc_N5)-3),
    y=(ncol(train_sinDesc_N5)-3),
    ntrees = 200,
    max_depth = 120,
    stopping_rounds = 3,
    score_each_iteration = T,
    seed = 1234)
  #summary(rf_n5_m4)
  h2o.saveModel(rf_n5_m4, path=pathOutputModel)
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_RF level 5",isAfter = TRUE)
  
  #####predicción
  validation_rf <- valid[,1:(ncol(valid)-11)]
  
  test_n1_rf <- h2o.predict(object = rf_n1, newdata = validation_rf[,2:(ncol(validation_rf))])
  validation_rf <- h2o.cbind(validation_rf,test_n1_rf$predict)
  colnames(validation_rf)[ncol(validation_rf)] <- "Class1"
  
  test_n2_m4_rf <- h2o.predict(object = rf_n2_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  validation_rf <- h2o.cbind(validation_rf,test_n2_m4_rf$predict)
  colnames(validation_rf)[ncol(validation_rf)] <- "Class2"
  
  test_n2_m1_rf <- h2o.predict(object = rf_n2_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)-2))])
  validation_rf <- h2o.cbind(validation_rf,test_n2_m1_rf$predict)
  colnames(validation_rf)[ncol(validation_rf)] <- "Class2_Bin"
  
  test_n3_m4_rf <- h2o.predict(object = rf_n3_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  validation_rf <- h2o.cbind(validation_rf,test_n3_m4_rf$predict)
  colnames(validation_rf)[ncol(validation_rf)] <- "Class3"
  
  test_n3_m1_rf <- h2o.predict(object = rf_n3_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)-4))])
  validation_rf <- h2o.cbind(validation_rf,test_n3_m1_rf$predict)
  colnames(validation_rf)[ncol(validation_rf)] <- "Class3_Bin"
  
  test_n4_m4_rf <- h2o.predict(object = rf_n4_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  validation_rf <- h2o.cbind(validation_rf,test_n4_m4_rf$predict)
  colnames(validation_rf)[ncol(validation_rf)] <- "Class4"
  
  test_n4_m1_rf <- h2o.predict(object = rf_n4_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)-1))])
  validation_rf <- h2o.cbind(validation_rf,test_n4_m1_rf$predict)
  colnames(validation_rf)[ncol(validation_rf)] <- "Class4_Bin"
  
  test_n5_m4_rf <- h2o.predict(object = rf_n5_m4, newdata = validation_rf[,c(2:(ncol(validation_rf)))])
  validation_rf <- h2o.cbind(validation_rf,test_n1_rf$predict)
  colnames(validation_rf)[ncol(validation_rf)] <- "Class5"
  
  test_n5_m1_rf <- h2o.predict(object = rf_n5_m1, newdata = validation_rf[,c(2:(ncol(validation_rf)-8))])
  validation_rf <- h2o.cbind(validation_rf,test_n5_m1_rf$predict)
  colnames(validation_rf)[ncol(validation_rf)] <- "Class5_Bin"
  
  get_memoryStats(currentPid = Sys.getpid(), currentFunctionPoint = "app3_RF predictions",isAfter = TRUE)
  
  #transform into table
  test_rf <- cbind(as.data.frame(valid[,1]),     #1
                   as.data.frame(test_n1_rf$predict),    #2
                   as.data.frame(test_n2_m1_rf$predict), #3
                   as.data.frame(test_n2_m4_rf$predict), #4
                   as.data.frame(test_n3_m1_rf$predict), #5
                   as.data.frame(test_n3_m4_rf$predict), #6
                   as.data.frame(test_n4_m1_rf$predict), #7
                   as.data.frame(test_n4_m4_rf$predict), #8
                   as.data.frame(test_n5_m1_rf$predict), #9
                   as.data.frame(test_n5_m4_rf$predict)) #10
  colnames(test_rf) <- c("s",          #1
                         "Class1",     #2
                         "Class2_m1",  #3
                         "Class2_m4",  #4
                         "Class3_m1",  #5
                         "Class3_m4",  #6
                         "Class4_m1",  #7
                         "Class4_m4",  #8
                         "Class5_m1",  #9
                         "Class5_m4")  #10
  
  write.csv(test_rf, file = paste(pathOutput,nameOutputFile,".csv", sep = ''), fileEncoding = "UTF-8", row.names=FALSE)
  
  
  salida_test1_n1_rf <- test_rf[,c(1,2)]
  colnames(salida_test1_n1_rf) <- c("s","o")
  salida_test1_n2_rf <- test_rf[test_rf$Class2_m1!="desconocido",c(1,4)]
  colnames(salida_test1_n2_rf) <- c("s","o")
  salida_test1_n3_rf <- test_rf[test_rf$Class3_m1!="desconocido",c(1,6)]
  colnames(salida_test1_n3_rf) <- c("s","o")
  salida_test1_n4_rf <- test_rf[test_rf$Class4_m1!="desconocido",c(1,8)]
  colnames(salida_test1_n4_rf) <- c("s","o")
  salida_test1_n5_rf <- test_rf[test_rf$Class5_m1!="desconocido",c(1,10)]
  colnames(salida_test1_n5_rf) <- c("s","o")
  
  salida_test1_rf <- rbind(salida_test1_n1_rf,
                           salida_test1_n2_rf,
                           salida_test1_n3_rf,
                           salida_test1_n4_rf,
                           salida_test1_n5_rf)
  
  salida_test1_rf$p <- "<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>"
  salida_test1_rf[,c(1,2,3)] <- salida_test1_rf[,c(1,3,2)]
  colnames(salida_test1_rf) <- c("s","p","o")
  salida_test1_rf$punto <- "."
  write.table(salida_test1_rf, file = paste(pathOutput,nameOutputFile,".ttl", sep = ''),
              fileEncoding = "UTF-8", sep = " ", row.names=FALSE, col.names=FALSE, quote = FALSE)
  
  h2o.removeAll()
  h2o.shutdown(prompt=FALSE)
  return(0)
}

