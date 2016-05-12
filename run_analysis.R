################################################################################
# FILE:   run_analysis.R
# AUTHOR: Robert L. Jones (RLJ)
#
# ABSTRACT:
# The purpose of this project is to demonstrate the ability to collect, work
# with, and clean a data set. The goal is to prepare tidy data that can be used
# for later analysis. The requirements are to submit:
# 1. A tidy data set as described below;
# 2. A link to a Github repository with your script for performing the analysis;
# 3. A code book that describes the variables, the data, and any transformations
#    or work that you performed to clean up the data called CodeBook.md;
# 4. A README.md in the repo with the scripts explaining how all of the scripts
#    work and how they are connected.
#
# ARG(S): N/A
#
# RETURNS: tidied.csv (output file)
#
# INSPIRATION(S): N/A
#
# NOTE:
# To load this file, run the following:
# > setwd(<PROJECTROOT>)
# > source(file.path(<CODEDIR>, "run_analysis.R"))
#
# EXAMPLE: N/A
#
# DATE:      AUTHOR:  COMMENT:
# 11MAY2016  RLJ      Initial creation.
################################################################################

################################################################################
# 0. Validate that 3rd-party packages are installed.
################################################################################

# INSPIRATION(S):
# 1. A shortcut function for install.packages() and library()
#    http://www.r-bloggers.com/a-shortcut-function-for-install-packages-and-library/
# 2. library() vs require() in R
#    http://yihui.name/en/2014/07/library-vs-require/
validatePackage <- function(package, repos="http://cran.r-project.org", ...) {
  package <- deparse(substitute(package))
  if (!require(package, character.only=TRUE)) {
    install.packages(pkgs=package, repos=repos, ...)
  }
  library(package, character.only=TRUE)
}

validatePackage(data.table)
validatePackage(reshape2)

################################################################################
# 1. Merge the training and the test sets to create one data set.
################################################################################

print("Begin STEP 1.")

# Download data

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip <- file.path("data", "dataset.zip")

##if(!file.exists(zip)) {
##  download.file(url, zip, method = "curl")
##}

##if(!file.exists(dir)) {
##  unzip(zip, exdir = ".")
##}
  
# Read source data.

readData <- function(dataFile) {
  path <- file.path("data", dataFile)
  if (file.exists(path)) {
    read.table(path)
  }
}

readTestData <- function(dataFile) {
  readData(file.path("test", dataFile))
}

readTrainData <- function(dataFile) {
  readData(file.path("train", dataFile))
}

features <- readData("features.txt")[,2]

subject_test <- readTestData("subject_test.txt")
X_test <- readTestData("X_test.txt")
y_test <- readTestData("y_test.txt")

subject_train <- readTrainData("subject_train.txt")
X_train <- readTrainData("X_train.txt")
y_train <- readTrainData("y_train.txt")

# Merge training and test data by rows for each domain (subject, X, and y).

subject <- rbind(subject_test, subject_train)
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)

# Add column names.

names(subject) <- "Subject"
names(X) <- features
names(y) <- "Activity"

# Merge domain data (subject, y, and X) by columns.

merged <- cbind(subject, y, X)

################################################################################
# 2. Extract only the measurements on the mean and standard deviation for each
#    measurement.
################################################################################

print("Begin STEP 2.")

# Identify column names containing "mean()" or "std()".

extracts <- grepl("(mean|std)\\(\\)", features)

# Keep the columns for extraction and the following column exceptions:
# 1. "Subject" (column 1 of "merged")
# 2. "Activity"  (column 2 of "merged")

extracts <- c(T, T, extracts)
extracted <- merged[,extracts]

################################################################################
# 3. Use descriptive activity names to name the activities in the data set.
################################################################################

print("Begin STEP 3.")

# Read categorical data.

activity_labels <- readData("activity_labels.txt")

# Identify factor levels and labels.

lvls <- activity_labels$V1
lbls <- activity_labels$V2

# Create factors.

factors <- factor(extracted$Activity, levels=lvls, labels=lbls)

################################################################################
# 4. Appropriately label the data set with descriptive variable names.
################################################################################

print("Begin STEP 4.")

factored <- extracted
factored[2] <- factors

################################################################################
# 5. From the data set in step 4, create a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
################################################################################

print("Begin STEP 5.")

# Identify categorical (i.e. ID) and measure columns.

colNames <- names(factored)
ids <- colNames[1:2]
measures <- colNames[-(1:2)]

# Reshape data and compute mean (average).

melted <- melt(factored, id=ids, measure.vars=measures)
tidied <- dcast(melted, Subject + Activity ~ variable, mean)

# Write tidy data set to a CSV file.

output <- file.path("data", "tidied.csv")
write.csv(tidied, output, row.names=TRUE)
