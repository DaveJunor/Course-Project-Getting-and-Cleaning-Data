# Course-Project-Getting-and-Cleaning-Data
Coursera: Getting and Cleaning Data Course Project

The purose of the project is to demonstrate your ability to collect, work with, and clean a data set.

Criteria
1. Merge training and test data sets provided into one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to mane the activities in the data set.
4. Appropiately lables the data set with descriptive variable names.
5. From the data set in step 4, create a second, independently tidy data set with the average of each variable for each activity and each subject.

Steps
1. The data set was downloaded and unzipped into a project directory.
2. A run_analaysis.R script was developed that loads the data into R and processes the data against the above criteria to produce a tidy data set called tidy.txt.
3. The tidy data set contains descriptive variatble names (ex. Gyroscope instead of Gyro; time instead of t).
4. The Activities have been converted to factors and populate the tidy data set with activity descriptions instead of numeric values.
5. Although the tidy data set contains the mean of all variables indicated in the above criteria for each activity and subject, the mean as applied here is not necessarily a meaningful measurement.  The mean was processed under the assumption that the purpose of the assignement was to demonstrate the ability to collect, work with, and clean a data set.
