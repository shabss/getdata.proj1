#Please read the README.md on functional details of this script
#run_analysis.R produces a tidy data set that contains averages of 
#means and standard deviation measurements of *Human Activity 
#Recognition Using Smartphones Dataset Version 1.0* 
#(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
#downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

library(reshape2)


#Main function. This is called at the end of the stipt
#so it will be executed automatically when this script
#is sourced
RunAnalysis <- function() {
    LoadDictionary()
    data.merged <- LoadMergedData()
    extract.meansd <- ExtractMeanStd(data.merged)
    tidy <- MakeTidyData(extract.meansd)    
    #print(tidy)
    tidy
}

#Test function. Produces the tidy data set which the 
#caller can then use to print or compare with expected output
Test.RunAnalysis <- function() {
    tidy <- read.table("tidy.txt", header=TRUE, sep=" ")
    print(tidy)
    tidy
}


#LoadDictionary loads the data in features.txt and activity_labels.txt into
#a 'dict' varible in global environment variable. Callers can use the
#environemnt varible to get values directly
LoadDictionary <- function() {

    #load feature names and convert them into descriptive names
    features <- read.table("features.txt", header=FALSE, col.names=c("id", "raw.name"))
    
    #prepare another columnn with descriptive name. Steps are described below
    #convert '(', ')', '-' and ',' characters to dot '.'. Also convert to lowercase
    features$desc.name <- gsub("[,\\(\\)\\-]", ".", tolower(features$raw.name))
    
    #wrap known words around dots e.g "word" --> ".word."
    features$desc.name <- gsub("(mean|std|body|gyro|acc|jerk|mag|min|max|sma|mean|gravity)", 
                               ".\\1\\.",features$desc.name, ignore.case=TRUE)
    
    #keep only one dot and remove extra dots that are consequtive
    features$desc.name <- gsub("\\.\\.+", ".", 
                               features$desc.name, ignore.case=TRUE)
    
    #digits in "bandEnergy" variales actually represent ranges. Rename them XtoY
    features$desc.name <- gsub("(\\d+)\\.(\\d+)$", "\\1to\\2", 
                               features$desc.name, ignore.case=TRUE)
    
    #remove trailing dot at the end
    features$desc.name <- gsub("(\\.*)\\.$", "\\1", 
                               features$desc.name, ignore.case=TRUE)
        
    #there are few features that are duplicated 3 times. Append .x, .y, z
    desc.dups = unique(features$desc.name[duplicated(features$desc.name)])
    #print(desc.dups)
    for (dd in desc.dups) {
        dd.rows <- features$desc.name == dd
        features$desc.name[dd.rows] <- paste(features$desc.name[dd.rows], c(".x", ".y", ".z"), sep="")
    }
    
    #load activity labels
    activity.labels <- read.table("activity_labels.txt", col.names=c("id", "label"))
    
    #put the features and activities into a list. Put that list in global environmet
    dict <<- list(features=features, activities=activity.labels)
}

#LoadMergedData prepares one data set after combining values from
#subject_test/train.txt, y_test/train.txt and X_test/train.txt. 
#It also converts activity codes to lablels and combines 
#test and train data sets
LoadMergedData <- function() {

    #Load dicionary if it does not exist in global environment
    if (!exists(dict)) {
        LoadDictionary()
    }
    
    #get activity and features from dictionary in global environment
    activities <- dict$activities
    features <- dict$features$desc.name

    #features.txt (loaded in features variable) contains column names for x_test.txt
    #test/y_test.txt contains the activity codes that correspond to labels in activity_lables.txt (loaded in activiites varaible)
    #Each line in test/y_test.txt contains the activity code for the corresponding line in test/x_test.txt
    #Each line in test/subject.txt contains the subject id for the corresponding line in test/x_test.txt
    
    #load test data
    y <- read.table("test/y_test.txt", header=FALSE, col.names=c("activity.id"))
    x <- read.table("test/X_test.txt", header=FALSE, col.names=features)
    subject <- read.table("test/subject_test.txt", header=FALSE, col.names=c("subject"))

    #convert activity codes into activity labels
    merged.activity <- merge(x=y, y=activities, 
                             by.x="activity.id", by.y="id",
                             all.x=TRUE, all.y=FALSE, sort=FALSE)
    
    #merge the dataset -> subject id, activity lable, rest of the columns from X_test.txt
    data.test <- cbind(subject=subject, activity=merged.activity$label, x)
    
    #load training data
    y <- read.table("train/y_train.txt", header=FALSE, col.names=c("activity.id"))
    x <- read.table("train/X_train.txt", header=FALSE, col.names=features)
    subject <- read.table("train/subject_train.txt", header=FALSE, col.names=c("subject"))

    #convert activity codes into activity labels
    merged.activity <- merge(x=y, y=activities, 
                             by.x="activity.id", by.y="id",
                             all.x=TRUE, all.y=FALSE, sort=FALSE)
    #merge the dataset -> subject id, activity lable, rest of the columns from X_test.txt
    data.train <- cbind(subject, activity=merged.activity$label, x)
    
    #combine training and test data
    data.merged <- rbind(data.test, data.train)
}

#ExtractMeanStd returns a data set with only those 
#columns that contain mean or standard deviation measurements
ExtractMeanStd <- function(data.merged = NULL) {

    #Load dicionary if it does not exist in global environment    
    if (!exists(dict)) {
        LoadDictionary()
    }
    
    #if merged data is not passed in then load it
    if (is.null(data.merged)) {
        data.merged <- LoadMergedData()
    }

    #get features from dictionary in global environment    
    features <- dict$features$desc.name
    
    #get column indices for mean and standard deviation measurements
    extract.cols <- grep("std|mean", features, ignore.case=TRUE)
    
    #First two columns in data.merged are subject and activity, rest are from features
    #so explicity add subject and activity and offset others by 2
    extract.cols <- c(1:2, extract.cols + 2) 
    extracted <- data.merged[ ,extract.cols]
}

#MakeTidyData creates a data set that contains the averages of mean and standard
#deviation measurements for all the subject and activity combinations.
#The newly created data set is saved to a file
MakeTidyData <- function(extacted = NULL) {
    
    #Load dicionary if it does not exist in global environment    
    if (!exists(dict)) {
        LoadDictionary()
    }
    
    #if tidy extracted data, data the contains only mean and std columns, 
    #is not passed in then load and extract it
    if (is.null(extacted)) {
        extacted <- ExtractMeanStd()
    }
    
    #met the data on subject and activity columns. All other columns will be
    #"molten" into variable column, which we will dcast to calculate the mean
    molten <- melt(extacted, id=c("subject", "activity"))
    tidy.data <- dcast(molten, subject + activity ~ variable, mean)
    
    #write the data to a file
    write.table(tidy.data, "tidy.txt", sep=" ", row.names=FALSE, quote=FALSE)
    
    #return the data to the caller
    tidy.data
}

RunAnalysis()
