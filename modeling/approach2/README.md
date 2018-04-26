# Approach 2: ontology class hierarchy for type prediction
Approaches 2 and 3 are Local Classifiers Per Level (LCL), modified with extra binary models. 
These binary models are aimed at solving the *partial depth
problem*: to know, for each resource, which levels do not `produce' types. 
There are 11 models, 6 of them are multi-class, and the remaining 5 are binary models
(as shown in the next figure). The multi-class models are intended for predicting the
type for that level. The binary models predict if the type should be assigned to
the resource.
The approach 2 was named *multilevel* because we have models
for each ontology class level. For this approach we used only one training method:
C5.0, an improved version of C4.5.

<img src="http://es-ta.linkeddata.es/app2training_v2.png" width="1200">

# Functions
The purpose of this section is only clarify develop details.

## app2_C50 
### Description:
This function calls C5.0 library to train a decision tree using C5.0 model for approach 2.
### Function variables:
* semilla
* pathInput
* pathOutput
* pathOutputModel
* nameOutputFile
* tr
* vl
* tr_l2
* vl_l2
* tr_l3
* vl_l3
* tr_l4
* vl_l4
* tr_l5
* vl_l5
### Input expected:
* Training files
* Validating files
### Output expected:
* ttl file with predictions done, which resources are found in validation dataset.

## app2_DL 
### Description:
This function calls H2O API functions to train a Deep Learning (multi-layer feedforward) model for approach 2.
### Function variables:
* semilla
* pathInput
* pathOutput
* pathOutputModel
* nameOutputFile
* tr
* vl
* tr_l2
* vl_l2
* tr_l3
* vl_l3
* tr_l4
* vl_l4
* tr_l5
* vl_l5
### Input expected:
* Training files
* Validating files
### Output expected:
* ttl file with predictions done, which resources are found in validation dataset.


## app2_RF 
### Description:
This function calls H2O API functions to train a Random Forest model for approach 2.
### Function variables:
* semilla
* pathInput
* pathOutput
* pathOutputModel
* nameOutputFile
* tr
* vl
* tr_l2
* vl_l2
* tr_l3
* vl_l3
* tr_l4
* vl_l4
* tr_l5
* vl_l5
### Input expected:
* Training files
* Validating files
### Output expected:
* ttl file with predictions done, which resources are found in validation dataset.

