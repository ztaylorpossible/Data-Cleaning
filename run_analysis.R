features <- read.table("features.txt")
featureIndex <- grep("mean|std", features[,2], value=FALSE)
features <- features[featureIndex,]
activityLabels <- read.table("activity_labels.txt")

trainData <- read.table("train/X_train.txt")
trainData <- trainData[,features$V1]
names(trainData) <- features$V2
trainSubject <- read.table("train/subject_train.txt")
names(trainSubject) <- "Subject"
trainActivity <- read.table("train/y_train.txt")
names(trainActivity) <- "Activity"
for (i in 1:nrow(trainActivity)) {
    trainActivity[i,1] <- as.character(activityLabels[trainActivity[i,1],2])
}
trainData <- cbind(trainSubject, trainActivity, trainData)
rm(trainSubject)
rm(trainActivity)

testData <- read.table("test/X_test.txt")
testData <- testData[,features$V1]
names(testData) <- features$V2
testSubject <- read.table("test/subject_test.txt")
names(testSubject) <- "Subject"
testActivity <- read.table("test/y_test.txt")
names(testActivity) <- "Activity"
for (i in 1:nrow(testActivity)) {
  testActivity[i,1] <- as.character(activityLabels[testActivity[i,1],2])
}
testData <- cbind(testSubject, testActivity, testData)
rm(testSubject)
rm(testActivity)

data <- rbind(trainData, testData)
rm(trainData)
rm(testData)

data$Subject <- factor(data$Subject)
data$Activity <- factor(data$Activity)

tidyData <- data.frame(matrix(nrow = 0, ncol = 81))
names(tidyData) <- names(data)
for (i in levels(data$Subject)) {
    for (j in levels(data$Activity)) {
        means <- colMeans(subset(data, Subject == i & Activity == j)[,3:81])
        tidyData[nrow(tidyData)+1,] <- c(i, j, means)
    }
}

write.table(tidyData, "tidy_data.txt", row.names=FALSE)