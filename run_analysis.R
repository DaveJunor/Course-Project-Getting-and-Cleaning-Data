#####################################################
# Dave Junor
# July 20, 2016
# Getting and Cleaning Data Course Project
# 1. Merge the training and test data sets.
# 2. Extract only the measurements on the mean and
#       standard deviation for each measurement.
# 3. Use descriptive activity names. 
# 4. Appropriately label the data set with descriptive
#       variable names.
# 5. Create a tidy data set from step 4 containing the
#       average of each variable for each combination
#       of activity and subject.
#####################################################

library(dplyr)
setwd("C:/Users/Dave/Documents/DataScienceSpecialization/GettingCleaningData/Week04/CourseProject")

# Step 1.
# Read in Variable and Activity labels
featureLabels <- read.table("UCI HAR Dataset/features.txt", sep = "", header = FALSE)
featureLabels[,2] <- as.character(featureLabels[,2])
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)
activityLabels[,2] <- as.character(activityLabels[,2])

# Read in data fiels
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE) 
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)

# Merge Test and Training Data Sets
testData <- cbind(subjectTest, yTest, xTest)
trainData <- cbind(subjectTrain, yTrain, xTrain)
allData <- rbind(testData, trainData)

# Assign variable names to columns
colnames(allData) <- c("Activity", "SubjectID", featureLabels[,2])
allData <- allData[, !duplicated(colnames(allData))]

# Use factors to provide descriptive Activity names
allData$Activity <- factor(allData$Activity, levels = activityLabels[,1], labels = activityLabels[,2])
# allData$SubjectID <- as.factor(allData$SubjectID)

# Extract only measurements on the mean and standard deviation
MeanStdFeatures <- featureLabels$V2[grep("mean\\(\\)|std\\(\\)", featureLabels$V2)]
selectedFeatureNames <- c("Activity", "SubjectID", as.character(MeanStdFeatures))
MeanStdData <- subset(allData, select = selectedFeatureNames)

# Use descriptive variable names
names(MeanStdData) <- gsub("^t", "time", names(MeanStdData))
names(MeanStdData) <- gsub("^f", "frequency", names(MeanStdData))
names(MeanStdData) <- gsub("Acc", "Accelerometer", names(MeanStdData))
names(MeanStdData) <- gsub("Gyro", "Gyroscope", names(MeanStdData))
names(MeanStdData) <- gsub("Mag", "Magnitude", names(MeanStdData))
names(MeanStdData) <- gsub("BodyBody", "Body", names(MeanStdData))
names(MeanStdData) <- gsub("mean", "Mean", names(MeanStdData))
names(MeanStdData) <- gsub("std", "STD", names(MeanStdData))
names(MeanStdData) <- gsub("[()]", "", names(MeanStdData))

# Create tidy data set of mean for each combination of Activity and SubjectID
tidyData <- aggregate(. ~Activity + SubjectID, MeanStdData, mean)
tidyData <- tidyData[order(tidyData$Activity, tidyData$SubjectID),]
write.table(tidyData, file = "tidydata.txt", sep = ",", row.names = FALSE)




