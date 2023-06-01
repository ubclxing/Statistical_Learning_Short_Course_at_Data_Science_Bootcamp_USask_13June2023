# Linear Regression Practice Questions

1. Load in the *College* dataset from the `ISLR2` package
2. Split the data into training and testing dataset (**NOTE:** 80% for training and 20% for testing)
    * **NOTE:** Make sure to use `set.seed(2023)` to ensure consistent results
3. Build a linear regression model using `lm()`. Use `Grad.Rate` as the outcome variable. Use the remaining variables as predictors.
4. Use `predict()` to get predicted values from the build linear model
5. Using the predicted values and the true values, determine the MSE for this model
