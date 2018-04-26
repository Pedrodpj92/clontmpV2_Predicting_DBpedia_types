# Approach 3: ontology class hierarchy for type prediction *on cascade*
Approaches 2 and 3 are Local Classifiers Per Level (LCL), modified with extra binary models. 
These binary models are aimed at solving the *partial depth
problem*: to know, for each resource, which levels do not *produce* types. 
There are 11 models, 6 of them are multi-class, and the remaining 5 are binary models
(as shown in the next figure). The multi-class models are intended for predicting the
type for that level. The binary models predict if the type should be assigned to
the resource.
The third approach is also a multilevel approach. The features used by this
approach are depicted in the following picture. In this approach we add a *cascade process*, aimed at avoiding inconsistencies in the predicted types (non *logical*
paths).

<img src="http://es-ta.linkeddata.es/app3training_v2.png" width="1200">


# Functions
The purpose of this section is only clarify develop details.

## app3_DL 
### Description:
This function calls H2O API functions to train a Deep Learning (multi-layer feedforward) model for approach 3.
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


## app3_RF 
### Description:
This function calls H2O API functions to train a Random Forest model for approach 3.
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
