# JHU-Practical Machine Learning assignment
This is my first github file and I just learn how to use it yesterday. I don't know why the codes below are monochrome since I know they should be marked with different colors. And there are some format mistakes I don't know how to correct.


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
Sensitivity            1.0000   1.0000   1.0000   1.0000   1.0000<br>
Specificity            1.0000   1.0000   1.0000   1.0000   1.0000<br>
Pos Pred Value         1.0000   1.0000   1.0000   1.0000   1.0000<br>
Neg Pred Value         1.0000   1.0000   1.0000   1.0000   1.0000<br>
Prevalence             0.2843   0.1935   0.1744   0.1639   0.1839<br>
Detection Rate         0.2843   0.1935   0.1744   0.1639   0.1839<br>
Detection Prevalence   0.2843   0.1935   0.1744   0.1639   0.1839<br>
Balanced Accuracy      1.0000   1.0000   1.0000   1.0000   1.0000<br>

The model runs smoothly

##Cross validation
I check my model on the validation set.
```
p2 <- predict(rfmodel, myvalidation)
print(confusionMatrix(p2, myvalidation$classe))
```

The result shows below:

Confusion Matrix and Statistics

          Reference
Prediction    A    B    C    D    E
         A 1395    3    0    0    0<br>
         B    0  945    4    0    0<br>
         C    0    1  851    0    0<br>
         D    0    0    0  804    0<br>
         E    0    0    0    0  901<br>

Overall Statistics
                                          
               Accuracy : 0.9984          
                 95% CI : (0.9968, 0.9993)
    No Information Rate : 0.2845          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.9979          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: A Class: B Class: C Class: D Class: E  
Sensitivity            1.0000   0.9958   0.9953   1.0000   1.0000<br>
Specificity            0.9991   0.9990   0.9998   1.0000   1.0000<br>
Pos Pred Value         0.9979   0.9958   0.9988   1.0000   1.0000<br>
Neg Pred Value         1.0000   0.9990   0.9990   1.0000   1.0000<br>
Prevalence             0.2845   0.1935   0.1743   0.1639   0.1837<br>
Detection Rate         0.2845   0.1927   0.1735   0.1639   0.1837<br>
Detection Prevalence   0.2851   0.1935   0.1737   0.1639   0.1837<br>
Balanced Accuracy      0.9996   0.9974   0.9975   1.0000   1.0000<br>

The accuracy of cross valdiation is 99.79% and I think it is not bad.

##Testing
I use the above model to run the test set which is named pmltesting.
```
finaltest <- predict(rfmodel, pmltest)
finaltest
```

The results shows:
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20<br>
B A B A A E D B A  A  B  C  B  A  E  E  A  B  B  B<br>
Levels: A B C D E






