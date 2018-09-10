# Predicting DBpedia types

This project contains the code for generating new types on the DBpedia dataset, exploiting its class hierarchy. 

The main script (main_predicting_DBpedia_types_P_M_E.R) is the entry point for executing the different experiments avilable. Check out http://es-ta.linkeddata.es/ to explore details and download data to test experiments. 

The current version works with the DBpedia ontology, versions 3.9, 2014 and 2016-10, for the English and Spanish datasets.

## Getting Started
Clone or download the source code into your machine. Check next section to find libraries and software required and how to install them

### Prerequisites

* 64-bits machine
* [R 3.0.0](https://www.r-project.org/ ) or later
* [Java 1.7](https://www.java.com/es/download/) or later
* [curl] Ubuntu: sudo apt install libcurl4-openssl-dev curl  


 
### Installing R packages
The use of last stable versions is recommended, but here you point to both, last stable and what the ones we used.

* Main common libraries and dependencies
```
#http://docs.h2o.ai/h2o/latest-stable/h2o-docs/faq/r.html
if (! ("methods" %in% rownames(installed.packages()))) { install.packages("methods") }
if (! ("statmod" %in% rownames(installed.packages()))) { install.packages("statmod") }
if (! ("stats" %in% rownames(installed.packages()))) { install.packages("stats") }
if (! ("graphics" %in% rownames(installed.packages()))) { install.packages("graphics") }
if (! ("RCurl" %in% rownames(installed.packages()))) { install.packages("RCurl") }
if (! ("jsonlite" %in% rownames(installed.packages()))) { install.packages("jsonlite") }
if (! ("tools" %in% rownames(installed.packages()))) { install.packages("tools") }
if (! ("utils" %in% rownames(installed.packages()))) { install.packages("utils") }
if (! ("optparse" %in% rownames(installed.packages()))) { install.packages("optparse") }
```

* The specific versions of the packages related to ML used in the experiments are these:
```
url_h2o <- "https://cran.r-project.org/src/contrib/Archive/h2o/h2o_3.16.0.1.tar.gz"
install.packages(url_h2o, repos=NULL, type="source")

url_c50 <- "https://cran.r-project.org/src/contrib/Archive/C50/C50_0.1.0-24.tar.gz"
install.packages(url_c50, repos=NULL, type="source")
```

* But, if you are interested in using the latest versions of these ML packages, do this:
```
install.packages("h2o", type="source", repos=(c("http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R")))

if (! ("C50" %in% rownames(installed.packages()))) { install.packages("C50") }
```

 
## Running experiments
Navigate to the source folder and execute the main script with -h or --help to see options. Use RScript command if you are under Windows. (**mind PATH configuration**). Every directory that appears as argument is relative (not absolute), and it always should take place under project directory.
```
$ ./main_predicting_DBpedia_types_P_M_E.R --help
Usage: ./main_predicting_DBpedia_types_P_M_E.R <options>
Description:
                           This software provides a complete Data Mining workflow for inferring new DBpedia types on resources which are found as objects.

Options:
        -a CHARACTER, --approach=CHARACTER
                approach selected. <global_ap1 | multilevel_ap2 | cascade_ap3>.
              global_ap1     - First approach, it learns from most specific type from each resource
              multilevel_ap2 - Second approach, Local Classifiers per Level with binary decisions per level aimed to solve partial depth issue
              cascade_ap3    - Third approach, Local Classifiers per Level with binary decisions per level and cascade process aimed to solve partial depth issue and reduce hierarchy inconcistencies

        -l CHARACTER, --algorithm=CHARACTER
                algorithm used for the approach selected. <NB | C5.0 | DL | RF>.
              NB   - Naïve Bayes. Only in global approach
              C5.0 - Only in multilevel approach
              DL   - Deep Learning
              RF   - Random Forest

        -c LOGICAL, --cross_validation=LOGICAL
                decide whether the divide process should be a simple split (train/test) or should be a cross_validation. <TRUE | FALSE>

        -t INTEGER, --test_ingoingCondition=INTEGER
                minimum amount of properties per resource reserved for tests. Only available on simple split (-c FALSE)

        -n INTEGER, --number_casesOrFolds=INTEGER
                the number of cases or the folds used depending on -c condition option

        -d CHARACTER, --domain=CHARACTER
                how starts URI's DBpedia resources. <EN | ES>

        -v CHARACTER, --versionOntology=CHARACTER
                DBpedia ontology version. <39 | 2014 | 201610>

        -m CHARACTER, --mapping_based_properties=CHARACTER
                path to input mapping_based_properties.ttl. In modern DBpedia versions it may be mapping_based_objects.ttl, it works well so.

        -i CHARACTER, --instance_types=CHARACTER
                path to input instance_types.ttl In modern DBpedia versions it may be splitted in 2 files, transitive and 'ending' (leaves) types.
              This main program assumes that types file are completed, so in case of divided files, should be merged previously

        -o CHARACTER, --pathOut=CHARACTER
                path to output files. Directory should exist previously

        -e CHARACTER, --pathIntermediateData=CHARACTER
                path to intermediate data generated in process, as train/test partition sets.

        -f CHARACTER, --fileOut=CHARACTER
                files' output identifier or name to track files about same experiment [default= output]

        -s INTEGER, --seed=INTEGER
                random number generator seed for algorithms that are dependent on randomization [default= 1234]

        -x CHARACTER, --executionMode=CHARACTER
                this main is divided in 3 modules: preprocesing, modeling, evaluating. Flag -x or --executionMode specify where this main script should do. This is useful, for instance, to generate the same train/validation data once and execute several approaches and/or algorithms. <P_M_E | P | M_E >

        -h, --help
                Show this help message and exit


                                      Note: each directory used in arguments as -e or -f should end with slash ('/')
                                      Examples:
                             ./main_predicting_DBpedia_types_P_M_E.R -a global_ap1 -l DL -c FALSE -t 1 -n 2500 -d ES -v 201610 -m ~/inputData/mappingbased_objects_uncleaned_es.ttl -i ~/inputData/instance_types_completo_es.ttl -o ~/outputData/ -f ejecucion1_app1_DL_test1 -s 1234 -x P_M_E

                            In this case, The program will use first approach (global) with a deep learning algoritm, with one train/validate split where 2500 validation cases have at least 1 ingoing property. This case is used on EsDBpedia with the 2016-10 ontology. After that, we specify both input data (properties and types) followed by output path, and files identifier. All processes will use '1234' as random seed. The -x option will indicate a full workflow (preprocesing, modeling and evaluating)

```
There are a couple of bash scripts that can help to run several experiments together sequentially. Please, check them and adapt them to your own experiments before run them. Some example executions:
```
./lanzador_lanzaMains_V5.sh "ES" "201610" 2500 inputData/es201610/instance_types_completo_es.ttl inputData/es201610/mappingbased_objects_uncleaned_es.ttl

./lanzador_lanzaMains_V5.sh "EN" "201610" 10000 inputData/en201610/instance_types_completo_en.ttl inputData/en201610/mappingbased_objects_uncleaned_en.ttl
```

## About the authors
* **Mariano Rico**	*(mariano.rico@fi.upm.es)* Ontology Engineering Group, UPM
* **Idafen Santana-Perez**	*(isantana@fi.upm.es)* Ontology Engineering Group, UPM
* **Pedro del Pozo-Jiménez**	*(ppozo@fi.upm.es)* Ontology Engineering Group, UPM
* **Asunción Gomez-Pérez**	*(asun@fi.upm.es)* Ontology Engineering Group, UPM

## Acknowledgments
This work was partially funded by projects RTC-2016-4952-7, TIN2013-46238-C4-2-R and TIN2016-78011-C4-4-R, from the Spanish State Investigation Agency of the MINECO and FEDER Funds

