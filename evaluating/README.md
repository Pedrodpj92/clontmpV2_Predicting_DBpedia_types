# Module 3: Evaluating

This section calculates 3 main metrics (*precision, recall and f-measure*) along several measurement criteria, depending on how results and validation data are compared.

* **General**: we measure precision by summing up all the True Positives (TR) of all resources, and dividing by the sum of TP and False Positives (FP) for all resources. For recall we divide by the sum of TP and False negative (FN) for all resources.
* **Average per resource**: we calculate for each resource its precision and recall, and average them.* 
* **Leaves**: only the most specific types are considered. That is, only those types that are the deepest in the class hierarchy.
* **Level N**: only types belonging to level *N* of the taxonomy are considered, level 0 being Thing.

