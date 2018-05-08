# Module Monitoring

The aim of this section is provide perform metrics and monitoring auxiliary functions. At the moment there is only one available.

# Functions
The purpose of this section is only clarify develop details.

## get_memoryStats 
### Description:
This function calls to OS in order obtain RAM memory status and how much are consuming the process.
### Function variables:
* currentPid
* currentFunctionPoint
* isAfter. Note: Logical, indicates if the call to this function is referred before or after a function or a specific along the execution.
### Input expected:
* void. No files are required
### Output expected:
prints at standard output the next system calls:
* Sys.time()
* system("free -h")
* system(command =  paste("ps aux --sort -rss | grep '/usr/lib/R/bin' | grep '",currentPid,"' | head -n 2",sep = ""))
#### Example output format:
``` [1]    2018-05-08 15:11:19 current memory consuming before modeling approach 1 global:
              total        used        free      shared  buff/cache   available
Mem:           163G         35G         95G         23M         32G        126G
Swap:          4.7G        171M        4.5G
[1] 0
userExample    25025 96.8 21.1 36388868 36279808 pts/2 S  14:09  59:55 /usr/lib/R/bin/exec/R --slave --no-restore --file=./main_predicting_DBpedia_types_P_M_E.R --args -a global_ap1 -l DL -c FALSE -t 1 -n 10000 -d EN -v 39 -m inputData/En39/mappingbased_objects_uncleaned_en.ttl -i inputData/En39/instance_types_completo_en.ttl -o outputData_en39_app1_DL_test1_ej11/ -e intermediateData_en39_app1_DL_test1_ej11/ -f en39_app1_DL_test1_ej11 -s 1234 -x P_M_E
userExample    25797 51.0  0.0   4504   744 pts/2    S    15:11   0:00 sh -c ps aux --sort -rss | grep '/usr/lib/R/bin' | grep '25025' | head -n 2
[1] 0
```

