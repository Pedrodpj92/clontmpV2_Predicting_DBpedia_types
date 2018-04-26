# Module 3: Evaluating

This section calculates 3 main metrics (*precision, recall and f-measure*) along several measurement criteria, depending on how results and validation data are compared.

* **General**: we measure precision by summing up all the True Positives (TR) of all resources, and dividing by the sum of TP and False Positives (FP) for all resources. For recall we divide by the sum of TP and False negative (FN) for all resources.
* **Average per resource**: we calculate for each resource its precision and recall, and average them.* 
* **Leaves**: only the most specific types are considered. That is, only those types that are the deepest in the class hierarchy.
* **Level N**: only types belonging to level *N* of the taxonomy are considered, level 0 being Thing.

# Functions
The purpose of this section is only clarify develop details.

## evalua 
### Description:
This function calls evalua_completo as a wrapper, in order to keep similar structure module as preparating and modeling.
### Function variables:
* pathDT_Generado
* pathDT_Reservado
* pathNiveles
* pathSalida
### Input expected:
* file with ttl extension which contains resources with type predictions.
* file with ttl extension which contains resources with original types in order to compare predictions.
* files with types lists. Each list do reference a each ontology level.
## Output expected:
* csv file with each evaluation done
### Return value:
* Data frame with metrics


## evalua_generalAndMean 
### Description:
This function calculates precision, recall and f-measure  with general and average per resource measurement criteria
### Function variables:
* pathDT_Generado
* pathDT_Reservado
### Input expected:
* file with ttl extension which contains resources with type predictions.
* file with ttl extension which contains resources with original types in order to compare predictions.
* files with types lists. Each list do reference a each ontology level.
## Output expected:
* There are not write output on disk
### Return value:
* Data frame with metrics


## evalua_leaves 
### Description:
This function calculates precision, recall and f-measure with leaves measurement criteria
### Function variables:
* pathDT_Generado
* pathDT_Reservado
* pathNiveles
### Input expected:
* file with ttl extension which contains resources with type predictions.
* file with ttl extension which contains resources with original types in order to compare predictions.
* files with types lists. Each list do reference a each ontology level.
## Output expected:
* There are not write output on disk
### Return value:
* Data frame with metrics


## evalua_levels 
### Description:
This function calculates precision, recall and f-measure with level N measurement criteria
### Function variables:
* pathDT_Generado
* pathDT_Reservado
* pathNiveles
### Input expected:
* file with ttl extension which contains resources with type predictions.
* file with ttl extension which contains resources with original types in order to compare predictions.
* files with types lists. Each list do reference a each ontology level.
## Output expected:
* There are not write output on disk
### Return value:
* Data frame with metrics


## evalua_completo 
### Description:
This function calls the three last ones explained before and generates one data frame with all metrics and measurement criteria joined.
### Function variables:
* pathDT_Generado
* pathDT_Reservado
* pathNiveles
* pathSalida
### Input expected:
* file with ttl extension which contains resources with type predictions.
* file with ttl extension which contains resources with original types in order to compare predictions.
* files with types lists. Each list do reference a each ontology level.
## Output expected:
* csv file with each evaluation done
### Return value:
* Data frame with metrics

## calcula_media_matrices
### Description:
Auxiliary function. Calculates the mean of a data frame list where each element is a return value obtained in evalua_completo function. This function is not currently on workflow, but it can be useful to keep here to future.
### Function variables:
* list_DT
### Input expected:
* list element containing several data frame lists with evalua_completo metrics. This element is not read from disk directly.
### Output expected
* There are not write output on disk
### Return value:
* Data frame with metrics

## calcula_sd_matrices
### Description:
Auxiliary function. Calculates the standard deviation of a data frame list where each element is a return value obtained in evalua_completo function. This function is not currently on workflow, but it can be useful to keep here to future.
### Function variables:
* list_DT
### Input expected:
* list element containing several data frame lists with evalua_completo metrics. This element is not read from disk directly.
### Output expected
* There are not write output on disk
### Return value:
* Data frame with metrics

