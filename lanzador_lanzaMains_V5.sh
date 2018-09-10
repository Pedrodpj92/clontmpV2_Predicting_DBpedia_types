#!/bin/bash
#lanzador_lanzaMains_V5.sh

#remember use chmod to adapt your execution permissions
date
echo $0
echo "work directory $PWD "
#execution examples:
# ./lanzador_lanzaMains_V5.sh EN 201610 10000 inputData/instance_types_completo_en.ttl inputData/mappingbased_objects_uncleaned_en.ttl
# ./lanzador_lanzaMains_V5.sh ES 201610 2500 inputData/instance_types_completo_es.ttl inputData/mappingbased_objects_uncleaned_es.ttl
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
  export TYPES=$4
else
  export TYPES=inputData/instance_types_completo_en.ttl
fi

if [ "$#" -gt 4 ]; then
  export PROPERTIES=$5
else
  export PROPERTIES=inputData/mappingbased_objects_uncleaned_en.ttl
fi

#export DBPLANG=$1         #Valores posibles: "EN", "ES"
#export ONTOVERSION=$2     #Valores posibles: "39", "2014", "201610"
#export SEED=$3            #Semilla aleatoria para la seleccion de datos y el modelado

#para generar los nombres de los ficheros de logs
export SALIDA="salida_"
export TIEMPO="tiempo_"
export TXTFILE=".txt"
export SEMILLA="_semilla"

declare -a arr=(1234
                2345
                3456
                4567
                5678
                6789
                7890
                1111
                5555
                9999)


for i in "${arr[@]}"
do
   echo "lets use $i seed"
   echo "intermediate data (train/validate files) and output (evaluation and models) for this seed are in $PWD/seed$i/"
   mkdir -p $PWD/seed$i/
   { time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION $CASOSVAL $i $TYPES $PROPERTIES >> $PWD/seed$i/$SALIDA$DBPLANG$ONTOVERSION$SEMILLA$i$TXTFILE ; } 2> $PWD/seed$i/$TIEMPO$DBPLANG$ONTOVERSION$SEMILLA$i$TXTFILE
   echo "used space in disk at $PWD/seed$i/ :"
   df -h $PWD/seed$i/
   echo "compressing generated files"
   tar -zcvf $PWD/dataSeed$i.tar.gz $PWD/seed$i/
   echo "deleting intermediate data"
   rm -r $PWD/seed$i/intermediateData*/
   echo "used space in disk at $PWD/seed$i/ :"
   df -h $PWD/seed$i/
done

date

#execution example:
#./lanzaMains_V5.sh "EN" "201610" 1234

#{ time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION 1234 >> salida_EN_201610_semilla1234.txt ; } 2> tiempo_EN_201610_semilla1234.txt

#{ time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION 2345 >> salida_EN_201610_semilla2345.txt ; } 2> tiempo_EN_201610_semilla2345.txt

#{ time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION 3456 >> salida_EN_201610_semilla3456.txt ; } 2> tiempo_EN_201610_semilla3456.txt

#{ time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION 4567 >> salida_EN_201610_semilla4567.txt ; } 2> tiempo_EN_201610_semilla4567.txt

#{ time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION 5678 >> salida_EN_201610_semilla5678.txt ; } 2> tiempo_EN_201610_semilla5678.txt

#{ time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION 6789 >> salida_EN_201610_semilla6789.txt ; } 2> tiempo_EN_201610_semilla6789.txt

#{ time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION 7890 >> salida_EN_201610_semilla7890.txt ; } 2> tiempo_EN_201610_semilla7890.txt

#{ time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION 1111 >> salida_EN_201610_semilla1111.txt ; } 2> tiempo_EN_201610_semilla1111.txt

#{ time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION 5555 >> salida_EN_201610_semilla5555.txt ; } 2> tiempo_EN_201610_semilla5555.txt

#{ time ./lanzaMains_V5.sh $DBPLANG $ONTOVERSION 9999 >> salida_EN_201610_semilla9999.txt ; } 2> tiempo_EN_201610_semilla9999.txt

