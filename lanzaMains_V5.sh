#!/bin/bash
#lanzaMains_EN_201610_V3.sh OLD
#lanzaMains_V5.sh

#para ejecutar las pruebas de manera secuencial
#
#export HOMEDIR="/home/ppozo/clontmpV2_Predicting_DBpedia_types-master"
#export DBPLANG=$1         #Valores posibles: "EN", "ES"
#export ONTOVERSION=$2     #Valores posibles: "39", "2014", "201610"
#export SEED=$3            #Semilla aleatoria para la seleccion de datos y el modelado

#execution example:
#./lanzaMains_V5.sh "EN" "201610" 1234

date

if [ "$#" -gt 0 ]; then
  export DBPLANG=$1
else
  export DBPLANG="EN"
fi

if [ "$#" -gt 1 ]; then
  export ONTOVERSION=$2
else
  export ONTOVERSION="201610"
fi

if [ "$#" -gt 2 ]; then
  export CASOSVAL=$3
else
  export CASOSVAL=10000
fi

if [ "$#" -gt 3 ]; then
  export SEMILLA=$4
else
  export SEMILLA=1234
fi

if [ "$#" -gt 4 ]; then
  export TYPES=$5
else
  export TYPES=inputData/instance_types_completo_en.ttl
fi

if [ "$#" -gt 5 ]; then
  export PROPERTIES=$6
else
  export PROPERTIES=inputData/mappingbased_objects_uncleaned_en.ttl
fi


#Asume directorio pruebasRealizadas
#Asume directorio pruebasRealizadas/intermediateData
#Asume directorio pruebasRealizadas/outputData
#Asume directorio inputData
#Asume en directorio inputData los ficheros 
#      mappingbased_objects_uncleaned_en.ttl 
#      instance_types_completo_en.ttl 


#Test 1
#ap1
#preproceso app1 test1 - already done 
./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 1 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_NB_test1/ -e seed$SEMILLA/intermediateData_app1_Test1/ -f ej1_app1_NB_test1 -s $SEMILLA -x P

#modelado
./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 1 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_NB_test1/ -e seed$SEMILLA/intermediateData_app1_Test1/ -f ej1_app1_NB_test1 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 1 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_DL_test1/ -e seed$SEMILLA/intermediateData_app1_Test1/ -f ej1_app1_DL_test1 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l RF -c FALSE -t 1 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_RF_test1/ -e seed$SEMILLA/intermediateData_app1_Test1/ -f ej1_app1_RF_test1 -s $SEMILLA -x M_E

#ap2
#preproceso app2and3 test1
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 1 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_DL_test1/ -e seed$SEMILLA/intermediateData_app2and3_Test1/ -f ej1_app2_DL_test1 -s $SEMILLA -x P

#modelado
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 1 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_DL_test1/ -e seed$SEMILLA/intermediateData_app2and3_Test1/ -f ej1_app2_DL_test1 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l RF -c FALSE -t 1 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_RF_test1/ -e seed$SEMILLA/intermediateData_app2and3_Test1/ -f ej1_app2_RF_test1 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 1 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_C50_test1/ -e seed$SEMILLA/intermediateData_app2and3_Test1/ -f ej1_app2_C50_test1 -s $SEMILLA -x M_E


#ap3
./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l DL -c FALSE -t 1 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app3_DL_test1/ -e seed$SEMILLA/intermediateData_app2and3_Test1/ -f ej1_app3_DL_test1 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l RF -c FALSE -t 1 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app3_RF_test1/ -e seed$SEMILLA/intermediateData_app2and3_Test1/ -f ej1_app3_RF_test1 -s $SEMILLA -x M_E



#Test 10
#ap1
#preproceso app1 test 1
./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 10 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_NB_test10/ -e seed$SEMILLA/intermediateData_app1_Test10/ -f ej1_app1_NB_test10 -s $SEMILLA -x P

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 10 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_NB_test10/ -e seed$SEMILLA/intermediateData_app1_Test10/ -f ej1_app1_NB_test10 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 10 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_DL_test10/ -e seed$SEMILLA/intermediateData_app1_Test10/ -f ej1_app1_DL_test10 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l RF -c FALSE -t 10 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_RF_test10/ -e seed$SEMILLA/intermediateData_app1_Test10/ -f ej1_app1_RF_test10 -s $SEMILLA -x M_E

#preproceso app2and3 test 10
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 10 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_C50_test10/ -e seed$SEMILLA/intermediateData_app2and3_Test10/ -f ej1_app2_C50_test10 -s $SEMILLA -x P

#ap2
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 10 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_C50_test10/ -e seed$SEMILLA/intermediateData_app2and3_Test10/ -f ej1_app2_C50_test10 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 10 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_DL_test10/ -e seed$SEMILLA/intermediateData_app2and3_Test10/ -f ej1_app2_DL_test10 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l RF -c FALSE -t 10 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_RF_test10/ -e seed$SEMILLA/intermediateData_app2and3_Test10/ -f ej1_app2_RF_test10 -s $SEMILLA -x M_E


#ap3
./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l DL -c FALSE -t 10 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app3_DL_test10/ -e seed$SEMILLA/intermediateData_app2and3_Test10/ -f ej1_app3_DL_test10 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l RF -c FALSE -t 10 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app3_RF_test10/ -e seed$SEMILLA/intermediateData_app2and3_Test10/ -f ej1_app3_RF_test10 -s $SEMILLA -x M_E


#Test 25
#ap1
#preprocesado app1 test 25
./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 25 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_NB_test25/ -e seed$SEMILLA/intermediateData_app1_Test25/ -f ej1_app1_NB_test25 -s $SEMILLA -x P

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l NB -c FALSE -t 25 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_NB_test25/ -e seed$SEMILLA/intermediateData_app1_Test25/ -f ej1_app1_NB_test25 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 25 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_DL_test25/ -e seed$SEMILLA/intermediateData_app1_Test25/ -f ej1_app1_DL_test25 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l RF -c FALSE -t 25 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app1_RF_test25/ -e seed$SEMILLA/intermediateData_app1_Test25/ -f ej1_app1_RF_test25 -s $SEMILLA -x M_E

#prepocesado app2and3 test25
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 25 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_C50_test25/ -e seed$SEMILLA/intermediateData_app2and3_Test25/ -f ej1_app2_C50_test25 -s $SEMILLA -x P

#ap2
./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l C5.0 -c FALSE -t 25 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_C50_test25/ -e seed$SEMILLA/intermediateData_app2and3_Test25/ -f ej1_app2_C50_test25 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l DL -c FALSE -t 25 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_DL_test25/ -e seed$SEMILLA/intermediateData_app2and3_Test25/ -f ej1_app2_DL_test25 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a multilevel_ap2 -l RF -c FALSE -t 25 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app2_RF_test25/ -e seed$SEMILLA/intermediateData_app2and3_Test25/ -f ej1_app2_RF_test25 -s $SEMILLA -x M_E


#ap3
./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l DL -c FALSE -t 25 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app3_DL_test25/ -e seed$SEMILLA/intermediateData_app2and3_Test25/ -f ej1_app3_DL_test25 -s $SEMILLA -x M_E

./main_predicting_DBpedia_types_P_M_E.R -a cascade_ap3 -l RF -c FALSE -t 25 -n $CASOSVAL -d $DBPLANG -v $ONTOVERSION -m $PROPERTIES -i $TYPES -o seed$SEMILLA/outputData_app3_RF_test25/ -e seed$SEMILLA/intermediateData_app2and3_Test25/ -f ej1_app3_RF_test25 -s $SEMILLA -x M_E

date


