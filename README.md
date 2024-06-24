This repository contains code for reproducing some of the examples from the
2024 ISBA BART short course.

# Required R Packages

The canonical reference manuals for installing R packages can
be found on CRAN at 
https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Installing-packages

For the packages needed in this course, we provide useful additional tips at 
https://github.com/theodds/2024-ISBA-Short/blob/master/Sessions/install.pdf
along with other BART computing advice such as multi-threading.

Below you will find a brief overview of installation instructions.  But, if you 
encounter any problems, please consult the documentation and notes above.

Most of the R packages needed can be installed from CRAN. There are 
exceptions that need to be installed using either the `remotes` or
the `devtools` package.
To install the necessary dependencies from CRAN, you should pick a
reliable local mirror.  Here, I'm using a popular US choice.

`R> options(repos=c(CRAN="http://lib.stat.cmu.edu/R/CRAN"))` \
`R> install.packages("Rcpp", dependencies=TRUE)` \
`R> install.packages("remotes", dependencies=TRUE)` \
`R> install.packages("devtools", dependencies=TRUE)` 

For Rob's presentation, you will want the following.
- `mBART`, the development version of the Monotonic BART package available at
https://github.com/remcc/mBART_shlib
For example, you can install it like so.

`R> library(remotes); install_github("remcc/mBART_shlib/mBART")`

For Tony's presentations, you will need the following.

- `Batman`, which contains miscellaneous BART functions, available here:
- `possum`, which performs posterior summarization, available here:
- `BART4RS`, which has some functions for fitting the Cox proportional hazards
   model, available here:
- `bcf`, the Bayesian Causal Forests package that has been archived by CRAN at https://cran.r-project.org/src/contrib/Archive/bcf
You can install it like so.

`R> library(remotes); install_url("https://cran.r-project.org/src/contrib/Archive/bcf/bcf_1.3.1.tar.gz")`

For Rodney's presentations, you will need the following.
- `BART3`, the development version of the BART package available at
https://github.com/rsparapa/bnptools
- `hbart`, the development version of the Heteroskedastic BART
package available in the same place.

For example, you can install BART3 like so.

`R> library(remotes); install_github("rsparapa/bnptools/BART3")`

# Replication Materials

All replication materials are in the `Examples/` directory. To use this
repository, simply do the following.

1. Clone the repository.
2. Open the .Rproj file using **RStudio**.
3. Open the notebooks in the `Examples/` directory.
4. Knit the files if desired, or run the files interactively in **RStudio**.
