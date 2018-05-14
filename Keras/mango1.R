#Erum Day 1

library(keras)
library(caret)
library(recipes)
library(rsample)

use_session_with_seed(06061979)
use_session_with_seed(6061979)
###########
y <- iris[,5]
X <- iris[1:4,]

iris <- initial_split(iris,prop=0.8, strata = "Species")

fullData <-list(train = training(iris),test = testing(iris) )

irisRecipe <- recipe(Species ~ . , fullData$train) %>%
  step_dummy(all_outcomes(), one_hot = TRUE, role = "outcome") %>%
  prep(fullData$train) %>%
  bake(newdata = fullData$train) 

irisRecipe <- recipe(Species ~ . , fullData$train) %>%
  step_dummy(all_outcomes(), one_hot = TRUE, role = "outcome") %>%
  step_center(all_predictors()) %>%
  step_scale(all_predictors()) %>%
  prep(fullData$train) 






