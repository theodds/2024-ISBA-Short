This repository contains code for reproducing some of the examples from the
2024 ISBA BART short course.

# Required Packages

Most of the R packages needed can be installed from CRAN. There are a few
of exceptions, which need to be installed from GitHub using the `devtools`
package. For Tony's presentations, you will need the following.

- `Batman`, which contains miscellaneous BART functions, available here:
- `possum`, which performs posterior summarization, available here:
- `BART4RS`, which has some functions for fitting the Cox proportional hazards
   model, available here:
- `bcf`, the Bayesian Causal Forests package that has been archived by CRAN at https://cran.r-project.org/src/contrib/Archive/bcf
You can install it like so.

R> library(remotes); install_url("https://cran.r-project.org/src/contrib/Archive/bcf/bcf_1.3.1.tar.gz")

For Rodney's presentations, you will need the following.
- `BART3`, the development version of the BART package available at
https://github.com/rsparapa/bnptools
You can install it like so.

R> library(remotes); install_github("rsparapa/bnptools/BART3")

For Rob's presentation, you will want the following.
- `mBART`, the development version of the Monotonic BART package available at
https://github.com/remcc/mBART_shlib
For example, you can install it like so.

R> library(remotes); install_github("remcc/mBART_shlib/mBART")

# Replication Materials

All replication amterials are in the `Examples/` directory. To use this
repository, simply do the following.

1. Clone the repository.
2. Open the .Rproj file using **RStudio**.
3. Open the notebooks in the `Examples/` directory.
4. Knit the files if desired, or run the files interactively in **RStudio**.
