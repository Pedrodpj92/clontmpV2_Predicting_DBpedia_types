# Module 2: Modeling

This section controls Machine Learning Models section. Each approach are explained in their own directories. 

Cross Validation option only are available on approach 2.

To see full description and options, go to main README and help section.

# Functions
The purpose of this section is only clarify develop details.

## modela 
### Description:
This function calls the specific model function from main workflow. It also runs a simple execution or cross validation mode.
### Function variables:
* approachSelected
* algorithmSelected
* semilla
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
* Training files. One ore several depending on approach selected (1 or 2-3) and type of validation (simple or cross validation)
* Validating files
## Output expected:
* csv file with each evaluation done
### Return value:
* Data frame with metrics




