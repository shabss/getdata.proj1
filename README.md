
## Intent

run_analysis.R produces a tidy data set that contains averages of means and standard deviation measurements of *Human Activity Recognition Using Smartphones Dataset Version 1.0* (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Instructions
Download the zip file above and extract it. Copy run_analysis.R to that folder and source it from R (after chaging working directory to unzipped file folder). tidy.txt will be produced after sourcing is complete

## Methodology
The tidy data set is produced with the following steps:

* Convert feature names (in features.txt) to descriptive names as follows (see name mappings below):
   * Convert to lower case
   * Characters '(', ')', '-' and ',' were converted to dot '.'
   * Wrap terms of mean, std, body, gyro, acc, jerk, mag, min, max, sma, mean and gravity within dots "." e.g "word"" --> ".word."
   * Remove consequtive and trailing dots 
   * "bandEnergy" variales actually represent ranges, therefore change "X-Y" to "XtoY"
   * Rename duplicated "bandEnergy" variables to contain X,Y,Z coordinates
* Produce a merged data set
   * Merge the training and the test sets while adding respecitve subjects for each row and using activity names instead of codes (loaded from activity_labels.txt)
* From the merged data set, extract columns that contain the mean and standard deviation for each measurement (see name mappings below)
   * Columns are selected by grep-ing "mean" and "std" from the feature names
* Produce the tidy data set with the average of each feature for each activity and each subject

## Feature name mapping
Please look at the feature_info.txt in the downloaded zip file for information on raw names. As indicated above, the raw names were converted into descriptive names. Following table contains the conversion info.

<table>
<tr><td> Seq </td><td> Raw Name </td><td> Descriptive Name </td><tr>
<tr><td> 1 </td><td> &lt;from subject_XXX.txt&gt;</td><td>subject</td><tr>
<tr><td> 2 </td><td> &lt;from activity_label.txt&gt;</td><td>activity</td><tr>
<tr><td> 3 </td><td> tBodyAcc-mean()-X </td><td> t.body.acc.mean.x </td><tr>
<tr><td> 4 </td><td> tBodyAcc-mean()-Y </td><td> t.body.acc.mean.y </td><tr>
<tr><td> 5 </td><td> tBodyAcc-mean()-Z </td><td> t.body.acc.mean.z </td><tr>
<tr><td> 6 </td><td> tBodyAcc-std()-X </td><td> t.body.acc.std.x </td><tr>
<tr><td> 7 </td><td> tBodyAcc-std()-Y </td><td> t.body.acc.std.y </td><tr>
<tr><td> 8 </td><td> tBodyAcc-std()-Z </td><td> t.body.acc.std.z </td><tr>
<tr><td> 9 </td><td> tGravityAcc-mean()-X </td><td> t.gravity.acc.mean.x </td><tr>
<tr><td> 10 </td><td> tGravityAcc-mean()-Y </td><td> t.gravity.acc.mean.y </td><tr>
<tr><td> 11 </td><td> tGravityAcc-mean()-Z </td><td> t.gravity.acc.mean.z </td><tr>
<tr><td> 12 </td><td> tGravityAcc-std()-X </td><td> t.gravity.acc.std.x </td><tr>
<tr><td> 13 </td><td> tGravityAcc-std()-Y </td><td> t.gravity.acc.std.y </td><tr>
<tr><td> 14 </td><td> tGravityAcc-std()-Z </td><td> t.gravity.acc.std.z </td><tr>
<tr><td> 15 </td><td> tBodyAccJerk-mean()-X </td><td> t.body.acc.jerk.mean.x </td><tr>
<tr><td> 16 </td><td> tBodyAccJerk-mean()-Y </td><td> t.body.acc.jerk.mean.y </td><tr>
<tr><td> 17 </td><td> tBodyAccJerk-mean()-Z </td><td> t.body.acc.jerk.mean.z </td><tr>
<tr><td> 18 </td><td> tBodyAccJerk-std()-X </td><td> t.body.acc.jerk.std.x </td><tr>
<tr><td> 19 </td><td> tBodyAccJerk-std()-Y </td><td> t.body.acc.jerk.std.y </td><tr>
<tr><td> 20 </td><td> tBodyAccJerk-std()-Z </td><td> t.body.acc.jerk.std.z </td><tr>
<tr><td> 21 </td><td> tBodyGyro-mean()-X </td><td> t.body.gyro.mean.x </td><tr>
<tr><td> 22 </td><td> tBodyGyro-mean()-Y </td><td> t.body.gyro.mean.y </td><tr>
<tr><td> 23 </td><td> tBodyGyro-mean()-Z </td><td> t.body.gyro.mean.z </td><tr>
<tr><td> 24 </td><td> tBodyGyro-std()-X </td><td> t.body.gyro.std.x </td><tr>
<tr><td> 25 </td><td> tBodyGyro-std()-Y </td><td> t.body.gyro.std.y </td><tr>
<tr><td> 26 </td><td> tBodyGyro-std()-Z </td><td> t.body.gyro.std.z </td><tr>
<tr><td> 27 </td><td> tBodyGyroJerk-mean()-X </td><td> t.body.gyro.jerk.mean.x </td><tr>
<tr><td> 28 </td><td> tBodyGyroJerk-mean()-Y </td><td> t.body.gyro.jerk.mean.y </td><tr>
<tr><td> 29 </td><td> tBodyGyroJerk-mean()-Z </td><td> t.body.gyro.jerk.mean.z </td><tr>
<tr><td> 30 </td><td> tBodyGyroJerk-std()-X </td><td> t.body.gyro.jerk.std.x </td><tr>
<tr><td> 31 </td><td> tBodyGyroJerk-std()-Y </td><td> t.body.gyro.jerk.std.y </td><tr>
<tr><td> 32 </td><td> tBodyGyroJerk-std()-Z </td><td> t.body.gyro.jerk.std.z </td><tr>
<tr><td> 33 </td><td> tBodyAccMag-mean() </td><td> t.body.acc.mag.mean </td><tr>
<tr><td> 34 </td><td> tBodyAccMag-std() </td><td> t.body.acc.mag.std </td><tr>
<tr><td> 35 </td><td> tGravityAccMag-mean() </td><td> t.gravity.acc.mag.mean </td><tr>
<tr><td> 36 </td><td> tGravityAccMag-std() </td><td> t.gravity.acc.mag.std </td><tr>
<tr><td> 37 </td><td> tBodyAccJerkMag-mean() </td><td> t.body.acc.jerk.mag.mean </td><tr>
<tr><td> 38 </td><td> tBodyAccJerkMag-std() </td><td> t.body.acc.jerk.mag.std </td><tr>
<tr><td> 39 </td><td> tBodyGyroMag-mean() </td><td> t.body.gyro.mag.mean </td><tr>
<tr><td> 40 </td><td> tBodyGyroMag-std() </td><td> t.body.gyro.mag.std </td><tr>
<tr><td> 41 </td><td> tBodyGyroJerkMag-mean() </td><td> t.body.gyro.jerk.mag.mean </td><tr>
<tr><td> 42 </td><td> tBodyGyroJerkMag-std() </td><td> t.body.gyro.jerk.mag.std </td><tr>
<tr><td> 43 </td><td> fBodyAcc-mean()-X </td><td> f.body.acc.mean.x </td><tr>
<tr><td> 44 </td><td> fBodyAcc-mean()-Y </td><td> f.body.acc.mean.y </td><tr>
<tr><td> 45 </td><td> fBodyAcc-mean()-Z </td><td> f.body.acc.mean.z </td><tr>
<tr><td> 46 </td><td> fBodyAcc-std()-X </td><td> f.body.acc.std.x </td><tr>
<tr><td> 47 </td><td> fBodyAcc-std()-Y </td><td> f.body.acc.std.y </td><tr>
<tr><td> 48 </td><td> fBodyAcc-std()-Z </td><td> f.body.acc.std.z </td><tr>
<tr><td> 49 </td><td> fBodyAcc-meanFreq()-X </td><td> f.body.acc.mean.freq.x </td><tr>
<tr><td> 50 </td><td> fBodyAcc-meanFreq()-Y </td><td> f.body.acc.mean.freq.y </td><tr>
<tr><td> 51 </td><td> fBodyAcc-meanFreq()-Z </td><td> f.body.acc.mean.freq.z </td><tr>
<tr><td> 52 </td><td> fBodyAccJerk-mean()-X </td><td> f.body.acc.jerk.mean.x </td><tr>
<tr><td> 53 </td><td> fBodyAccJerk-mean()-Y </td><td> f.body.acc.jerk.mean.y </td><tr>
<tr><td> 54 </td><td> fBodyAccJerk-mean()-Z </td><td> f.body.acc.jerk.mean.z </td><tr>
<tr><td> 55 </td><td> fBodyAccJerk-std()-X </td><td> f.body.acc.jerk.std.x </td><tr>
<tr><td> 56 </td><td> fBodyAccJerk-std()-Y </td><td> f.body.acc.jerk.std.y </td><tr>
<tr><td> 57 </td><td> fBodyAccJerk-std()-Z </td><td> f.body.acc.jerk.std.z </td><tr>
<tr><td> 58 </td><td> fBodyAccJerk-meanFreq()-X </td><td> f.body.acc.jerk.mean.freq.x </td><tr>
<tr><td> 59 </td><td> fBodyAccJerk-meanFreq()-Y </td><td> f.body.acc.jerk.mean.freq.y </td><tr>
<tr><td> 60 </td><td> fBodyAccJerk-meanFreq()-Z </td><td> f.body.acc.jerk.mean.freq.z </td><tr>
<tr><td> 61 </td><td> fBodyGyro-mean()-X </td><td> f.body.gyro.mean.x </td><tr>
<tr><td> 62 </td><td> fBodyGyro-mean()-Y </td><td> f.body.gyro.mean.y </td><tr>
<tr><td> 63 </td><td> fBodyGyro-mean()-Z </td><td> f.body.gyro.mean.z </td><tr>
<tr><td> 64 </td><td> fBodyGyro-std()-X </td><td> f.body.gyro.std.x </td><tr>
<tr><td> 65 </td><td> fBodyGyro-std()-Y </td><td> f.body.gyro.std.y </td><tr>
<tr><td> 66 </td><td> fBodyGyro-std()-Z </td><td> f.body.gyro.std.z </td><tr>
<tr><td> 67 </td><td> fBodyGyro-meanFreq()-X </td><td> f.body.gyro.mean.freq.x </td><tr>
<tr><td> 68 </td><td> fBodyGyro-meanFreq()-Y </td><td> f.body.gyro.mean.freq.y </td><tr>
<tr><td> 69 </td><td> fBodyGyro-meanFreq()-Z </td><td> f.body.gyro.mean.freq.z </td><tr>
<tr><td> 70 </td><td> fBodyAccMag-mean() </td><td> f.body.acc.mag.mean </td><tr>
<tr><td> 71 </td><td> fBodyAccMag-std() </td><td> f.body.acc.mag.std </td><tr>
<tr><td> 72 </td><td> fBodyAccMag-meanFreq() </td><td> f.body.acc.mag.mean.freq </td><tr>
<tr><td> 73 </td><td> fBodyBodyAccJerkMag-mean() </td><td> f.body.body.acc.jerk.mag.mean </td><tr>
<tr><td> 74 </td><td> fBodyBodyAccJerkMag-std() </td><td> f.body.body.acc.jerk.mag.std </td><tr>
<tr><td> 75 </td><td> fBodyBodyAccJerkMag-meanFreq() </td><td> f.body.body.acc.jerk.mag.mean.freq </td><tr>
<tr><td> 76 </td><td> fBodyBodyGyroMag-mean() </td><td> f.body.body.gyro.mag.mean </td><tr>
<tr><td> 77 </td><td> fBodyBodyGyroMag-std() </td><td> f.body.body.gyro.mag.std </td><tr>
<tr><td> 78 </td><td> fBodyBodyGyroMag-meanFreq() </td><td> f.body.body.gyro.mag.mean.freq </td><tr>
<tr><td> 79 </td><td> fBodyBodyGyroJerkMag-mean() </td><td> f.body.body.gyro.jerk.mag.mean </td><tr>
<tr><td> 80 </td><td> fBodyBodyGyroJerkMag-std() </td><td> f.body.body.gyro.jerk.mag.std </td><tr>
<tr><td> 81 </td><td> fBodyBodyGyroJerkMag-meanFreq() </td><td> f.body.body.gyro.jerk.mag.mean.freq </td><tr>
<tr><td> 82 </td><td> angle(tBodyAccMean,gravity) </td><td> angle.t.body.acc.mean.gravity </td><tr>
<tr><td> 83 </td><td> angle(tBodyAccJerkMean),gravityMean) </td><td> angle.t.body.acc.jerk.mean.gravity.mean </td><tr>
<tr><td> 84 </td><td> angle(tBodyGyroMean,gravityMean) </td><td> angle.t.body.gyro.mean.gravity.mean </td><tr>
<tr><td> 85 </td><td> angle(tBodyGyroJerkMean,gravityMean) </td><td> angle.t.body.gyro.jerk.mean.gravity.mean </td><tr>
<tr><td> 86 </td><td> angle(X,gravityMean) </td><td> angle.x.gravity.mean </td><tr>
<tr><td> 87 </td><td> angle(Y,gravityMean) </td><td> angle.y.gravity.mean </td><tr>
<tr><td> 88 </td><td> angle(Z,gravityMean) </td><td> angle.z.gravity.mean </td><tr>
</table>
