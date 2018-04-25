# Module 1: Preparing

This first module uses properties dataset (mapping based properties) and types dataset (instance_types) in order to dispose proper information that can be used by models, at next module "modeling".

It is composed by two phases: prepare and divide. First is only focused on generate a matrix with ingoing properties and resources, after it adds it related types. Second phase divides data to obtain train and validate datasets.

Validation options available are simple train/validate split or cross validation.

First option, simple split, allows to choose number of cases for validation set and number of minimum ingoing properties condition. This means how many properties as minimum should have resources that will be chosen to validate models.

Second option allows, cross validation, allows divide the main dataset in N folds, so N times the approach selected will be executed at next module.

To see full description and options, go to main README and help section.
