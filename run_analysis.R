#
#test/y_test.txt contains the activity code 
#associated with each value in test/x_test.txt
#
#features.txt contains column names for x_test.txt
#

RunAnalysis <- function() {
    LoadDictionary()
    data.merged <- LoadMergedData()
    extract.meansd <- ExtractMeanStd(data.merged)
    tidy <- MakeTidyData(data.merged)    
    print(tidy)
    tidy
}

Test.RunAnalysis <- function() {
    tidy <- read.table("tidy.txt", header=TRUE, sep=" ")
    print(tidy)
    tidy
}

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
    for (dd in desc.dups) {
        dd.rows <- features$desc.name == dd
        features$desc.name[dd.rows] <- paste(features$desc.name[dd.rows], c(".x", ".y", ".z"), sep="")
    }
    
    #load activity labels
    activity.labels <- read.table("activity_labels.txt", col.names=c("id", "label"))
    
    #put the features and activities into a list. Put that list in global environmet
    dict <<- list(features=features, activities=activity.labels)
}

LoadMergedData <- function() {
    
    if (is.null(dict)) {
        LoadDictionary()
    }
    
    #print(dict)
    activities <- dict$activities
    features <- dict$features$desc.name
        
    #load test data
    y <- read.table("test/y_test.txt", header=FALSE, col.names=c("activity.id"))
    x <- read.table("test/X_test.txt", header=FALSE, col.names=features)
    subject <- read.table("test/subject_test.txt", header=FALSE, col.names=c("subject"))
    merged.activity <- merge(x=y, y=activities, 
                             by.x="activity.id", by.y="id",
                             all.x=TRUE, all.y=FALSE, sort=FALSE)
    data.test <- cbind(subject=subject, activity=merged.activity$label, x)
    
    #load training data
    y <- read.table("train/y_train.txt", header=FALSE, col.names=c("activity.id"))
    x <- read.table("train/X_train.txt", header=FALSE, col.names=features)
    subject <- read.table("train/subject_train.txt", header=FALSE, col.names=c("subject"))
    merged.activity <- merge(x=y, y=activities, 
                             by.x="activity.id", by.y="id",
                             all.x=TRUE, all.y=FALSE, sort=FALSE)
    data.train <- cbind(subject, activity=merged.activity$label, x)
    
    #combine training and test data
    data.merged <- rbind(data.test, data.train)
}

ExtractMeanStd <- function(data.merged = NULL) {
    
    if (is.null(dict)) {
        LoadDictionary()
    }
    if (is.null(data.merged)) {
        data.merged <- LoadMergedData()
    }
    
    features <- dict$features$desc.name
    extract.cols <- grep("std|mean", features, ignore.case=TRUE)
    
    #First two columns in data.merged are subject and activity, rest are from features
    extract.cols <- c(1:2, extract.cols + 2) 
    extracted <- data.merged[ ,extract.cols]
}

MakeTidyData <- function(data.merged = NULL) {
    
    if (is.null(dict)) {
        LoadDictionary()
    }
    if (is.null(data.merged)) {
        data.merged <- LoadMergedData()
    }
    
    molten <- melt(data.merged, id=c("subject", "activity"))
    tidy.data <- dcast(molten, subject + activity ~ variable, mean)
    write.table(tidy.data, "tidy.txt", sep=" ", row.names=FALSE, quote=FALSE)
    tidy.data
}

