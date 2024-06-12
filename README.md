This repository contains code for reproducing some of the examples from the
2024 ISBA BART short course.

# Required Packages

R packages can be installed from CRAN for the most part. There are a couple
of exceptions, which need to be installed from GitHub using the `devtools`
package:

- `Batman`, which contains miscellaneous BART functions, available here:
- `possum`, which performs posterior summarization, available here:
- `BART4RS`, which has some functions for fitting the Cox proportional hazards
   model, available here:
   
# Replication Materials

All replication amterials are in the `Examples/` directory. To use this
repository, simply do the following.

1. Clone the repository.
2. Open the .Rproj file using **RStudio**.
3. Open the notebooks in the `Examples/` directory.
4. Knit the files if desired, or run the files interactively in **RStudio**.
