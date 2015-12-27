##------------------------
pmltrain <- read.csv("D:/coursera/jhu_ml/pml-training.csv")
pmltest <- read.csv("D:/coursera/jhu_ml/pml-testing.csv")

library(caret);library(randomForest)
set.seed(5000)
trainingset <- createDataPartition(pmltrain$classe,p=.75,list=FALSE)
mytraining <- pmltrain[trainingset,]
myvalidation <- pmltrain[-trainingset,]

##--------------------
zerovar <- nearZeroVar(mytraining)
mytraining <- mytraining[,-zerovar]
##-------------------
nocols <- c("X", "user_name", "raw_timestamp_part_1",
                    "raw_timestamp_part_2", "cvtd_timestamp")
for (col in nocols) {
    mytraining[, col] <- NULL
}

NAs <- apply(mytraining,2,function(x) {sum(is.na(x))})
mytraining <- mytraining[,which(NAs == 0)]

#----------------------------------
rfmodel <- randomForest(classe ~ ., data = mytraining, ntrees = 50, importance = TRUE )
p1 <- predict(rfmodel, mytraining)
print(confusionMatrix(p1, mytraining$classe))
##------------------------
p2 <- predict(rfmodel, myvalidation)
print(confusionMatrix(p2, myvalidation$classe))
