# JHU-Practical Machine Learning assignment
ML Assignment
##Data
Loading the data from my drive D.
```
pmltrain <- read.csv("D:/coursera/jhu_ml/pml-training.csv")
pmltest <- read.csv("D:/coursera/jhu_ml/pml-testing.csv")
```
I divide the pml-training.csv into two sets for training and validation.
```
library(caret);library(randomForest)
set.seed(5000)
trainingset <- createDataPartition(pmltrain$classe,p=.75,list=FALSE)
mytraining <- pmltrain[trainingset,]
myvalidation <- pmltrain[-trainingset,]
```
