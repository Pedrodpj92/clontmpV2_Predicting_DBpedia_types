# Approach 1: Naive approach for type prediction
This approach uses a multi-class classifier in order to predict the most specific
type for each resource. From this most specific type, we can compute the *parent*
types from the ontology class hierarchy.
Our study started with a simple approximation: as we know that the types of most typed resources have a
*logical* path, knowing the most specific (detailed/deeper) type we can compute
the whole type path. Therefore, this approach tries to predict this most specific
class. For this approach we add only one column to the
common training set: the column entitled Class (see figure below). 

As shown in the figure, for resource Cervantes we have type Writer and for resource Spain we have type Country, because
these are their most specific types.
In this approach we have used 3 different training methods: Naïve Bayes, Random Forest and Deep Learning (multi-layer feedforward).

<img src="http://es-ta.linkeddata.es/app1training_v2.png" width="700">

# Functions
The purpose of this section is only clarify develop details.

## app1_nb 
### Description:
This function calls H2O API functions to train a Naïve Bayes model for approach 1.
### Function variables:
* semilla
* pathInput
* pathOutput
* pathOutputModel
* nameOutputFile
* tr
* vl
### Input expected:
* Training file
* Validating file
### Output expected:
* ttl file with predictions done, which resources are found in validation dataset.

## app1_dl 
### Description:
This function calls H2O API functions to train a Deep Learning (multi-layer feedforward) model for approach 1.
### Function variables:
* semilla
* pathInput
* pathOutput
* pathOutputModel
* nameOutputFile
* tr
* vl
### Input expected:
* Training file
* Validating file
### Output expected:
* ttl file with predictions done, which resources are found in validation dataset for approach 1.

## app1_rf 
### Description:
This function calls H2O API functions to train a Random Forest model dataset for approach 1.
### Function variables:
* semilla
* pathInput
* pathOutput
* pathOutputModel
* nameOutputFile
* tr
* vl
### Input expected:
* Training file
* Validating file
### Output expected:
* ttl file with predictions done, which resources are found in validation dataset.

