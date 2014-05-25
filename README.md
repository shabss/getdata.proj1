### README.md


run_analysis.R produces a tidy data set that contains averages of means and standard deviation measurements of *Human Activity Recognition Using Smartphones Dataset Version 1.0* (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) downloadd from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Methodology
The tidy data set is produced with the following steps:

* Convert feature names (in features.txt) to descriptive names as follows (see name mappings below):
   * Convert to lower case
   * Characters '(', ')', '-' and ',' were converted to dot '.'
   * Wrap terms of mean, std, body, gyro, acc, jerk, mag, min, max, sma, mean and gravity within dots "." e.g "word"" --> ".word."
   * Remove consqutive and trailing dots 
   * "bandEnergy" variales actually represent ranges, therefore change "X-Y" to "XtoY"
   * Rename duplicated "bandEnergy" variables to contain X,Y,Z coordinates
* Produce a merged data set
   * Merge the training and the test sets while adding respecitve subjects for each row and using activity names instead of codes (loaded from activity_labels.txt)
* From the merged data set, extract columns that contain the mean and standard deviation for each measurement (see name mappings below)
   * Columns are selected by grep-ing "mean" and "std" from the feature names
* Produce the tidy data set with the average of each feature for each activity and each subject

### Feature name mapping
