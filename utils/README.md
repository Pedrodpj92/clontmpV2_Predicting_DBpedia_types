# Other functions and interesting process

This folder have related useful code.

# main_diff_datos.R

```
./main_diff_datos.R --help
Usage: ./main_diff_datos.R -l <first dataset path> -r <second dataset path> -o <output path>
Description:
                           This program calculates overlapping between two RDF datasets in turtle (.ttl). Only simple triples (<s> <p> <o> .) are allowed. See 2.1 section at https://www.w3.org/TR/turtle/
                           3 datasets are generated corresponding to 3 actions: 1) Inner join. 2) Left exclude join. 3) Right exclude join.
                           Standard output also returns a summary about results with next structure:
                            - conjunto: name's comparison done. It is composed by each input file name.
                            - nrow_left: amount of rows (triples) at firt dataset.
                            - nrow_right: amount of rows (triples) at second dataset.
                            - ratioInnerJoin_left: percentage of triples from first dataset which remain after inner join operation.
                            - ratioInnerJoin_right: percentage of triples from second dataset which remain after inner join operation.
                            - innerJoin: amount of rows (triples) found after inner join operation. It means that these triples only can be found in both input datasets.
                            - left_exclude_right: amount of rows (triples) found after left exclude operation. It means that these triples only can be found in first dataset.
                            - right_exclude_left: amount of rows (triples) found after right exclude operation. It means that these triples only can be found in second dataset.

Options:
        -l CHARACTER, --datasetLeft=CHARACTER
                path to first dataset. Datasets are called 'left' and 'right' to reference join actions

        -r CHARACTER, --datasetRight=CHARACTER
                path to second dataset.

        -o CHARACTER, --pathOut=CHARACTER
                path to output files. Directory should exist previously.

        -h, --help
                Show this help message and exit

Examples:
                           ./main_diff_datos.R -l myDatasets/dummyTypes1.ttl myDatasets/myOtherDummyTypes2.ttl -o myTests/lookingForDifferences/dummyTypes/

```

The purpose of next section is only clarify develop details.

## getDiff_dt 
### Dependencies
* [sqldf R library]( https://cran.r-project.org/web/packages/sqldf/sqldf.pdf )
### Description:
Calculates overlaping between two files in RDF turtle format (ttl). Use --help option two see details about main workflow which calls this function.
### Function variables:
* pathLeft
* pathRight
* pathOutput
### Input expected:
* First (Left) dataset to be compared
* Second (Right) dataset to be compared
### Output expected:
* Inner join dataset. Triples that are found in both datasets.
* Left excluding join dataset. Triples that are only found in first dataset.
* Right excluding join dataset. Triples that are only found in second dataset.
### Return value:
* Data frame with summary about data with next structure:
    * conjunto
	* nrow_left
	* nrow_right
	* ratioInnerJoin_left
	* ratioInnerJoin_right
	* nrow_innerJoin
	* nrow_left_exclude_right
	* nrow_right_exclude_left

