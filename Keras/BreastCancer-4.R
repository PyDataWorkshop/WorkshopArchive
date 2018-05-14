# Exercise 2-5 ---------------------------------------------------------

# 1.	Load the BreastCancer data
library(mlbench)
data("BreastCancer")

# 2.	Remove the Id column and convert all but the Class column to numeric
bc <- BreastCancer %>%
  select(-Id) %>%
  mutate_at(vars(-Class), as.numeric)

# 3.	Split the data so that 80% is used for training and 20% for testing
bcSplit <- initial_split(bc, strata = "Class", prop = 0.8)

bcFull <- list(train = analysis(bcSplit), 
               test = assessment(bcSplit))


# 4.	Create dummy variables for the class variable 
# 5.	Scale the numeric variables

bc_recipe <- recipe(Class ~ ., data = bcFull$train) %>%
  step_dummy(Class, one_hot = TRUE, role = "outcome") %>%
  step_center(all_predictors()) %>%
  step_scale(all_predictors()) %>%
  step_meanimpute(all_predictors(), means = 0) %>%
  prep(bcFull$train)

bcX <- map(bcFull, ~ bake(object = bc_recipe, 
                          newdata = .x,
                          all_predictors()))

bcY <- map(bcFull, ~ bake(object = bc_recipe, 
                          newdata = .x,
                          all_outcomes()))

# 6.	Replace all missing values with 0
bcX <- map(bcX, ~ map_df(.x, replace_na, replace = 0))


# 7.	Convert the target and feature data frames to matrices

xData <- map(bcX, as.matrix)
yData <- map(bcY, as.matrix)



############# Building models -----------------

model <- keras_model_sequential()

## Add layers

model %>%
  layer_dense(units = 10, input_shape = 4) %>%
  layer_dense(units = 3, activation = 'softmax')


## Define compilation

model %>% compile(
  optimizer = 'rmsprop',
  loss = 'categorical_crossentropy',
  metrics = 'accuracy'
)

## Train the model

history <- model %>% fit(xIris$train, 
                         yIris$train, 
                         epochs = 100, 
                         validation_data = list(xIris$test, yIris$test))

summary(model)

###########################################################################

# Create a model with 5 hidden units
# A dense, output layer using the "sigmoid" activation function
# Compile the model using the "binary_crossentropy" as the loss function
# Fit the model over 20 epochs
