# JHU-Practical Machine Learning assignment
This is my first github file and I just learn how to use it yesterday. I don't know why the codes below are monochrome since I know they should be marked with different colors.
Please forgive me for that!
##Data
Loading the data from my drive D.
```
pmltrain <- read.csv("D:/coursera/jhu_ml/pml-training.csv")
pmltest <- read.csv("D:/coursera/jhu_ml/pml-testing.csv")
```
I divide the pml-training.csv into two sets for training and validation with the ratio of 75% to 25%.
```
library(caret);library(randomForest)
set.seed(5000)
trainingset <- createDataPartition(pmltrain$classe,p=.75,list=FALSE)
mytraining <- pmltrain[trainingset,]
myvalidation <- pmltrain[-trainingset,]
```

##Preprocessing
First, I delete near zero variance features.
```
zerovar <- nearZeroVar(mytraining) 
mytraining <- mytraining[,-zerovar]
```
Then I delete some useless features such as index, user_name etc and NA features.
```
nocols <- c("X", "user_name", "raw_timestamp_part_1",
                    "raw_timestamp_part_2", "cvtd_timestamp")
for (col in nocols) {
    mytraining[, col] <- NULL
}

NAs <- apply(mytraining,2,function(x) {sum(is.na(x))})
mytraining <- mytraining[,which(NAs == 0)]
```
The final training set is named mytraining.

##Modeling
I use randomForest caret to predict the model.
```
rfmodel <- randomForest(classe ~ ., data = mytraining, ntrees = 50, importance = TRUE )
p1 <- predict(rfmodel, mytraining)
print(confusionMatrix(p1, mytraining$classe))
```
The reslut shows:
Confusion Matrix and Statistics

          Reference
Prediction    A    B    C    D    E
          A 4185    0    0    0    0
          B    0 2848    0    0    0
          C    0    0 2567    0    0
          D    0    0    0 2412    0
          E    0    0    0    0 2706

Overall Statistics
                                     
               Accuracy : 1          
                 95% CI : (0.9997, 1)
    No Information Rate : 0.2843     
    P-Value [Acc > NIR] : < 2.2e-16  
                                     
                  Kappa : 1          
 Mcnemar's Test P-Value : NA         

Statistics by Class:

                     Class: A Class: B Class: C Class: D Class: E
Sensitivity            1.0000   1.0000   1.0000   1.0000   1.0000
Specificity            1.0000   1.0000   1.0000   1.0000   1.0000
Pos Pred Value         1.0000   1.0000   1.0000   1.0000   1.0000
Neg Pred Value         1.0000   1.0000   1.0000   1.0000   1.0000
Prevalence             0.2843   0.1935   0.1744   0.1639   0.1839
Detection Rate         0.2843   0.1935   0.1744   0.1639   0.1839
Detection Prevalence   0.2843   0.1935   0.1744   0.1639   0.1839
Balanced Accuracy      1.0000   1.0000   1.0000   1.0000   1.0000



