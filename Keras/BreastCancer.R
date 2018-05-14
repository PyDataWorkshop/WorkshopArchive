library(keras)
library(caret)
library(recipes)
library(rsample)

use_session_with_seed(06061979)
use_session_with_seed(6061979)
###########

data(BreastCancer)

head(BreastCancer)

BreastCancer <- BreastCancer[,-1]

BreastCancer <- initial_split(BreastCancer,prop=0.8, strata = "Class")

fullData <-list(train = training(BreastCancer),test = testing(BreastCancer) )

BCRecipe <- recipe(Class ~ . , fullData$train) %>%
  step_dummy(all_outcomes(), one_hot = TRUE, role = "outcome") %>%
  step_center(all_predictors()) %>%
  step_scale(all_predictors()) %>%
  prep(fullData$train) 

class(BCRecipe)



