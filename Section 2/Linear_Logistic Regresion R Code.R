# USASK Data Science Bootcamp (June 7-16)
# Learning Machine Learning and R
# Linear and Logistic Regression Tutorial



# Clear environment
rm(list=ls(all=TRUE)) 

# Loading in libraries
library(ISLR2)
library(caret) 


### LINEAR REGRESSION


############ Loading in the data ###########

data(Auto) 

# Help section for the data
?Auto

# Displaying the structure of the data
str(Auto) 
dim(Auto) 

sum(is.na(Auto)) 


############# Splitting the data #############

set.seed(1) 
id<-sample(nrow(Auto),round(nrow(Auto)*0.80)) 
auto.train.data<-Auto[id,] 
auto.test.data<-Auto[-id,]



############ Linear Regression model building ###########

linear.model<-lm(mpg~ as.factor(cylinders)+ displacement+ horsepower+ weight+ acceleration+
                   as.factor(year)+ as.factor(origin), data=auto.train.data)

summary(linear.model)



################### Model Accuracy ##################

# predicting values
predicted.values<-predict(linear.model, auto.test.data)

# calculating mse
mean((auto.test.data$mpg-predicted.values)^2)










### LOGISTIC REGRESSION

############ Loading in the data ###########

data(Default)

# help section for data
?Default

# data structure 
str(Default)
dim(Default)

sum(is.na(Default)) 


########## Recoding outcome ###############

Default$default<-ifelse(Default$default=="Yes",1,0)


########## Splitting the data ############

set.seed(1) 
id<-sample(nrow(Default),round(nrow(Default)*0.80))  
debt.train.data<-Default[id,] 
debt.test.data<-Default[-id,]


############ Logistic Regression model building ############

logistic.model<-glm(default~., family="binomial", data=debt.train.data)

summary(logistic.model)


############ Model Accuracy #################

# predicting values
logistic.predicted.values<-predict(logistic.model, debt.test.data , type="response")

# converting probabilities into 0 or 1
debt.test.data$pred.outcome<-ifelse(logistic.predicted.values>0.5,1,0)

# confusionMatrix
confusionMatrix(as.factor(debt.test.data$default), as.factor(debt.test.data$pred.outcome))















































