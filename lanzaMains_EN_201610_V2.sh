#!/bin/bash
#lanzaMains.sh

#para ejecutar las pruebas de manera secuencial
#
#export HOMEDIR="/home/ppozo/clontmpV2_Predicting_DBpedia_types-master"
export ONTOVERSION="201610" #Valores posibles: "39", "2014", "201610"
export DBPLANG="EN"         #Valores posibles: "EN", "ES"

date



#Asume directorio pruebasRealizadas
#Asume directorio pruebasRealizadas/intermediateData
#Asume directorio pruebasRealizadas/outputData
#Asume directorio inputData
#Asume en directorio inputData los ficheros 
#      mappingbased_objects_uncleaned_en.ttl 
#      instance_types_completo_en.ttl 


#Test 1
#ap1
#preproceso app1 test1
./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_NB_test1/ -e intermediateData_app1_Test1/ -f ej1_app1_NB_test1 -s 1234 -x P

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_NB_test1/ -e intermediateData_app1_Test1/ -f ej1_app1_NB_test1 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test1
#mkdir pruebasRealizadas/outputData/ejecucion1_app1_NB_test1
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test1
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app1_NB_test1

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_DL_test1/ -e intermediateData_app1_Test1/ -f ej1_app1_DL_test1 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test1
#mkdir pruebasRealizadas/outputData/ejecucion1_app1_DL_test1
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test1
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app1_DL_test1

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l RF -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_RF_test1/ -e intermediateData_app1_Test1/ -f ej1_app1_RF_test1 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test1
#mkdir pruebasRealizadas/outputData/ejecucion1_app1_RF_test1
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test1
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app1_RF_test1

#preproceso app2and3 test1
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_DL_test1/ -e intermediateData_app2and3_Test1/ -f ej1_app2_DL_test1 -s 1234 -x P

#ap2
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_DL_test1/ -e intermediateData_app2and3_Test1/ -f ej1_app2_DL_test1 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test1
#mkdir pruebasRealizadas/outputData/ejecucion1_app2_DL_test1
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test1
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app2_DL_test1

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l RF -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_RF_test1/ -e intermediateData_app2and3_Test1/ -f ej1_app2_RF_test1 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test1
#mkdir pruebasRealizadas/outputData/ejecucion1_app2_RF_test1
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test1
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app2_RF_test1

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_C50_test1/ -e intermediateData_app2and3_Test1/ -f ej1_app2_C50_test1 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test1
#mkdir pruebasRealizadas/outputData/ejecucion1_app2_C50_test1
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test1
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app2_C50_test1



#ap3
./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l DL -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app3_DL_test1/ -e intermediateData_app2and3_Test1/ -f ej1_app3_DL_test1 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test1
#mkdir pruebasRealizadas/outputData/ejecucion1_app3_DL_test1
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test1
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app3_DL_test1

./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l RF -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app3_RF_test1/ -e intermediateData_app2and3_Test1/ -f ej1_app3_RF_test1 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test1
#mkdir pruebasRealizadas/outputData/ejecucion1_app3_RF_test1
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test1
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app3_RF_test1








#Test 10
#ap1
#preproceso app1 test 1
./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_NB_test10/ -e intermediateData_app1_Test10/ -f ej1_app1_NB_test10 -s 1234 -x P

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_NB_test10/ -e intermediateData_app1_Test10/ -f ej1_app1_NB_test10 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test10
#mkdir pruebasRealizadas/outputData/ejecucion1_app1_NB_test10
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test10
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app1_NB_test10

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_DL_test10/ -e intermediateData_app1_Test10/ -f ej1_app1_DL_test10 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test10
#mkdir pruebasRealizadas/outputData/ejecucion1_app1_DL_test10
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test10
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app1_DL_test10

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l RF -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_RF_test10/ -e intermediateData_app1_Test10/ -f ej1_app1_RF_test10 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test10
#mkdir pruebasRealizadas/outputData/ejecucion1_app1_RF_test10
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test10
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app1_RF_test10

#preproceso app2and3 test 10
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_C50_test10/ -e intermediateData_app2and3_Test10/ -f ej1_app2_C50_test10 -s 1234 -x P

