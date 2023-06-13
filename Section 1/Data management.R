# USASK Data Science Bootcamp (June 7-16, 2023)
# June 13, 2023. T6: Statistical Machine Learning
# Session 1 (10:40pm-11:30pm): Data Management
# TA: Lina
# Tutors: Jing and Kyle


# Clear environment
rm(list=ls(all=TRUE)) 

###################################################################################
## Tidyverse is a collection of packages for R that are all designed to 
## work together to help users stay organized and efficient throughout their data
## science projects.
###################################################################################
######## install.packages("tidyverse")########
library(tidyverse)



######## library(readr) # for data import

file1<-write_file(x="a,b,c\n1,2,3\n4,5,NA",path="file1.csv")
file2<-write_file(x="a;b;c\n1;2;3\n4;5;NA",path="file2.csv")
file3<-write_file(x="a\tb\tc\n1\t2\t3\n4\t5\tNA",path="file3.tsv")

#Comma Delimited Files
read_csv("file1.csv")
x<-read_csv("file2.csv");problems(x) # use problems() to diagnose problems

#Semi-colon Delimited Files
read_csv2("file2.csv")

#Tab Delimited Files
read_tsv("file3.tsv")
or
read_table("file3.tsv")


##################################################################################
# library(Tidyr) for data tidying

# create data frame
df <- data.frame(player=c('A', 'B', 'C', 'D'),
                 year1=c(12, 15, 19, 19),
                 year2=c(22, 29, 18, 12))

df_long<-gather(df,key="year", value="point",year1, year2)

df_wide<-spread(df_long,year,point)


##################################################################################
#library(dplyr) for data manipulation
#loads All function from dply
library(dplyr)
library(ISLR2)

data(Auto)

View(Auto)

str(Auto)

#select columns
df1<-select(Auto,mpg,year);df1


#re-ordering the columns
df2<-select(Auto,year,mpg,name,everything());df2


#change the column name, $rename()$ function
df3<-rename(Auto,YEAR = year);df3


#filter the rows, filter()function
#get a new data frame in which the year is 70, and the origin is 1.

df4<-filter(Auto,year==70 & origin == 1);df4


# find the mpg where the value is between 14 and 18

df5<-filter(Auto,mpg <=18 & mpg >=14);df5

#create new columns, mutate()function can be used to create variables based on 
#existing variables from the dataset.

df6<-mutate(Auto,Ratio=acceleration/cylinders);df6

# also can create multiple columns at once, separating each new variable with a comma.

df7<-mutate(Auto,Ratio=acceleration/cylinders,Ratio2=acceleration*0.2);df7

# we can also use other functions inside the mutate() to create new variables.

df8<-mutate(Auto,m=mean(year));df8


#####################################################################################
# %>%: A pipes basically just pushes the data from whatever is before it to the 
#function that is after it.

#number of rows of Auto
Auto %>% nrow() 


# same result as used for df8
Auto %>% 
  mutate(m=mean(year))

# summarize() collapses all rows and returns a one-row summary
Auto %>%
  summarise(year_ave=mean(year),year_median=median(year),horsepower_ave=mean(horsepower))

# same result as used for df4
Auto %>%
  filter(year==70 & origin == 1)

# same result as used for df1
Auto %>%
  select(mpg,year)

#group_by(): Takes existing data and groups specific variables together for future operations.
# First, we group all the cars by year and find the average mpg for each group.
 Auto %>%
  group_by(year) %>%
  mutate(m=mean(mpg))%>%
  ungroup()


# creating/saving the object named Auto1

Auto1<-
  Auto %>%
  group_by(year) %>%
  mutate(m=mean(mpg))


  
Auto2<-
  Auto1 %>%
  mutate(x=mean(weight))

mean(Auto$weight)


# arrange(): Allows you to arrange values within a variable in ascending or descending 
# order (if that applies to your values).

# arrange mpg by numerical order(lowest to highest)
Auto %>% arrange(mpg)

# arrange year in descending numerical order
Auto %>% arrange(desc(year))
