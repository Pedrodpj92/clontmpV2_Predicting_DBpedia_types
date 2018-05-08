#!/usr/bin/env Rscript
#monitor_funs.R

#Sys.getpid(), remember
get_memoryStats <- function(currentPid, currentFunctionPoint, isAfter){
  if(as.logical(isAfter)){
    print(paste(strftime(Sys.time())," current memory consuming after ",currentFunctionPoint,":",sep=""),
          digits = 20, quote = FALSE, print.gap = 4, right = FALSE, max = 1000, useSource = TRUE)  
  }else{
    print(paste(strftime(Sys.time())," current memory consuming before ",currentFunctionPoint,":",sep=""),
          digits = 20, quote = FALSE, print.gap = 4, right = FALSE, max = 1000, useSource = TRUE)
  }
  print(system("free -h"))
  print(system(command =  paste("ps aux --sort -rss | grep '/usr/lib/R/bin' | grep '",currentPid,"' | head -n 2",sep = "")))
}