#ap2
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_C50_test10/ -e intermediateData_app2and3_Test10/ -f ej1_app2_C50_test10 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test10
#mkdir pruebasRealizadas/outputData/ejecucion1_app2_C50_test10
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test10
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app2_C50_test10

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_DL_test10/ -e intermediateData_app2and3_Test10/ -f ej1_app2_DL_test10 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test10
#mkdir pruebasRealizadas/outputData/ejecucion1_app2_DL_test10
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test10
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app2_DL_test10

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l RF -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_RF_test10/ -e intermediateData_app2and3_Test10/ -f ej1_app2_RF_test10 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test10
#mkdir pruebasRealizadas/outputData/ejecucion1_app2_RF_test10
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test10
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app2_RF_test10


#ap3
./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l DL -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app3_DL_test10/ -e intermediateData_app2and3_Test10/ -f ej1_app3_DL_test10 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test10
#mkdir pruebasRealizadas/outputData/ejecucion1_app3_DL_test10
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test10
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app3_DL_test10

./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l RF -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_en.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app3_RF_test10/ -e intermediateData_app2and3_Test10/ -f ej1_app3_RF_test10 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test10
#mkdir pruebasRealizadas/outputData/ejecucion1_app3_RF_test10
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test10
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app3_RF_test10


#preprocesado app1 test 25
./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_es.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_NB_test25/ -e intermediateData_app1_Test25/ -f ej1_app1_NB_test25 -s 1234 -x P

#Test 25
#ap1
./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_es.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_NB_test25/ -e intermediateData_app1_Test25/ -f ej1_app1_NB_test25 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test25
#mkdir pruebasRealizadas/outputData/ejecucion1_app1_NB_test25
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test25
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app1_NB_test25

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_es.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_DL_test25/ -e intermediateData_app1_Test25/ -f ej1_app1_DL_test25 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test25
#mkdir pruebasRealizadas/outputData/ejecucion1_app1_DL_test25
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test25
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app1_DL_test25

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l RF -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_es.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app1_RF_test25/ -e intermediateData_app1_Test25/ -f ej1_app1_RF_test25 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test25
#mkdir pruebasRealizadas/outputData/ejecucion1_app1_RF_test25
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test25
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app1_RF_test25

#prepocesado app2and3 test25
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_es.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_C50_test25/ -e intermediateData_app2and3_Test25/ -f ej1_app2_C50_test25 -s 1234 -x P

#ap2
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_es.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_C50_test25/ -e intermediateData_app2and3_Test25/ -f ej1_app2_C50_test25 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test25
#mkdir pruebasRealizadas/outputData/ejecucion1_app2_C50_test25
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test25
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app2_C50_test25

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_es.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_DL_test25/ -e intermediateData_app2and3_Test25/ -f ej1_app2_DL_test25 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test25
#mkdir pruebasRealizadas/outputData/ejecucion1_app2_DL_test25
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test25
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app2_DL_test25

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l RF -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_es.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app2_RF_test25/ -e intermediateData_app2and3_Test25/ -f ej1_app2_RF_test25 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test25
#mkdir pruebasRealizadas/outputData/ejecucion1_app2_RF_test25
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test25
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app2_RF_test25


#ap3
./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l DL -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_es.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app3_DL_test25/ -e intermediateData_app2and3_Test25/ -f ej1_app3_DL_test25 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test25
#mkdir pruebasRealizadas/outputData/ejecucion1_app3_DL_test25
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test25
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app3_DL_test25

./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l RF -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m inputData/mappingbased_objects_uncleaned_es.ttl -i inputData/instance_types_completo_en.ttl -o outputData_app3_RF_test25/ -e intermediateData_app2and3_Test25/ -f ej1_app3_RF_test25 -s 1234 -x M_E
#mkdir pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test25
#mkdir pruebasRealizadas/outputData/ejecucion1_app3_RF_test25
#mv intermediateData/* pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test25
#mv outputData/* pruebasRealizadas/outputData/ejecucion1_app3_RF_test25

date


