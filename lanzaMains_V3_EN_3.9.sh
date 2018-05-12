#!/bin/bash
#lanzaMains.sh

#para ejecutar las pruebas de manera secuencial

export HOMEDIR="/home/mrico/esTA/clontmpV2_Predicting_DBpedia_types-master"
export ONTOVERSION="39" #Valores posibles: "39", "2014", "201610"
export DBPLANG="EN"

date

#Test 1
#ap1

#Asume directorio $HOMEDIR/pruebasRealizadas
#Asume directorio $HOMEDIR/pruebasRealizadas/intermediateData
#Asume directorio $HOMEDIR/pruebasRealizadas/outputData
#Asume directorio $HOMEDIR/inputData
#Asume en directorio $HOMEDIR/inputData los ficheros 
#      mappingbased_objects_uncleaned_en.ttl 
#      instance_types_completo_en.ttl 

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app1_NB_test1 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test1
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_NB_test1
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test1
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_NB_test1

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app1_DL_test1 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test1
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_DL_test1
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test1
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_DL_test1

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l RF -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app1_RF_test1 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test1
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_RF_test1
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test1
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_RF_test1


#ap2
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app2_C50_test1 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test1
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_C50_test1
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test1
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_C50_test1

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app2_DL_test1 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test1
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_DL_test1
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test1
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_DL_test1

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l RF -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app2_RF_test1 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test1
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_RF_test1
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test1
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_RF_test1


#ap3
./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l DL -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app3_DL_test1 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test1
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_DL_test1
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test1
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_DL_test1

./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l RF -c FALSE -t 1 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app3_RF_test1 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test1
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_RF_test1
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test1
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_RF_test1








#Test 10
#ap1
./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app1_NB_test10 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test10
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_NB_test10
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test10
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_NB_test10

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app1_DL_test10 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test10
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_DL_test10
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test10
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_DL_test10

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l RF -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app1_RF_test10 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test10
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_RF_test10
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test10
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_RF_test10


#ap2
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app2_C50_test10 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test10
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_C50_test10
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test10
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_C50_test10

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app2_DL_test10 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test10
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_DL_test10
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test10
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_DL_test10

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l RF -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app2_RF_test10 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test10
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_RF_test10
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test10
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_RF_test10


#ap3
./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l DL -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app3_DL_test10 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test10
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_DL_test10
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test10
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_DL_test10

./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l RF -c FALSE -t 10 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_en.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app3_RF_test10 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test10
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_RF_test10
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test10
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_RF_test10



#Test 25
#ap1
./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_es.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app1_NB_test25 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test25
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_NB_test25
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_NB_test25
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_NB_test25

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_es.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app1_DL_test25 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test25
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_DL_test25
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_DL_test25
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_DL_test25

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l RF -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_es.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app1_RF_test25 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test25
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_RF_test25
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app1_RF_test25
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app1_RF_test25


#ap2
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_es.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app2_C50_test25 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test25
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_C50_test25
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_C50_test25
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_C50_test25

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_es.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app2_DL_test25 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test25
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_DL_test25
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_DL_test25
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_DL_test25

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l RF -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_es.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app2_RF_test25 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test25
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_RF_test25
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app2_RF_test25
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app2_RF_test25


#ap3
./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l DL -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_es.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app3_DL_test25 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test25
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_DL_test25
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_DL_test25
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_DL_test25

./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l RF -c FALSE -t 25 -n 10000 -d $DBPLANG -v $ONTOVERSION -m $HOMEDIR/inputData/mappingbased_objects_uncleaned_es.ttl -i $HOMEDIR/inputData/instance_types_completo_en.ttl -o $HOMEDIR/outputData/ -f ejecucion1_app3_RF_test25 -s 1234 -x P_M_E
mkdir $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test25
mkdir $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_RF_test25
mv $HOMEDIR/intermediateData/* $HOMEDIR/pruebasRealizadas/intermediateData/ejecucion1_app3_RF_test25
mv $HOMEDIR/outputData/* $HOMEDIR/pruebasRealizadas/outputData/ejecucion1_app3_RF_test25

date


