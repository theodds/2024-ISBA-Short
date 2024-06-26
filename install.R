## Ignore this block: I used it to test that this all works in a fresh R
## library without any other packages installed
if(FALSE) {
  # Create a new, empty directory for our test library
  test_lib <- file.path(tempdir(), "test_library")
  dir.create(test_lib, showWarnings = FALSE)
  
  # Set the new directory as our library path
  .libPaths(test_lib)  
}


## Install CRAN packages, if needed ----

install.packages("tidyverse")
install.packages("devtools")
install.packages("RcppArmadillo")
install.packages("Rcpp")
install.packages("patchwork")
install.packages("spBayesSurv")
install.packages("mgcv")
install.packages("rpart")
install.packages("rpart.plot")
install.packages("tidybayes")
install.packages("ggdist")
install.packages("latex2exp")
install.packages("caret")

## Github remote installs ----

install_url("https://cran.r-project.org/src/contrib/Archive/bcf/bcf_1.3.1.tar.gz")
install_github("remcc/mBART_shlib/mBART")
install_github("rsparapa/bnptools/BART3")
install_github("theodds/Batman")
install_github("spencerwoody/possum")
install_github("theodds/BART4RS")

