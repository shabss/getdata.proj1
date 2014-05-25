### README.md

run_analysis.R produces a tidy data set that contains averages of means and standard deviation measurements of *Human Activity Recognition Using Smartphones Dataset Version 1.0* (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) downloadd from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The tidy data set is produced with the following steps:

* Convert feature names (in features.txt) to descriptive names as follows:
   * Convert to lower case
   * Characters '(', ')', '-' and ',' were converted to dot '.'
   * Wrap terms of mean, std, body, gyro, acc, jerk, mag, min, max, sma, mean and gravity within dots "." e.g "word"" --> ".word."
   * Remove consqutive and trailing dots 
   * "bandEnergy" variales actually represent ranges, therefore change "X-Y"" to XtoY
   * Rename duplicated "bandEnergy" variables to contain X,Y,Z coordinates
* Merge the training and the test sets
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Update Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names. 
Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

