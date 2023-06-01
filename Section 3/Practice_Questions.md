# Elastic Net Practice Questions

1. Load in the `College` dataset from the `ISLR2` package
2. Use `model.matrix()` to create a design matrix where `Grad.Rate` is the outcome and the remaining variables are the predictors.
3. Split the data into training and testing dataset (**NOTE:** 80% for training and 20% for testing)
   * **NOTE:** Make sure to use `set.seed(2023)` to ensure consistent results
4. Define a 10-fold cross validation control parameter using `trainControl()`
5. Use `train()` to build cross validation elastic net model
  * `Grad.Rate` is the response
  * All the remaining variables are predictors
6. Extract the α and λ that corresponds to the smallest RMSE
7. Using `glmnet()` build a non-cv elastic net model with &alpha and &lambda from step 6
8. Use `predict()` to get the predicted values from the non-cv elastic net model
9. Using the predicted values and the true values, calculate MSE for the model 
