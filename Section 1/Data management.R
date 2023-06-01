## Tidyverse Tidyverse is a collection of packages for R that are all designed to 
## work together to help users stay organized and efficient throughout their data
## science projects.

# install.packages("tidyverse")
library(tidyverse)
library(ISLR2)

data(Default)
data(Auto)


#library(readr) # for data import

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



# library(Tidyr) for data tidying

#create data frame
df <- data.frame(player=c('A', 'B', 'C', 'D'),
                 year1=c(12, 15, 19, 19),
                 year2=c(22, 29, 18, 12))

df_long<-gather(df,key="year", value="point",year1, year2)

df_wide<-spread(df_long,year,point)



#library(dplyr) for data manipulation
#loads All function from dply

#loads ONLY the filter function from dplyr
dplyr::filter()


auto<-Auto
#select columns
df1<-select(auto,mpg,year)


#re-ordering the columns
df2<-select(auto,year,mpg,name,everything())


#change the column name, $rename()$ function
df3<-rename(auto,YEAR = year)


#filter the rows, filter()function
#get a new dataframe in which the year is 70 and the origin is 1.

df4<-filter(auto,year==70 & origin == 1)


#Find the mpg where value is between 14 and 18

df5<-filter(auto,mpg <=18 & mpg >=14)


##create new columns,mutate()function can be used to create variables besed on 
#existing variables from the dataset.

df6<-mutate(auto,Ratio=acceleration/cylinders)

# Also can create multiple columns at once, separating each new variable with a comma

df7<-mutate(auto,Ratio=acceleration/cylinders,Ratio2=acceleration*0.2)

# we can also use other functions inside the mutate() to create our new variables.

df8<-mutate(auto,m=mean(year))


# %>%: A pipes basically just pushes the data from whatever is before it to the 
#function that is after it.

auto %>% nrow() #number of rows of auto

# summarize() collapses all rows and returns a one-row summary
auto %>%
  summarise(year_ave=mean(year),year_median=median(year),horsepower_ave=mean(horsepower))

#group_by():Takes existing data and groups specific variables together for future operations.
# first group all the cars by the year, we find the average mpg for each group.
auto %>%
  group_by(year) %>%
  summarise(mean(mpg))

# creating/saving the object named auto1
auto1<-
  auto %>%
  group_by(cylinders) %>%
  mutate(ave=mean(horsepower))

# arrange():Allows you arrange values 
#within a variable in ascending or descending order (if that is applicable to your values).

# arrange mpg by numerical order(lowest to highest)
auto %>% arrange(mpg)

# arrange year in descending numerical order
auto %>% arrange(desc(year))

