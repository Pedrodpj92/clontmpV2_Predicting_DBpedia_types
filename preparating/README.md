# Module 1: Preparing

This first module uses properties dataset (mapping based properties) and types dataset (instance_types) in order to dispose proper information that can be used by models, at next module "modeling".

It is composed by two phases: prepare and divide. First is only focused on generate a matrix with ingoing properties and resources, after it adds it related types. Second phase divides data to obtain train and validate datasets.

Validation options available are simple train/validate split or cross validation.

First option, simple split, allows to choose number of cases for validation set and number of minimum ingoing properties condition. This means how many properties as minimum should have resources that will be chosen to validate models.

Second option allows, cross validation, allows divide the main dataset in N folds, so N times the approach selected will be executed at next module.

To see full description and options, go to main README and help section.

## preprocesa 
### Description:
This function calls the specific functions in order to transform input properties and types files. The goal is that intermediate data generated here can be used by Machine Learning algorithms at next modeling module..
### Function variables:
* file_mapping_based_properties_In
* file_instance_types_In
* domain_resources
* path_levels
* isCrossValidation
* isApproach1
* path_splits_Out
* path_files_trainValidate_Out
* file_training_Out
* file_validating_Out
* semilla
* nSplits
* n_cases_validating
* test1_10_25
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
* reservados
### Input expected:
* Properties file in turtle format. Commonly mapping_based_properties or mapping_based_objects in DBpedia
* Types file in turtle format. Commonly instance_types in DBpedia
## Output expected:
* Object propeties matrix in csv format
* Learning dataset in csv format
* training and validating datasets in csv format. Depending on type of validation (simple or cross-validation) would be different number of files


