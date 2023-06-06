# USASK Data Science Bootcamp (June 7-16, 2023)
# June 13, 2023. T6: Statistical Machine Learning
# Session 3 (3:50pm-4:30pm): Ridge, Lasso, Elastic Net Tutorial
# TA: Kyle
# Tutors: Lina and Jing


# Clear environment
rm(list=ls(all=TRUE)) 

# Loading in libraries
library(ISLR2)
library(glmnet)
library(caret) 


############ Loading in the data ###########

data(Auto) 

# Help section for the data
?Auto

# Displaying the structure of the data
str(Auto) 
dim(Auto) 

sum(is.na(Auto)) 


############ Formatting the data ##############

# converting to factors
Auto$cylinders<-as.factor(Auto$cylinders)
Auto$year<-as.factor(Auto$year)
Auto$origin<-as.factor(Auto$origin)

# creating design matrix
xx <- model.matrix(mpg ~., Auto[,-9]) # using all the predictors except for 'name'
yy <- Auto$mpg # defining the outcome variable; 'mpg'

# specifying object for grid search
grid<-10^seq(10, -2, length=100)


################ Splitting Data #############
set.seed(1)
id<-sample(nrow(Auto),round(nrow(Auto)*0.80)) 
xx.train<-xx[id,]
xx.test<-xx[-id,]
yy.train<-yy[id]
yy.test<-yy[-id]







### RIDGE REGRESSION

######### Model Building #############

ridge.mod <- glmnet(xx.train, yy.train, alpha = 0, lambda = grid)

plot(ridge.mod, label = T)


############## Cross Validation ###########

ridge.cv <- cv.glmnet(xx.train, yy.train, alpha = 0, lambda = grid, nfolds=10) 

plot(ridge.cv)


############ Model Accuracy #############

# extracting best lambda
bestlam.ridge <- ridge.cv$lambda.1se

# predicting values
ridge.pred=predict(ridge.mod, s=bestlam.ridge, newx=xx.test)

# calculating mse
mean((ridge.pred-yy.test)^2)





### LASSO REGRESSION

########### Model Building #################

lasso.mod <- glmnet(xx.train, yy.train, alpha = 0, lambda = grid)

plot(lasso.mod, label = T)


############ Cross Validation ############

lasso.cv <- cv.glmnet(xx.train, yy.train, alpha = 0, lambda = grid, nfolds=10)

plot(lasso.cv)


########## Model Accuracy #################

# extrating best lambda
bestlam.lasso <- lasso.cv$lambda.1se # can either use 'lambda.min' or 'lambda.1se'

# predicting values
lasso.pred=predict(lasso.mod, s=bestlam.lasso, newx=xx.test) # predicting the values using the non-cv ridge model and the best lambda from cross validation

# calculating mse
mean((lasso.pred-yy.test)^2)





### ELASTIC NET

############# Cross Validation ##############

# defining control parameters
cv_10 = trainControl(method = "cv", number = 10)

# fitting cv model
set.seed(1)
elastic.net.cv = train(
  mpg ~.,             # formula to predict mpg
  data = Auto[id,-9], # using the training data with all the predictor, except for 'name'
  method = "glmnet",  # 'method="glmnet"' specifies using elastic net
  trControl = cv_10) 

elastic.net.cv


############# Extracting best alpha and lambda ################

# determing smallest RMSE
myid <- order(elastic.net.cv$results$RMSE)[1] 

# extracting alpha and lamba that correspond to smallest RMSE
mybest.alpha <- elastic.net.cv$results$alpha[myid]
mybest.lambda <- elastic.net.cv$results$lambda[myid] 


########## Model Fitting ###############

elastic.net.model<- glmnet(xx.train, yy.train, alpha = mybest.alpha, lambda = mybest.lambda)

coef(elastic.net.model)


########## Model Accuracy ###############

# predicting values
elastic.net.pred<-predict(elastic.net.model, s=mybest.lambda, newx=xx.test)

# calculating mse
mean((elastic.net.pred-yy.test)^2)











































