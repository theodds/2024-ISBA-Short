## Load ------------------------------------------------------------------------

library(tidyverse)
library(useful)
library(possum)
library(Batman)

crabs <- read_csv("https://raw.githubusercontent.com/theodds/SDS-348/master/crabs.csv")

## Fit model -------------------------------------------------------------------

set.seed(1234)

f <- function() {
  formula_crab <- satell ~ color + spine + width + weight - 1
  X <- build.x(formula_crab, crabs, contrasts = FALSE)
  
  X_test <- X
  X_test[,1:4] <- 0
  X_dark <- X_test; X_dark[,1] <- 1
  X_darker <- X_test; X_darker[,2] <- 1
  X_light <- X_test; X_light[,3] <- 1
  X_medium <- X_test; X_medium[,4] <- 1
  X_test <- rbind(X_dark, X_darker, X_light, X_medium)
  
  X <- SoftBart::quantile_normalize_bart(X)
  y <- crabs$satell
  probs <- Matrix::Matrix(data = 0, nrow = ncol(X), ncol = 4)
  probs[,1] <- c(1, 1, 1, 1, 0, 0, 0, 0, 0) / 4
  probs[,2] <- c(0,0,0,0,1,1,1,0,0) / 3
  probs[8,3] <- 1
  probs[9,4] <- 1
  
  out <- QNBBart(X = X, Y = y, X_test = X_test, probs = probs, num_trees = 50,
                 scale_lambda = 1 / sqrt(num_tree), scale_lambda_0 = 1, 
                 update_s = FALSE,
                 num_burn = 5000, num_thin = 1, num_save = 5000)
}


fitted_crabs <- f()

## Posterior of 1 / sqrt(k) ----------------------------------------------------

params <- data.frame(k = fitted_crabs$k)
ggplot(params, aes(x = k)) + geom_histogram(color = 'white') + theme_bw() + 
  xlab("k") + ylab("Frequency") + 
  ggtitle("Posterior of Overdispersion Parameter")

## GLM Comparison --------------------------------------------------------------

MASS::glm.nb(satell ~ color + spine + width + weight, data = crabs) %>%
  summary()

## Variable Counts -------------------------------------------------------------

barplot(colMeans(fitted_crabs$counts), 
        names.arg = c("Color", "Spine", "Width", "Weight"))

## Assessing Size  -------------------------------------------------------------

crabs2 <- crabs %>% mutate(color = as.factor(color), spine = as.factor(spine),
                           r = colMeans(fitted_crabs$lambda))

full <- possum::additive_summary(r ~ factor(color) + factor(spine) + s(width) + s(weight),
                                 fhatSamples = t(fitted_crabs$lambda),
                                 df = crabs2)
q_1 <- additive_summary_plot(full) + theme_bw()

drop_weight <- possum::additive_summary(r ~ factor(color) + factor(spine) + s(width),
                                        fhatSamples = t(fitted_crabs$lambda),
                                        df = crabs2)

drop_width <- possum::additive_summary(r ~ factor(color) + factor(spine) + s(weight),
                         fhatSamples = t(fitted_crabs$lambda),
                         df = crabs2)

q_2 <- additive_summary_plot(drop_weight) + theme_bw()
q_3 <- additive_summary_plot(drop_width) + theme_bw()

drop_both_rsq <- sapply(1:nrow(fitted_crabs$lambda_test), \(i) {
  df <- mutate(crabs, r = fitted_crabs$lambda[i,])
  summary(lm(r ~ color * spine, data = df))[["r.squared"]]
})

q_4 <- qplot(drop_both_rsq) + theme_bw() + 
  xlab("Summary R-Squared, No Size Variables")

q_1 / (q_2 + q_3) / q_4

## Color Assessment ------------------------------------------------------------

rows_dark <- 1:ncol(fitted_crabs$lambda)
rows_darker <- 1:ncol(fitted_crabs$lambda) + ncol(fitted_crabs$lambda)
rows_light <- 1:ncol(fitted_crabs$lambda) + 2 * ncol(fitted_crabs$lambda)
rows_medium <- 1:ncol(fitted_crabs$lambda) + 3 * ncol(fitted_crabs$lambda)

get_contrasts <- function() {
  x <- fitted_crabs$lambda_test
  avg <- rowMeans(x[,rows_dark] + x[,rows_darker] + x[,rows_light] + x[,rows_medium])
  avg <- avg / 4
  iter <- 1:nrow(x)
  out <-
    data.frame(
      iter = iter,
      dark = x[, rows_dark] %>% rowMeans - avg,
      darker = x[, rows_darker] %>% rowMeans - avg,
      light = x[, rows_light] %>% rowMeans - avg,
      medium = x[,rows_medium] %>% rowMeans - avg 
    )
  return(out)
}

color_df <- get_contrasts()
color_long <- pivot_longer(color_df, cols = c(dark, darker, light, medium), 
                           names_to = "color", values_to = "average")
ggplot(color_long, aes(x = color, y = average)) + geom_boxplot() + theme_bw()


