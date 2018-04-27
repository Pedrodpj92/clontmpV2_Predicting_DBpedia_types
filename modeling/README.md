# Module 2: Modeling

This module perform the tasks related to the Machine Learning Models training and evaluation. Each approach in further explained in their correponding directories. 

Cross Validation option is only available on approach 2.

To see full description and options, go to main README and help section.

# Functions
The purpose of this section is to clarify development details.

## modeling 
### Description:
This function calls the specific model function from the main workflow. 

### Function variables:
* approachSelected
* algorithmSelected
* randomSeed
* isCrossValidation
* nSplits
* ontology
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
* tr_l6
* vl_l6
### Input expected:
* Training files. One or several depending on the approach selected (1 or 2-3) and type of validation (simple or cross validation)
* Validating files
## Output expected:
* csv file with each evaluation done
### Return value:
* Data frame with metrics




