
irisModel %>%
 fit(x = xIris$train,
     y = yItis$train,
     epochs = 100, 
     validation_data = list(xIris$test, yIris$test)
    )
###################################

# Compile Step
#  - Optimizer : rmsprop
#  - metrics = "accuracy"

###################################

# Model Evaluation

irisModel %>% 
 evaluate(xIris$test,yIris$test)

