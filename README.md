Coursera: Getting and Cleaning Data Course Project

# README

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

## Files

### Source Code

This project requires the creation of a single R script file, `run_analysis.R`, that does the following:

1. Merges the training and the test sets to create one data set;
2. Extracts only the measurements on the mean and standard deviation for each measurement;
3. Uses descriptive activity names to name the activities in the data set;
4. Appropriately labels the data set with descriptive variable names;
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This script has 2 package dependencies, both of which are automatically installed by `run_analysis.R` if they have not been previously installed:

* [`data.table`](https://github.com/Rdatatable/data.table/wiki): Fast aggregation of large data (e.g. 100GB in RAM), fast ordered joins, fast add/modify/delete of columns by group using no copies at all, list columns and a fast file reader (`fread`). Offers a natural and flexible syntax, for faster development.
* [`reshape2`](https://github.com/hadley/reshape): Flexibly restructure and aggregate data using just two functions: `melt` and `dcast` (or `acast`).

### Source Data

All source data used in this project can be found at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Key files from this source are:

* `activity_labels.txt`: Links the class labels with their activity name.
* `features.txt`: List of all features.
* `test/subject_test.txt`: Each row identifies the test subject who performed the activity for each window sample. Its range is from 1 to 30.
* `train/subject_train.txt`: Each row identifies the training subject who performed the activity for each window sample. Its range is from 1 to 30.
* `test/X_test.txt`: Test set.
* `train/X_train.txt`: Training set.
* `test/y_test.txt`: Test labels.
* `train/y_train.txt`: Training labels.

A full description of this data is available at the site where it was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.)

### Target Data

The output of `run_analysis.R` is a single data set: `tidied.txt`. In addition to conforming to the tidy data set described in step 5 of **Source Code**, other requirements for this file are as follows:

* Save data set as a TXT file created with `write.table()` using `row.name=FALSE`;
* Do not cut and paste the data set directly into the text box for submitting the course project deliverables; upload it as instructed from the [submission page](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project/submit).

### Documentation

Two documentation files are required to be included in the GitHub repository for this project:

* `CodeBook.md`: A code book that describes the variables and statistical summaries calculated (along with units of measurement) in addition to transformations performed to clean up the data.
* `README.md`: This file, the intention of which is to clearly and understandably explain how all of the scripts work and how they are connected with the other analysis files cited here.

In addition, I have taken the liberty to create another documentation file:

* `Course Project Details.md`: A reference file describing the goal and requirements of this project for grading purposes.

## Protocol

The steps below list operations executed by the analyst to create the tidy data set (`tidied.txt`).

1. Create a folder tree for this project that includes 2 subfolders named as follows:
 * `code`: To contain any R source code files;
 * `data`: To contain any source/target data files.
2. Download the source data ([`UCI HAR Dataset.zip`](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)) and copy it into `data`.  Preserve inside `data` the folder tree structure found within the download.
3. Create within `code` an R script named `run_analysis.R` per the requirements described in **Source Code**.
4. Set the working directory (`<PROJECTROOT>`) of the R session to the project folder.
 * *Example:* `setwd(<PROJECTROOT>)`.
5. Run the R script.
 * *Example:* `source(file.path("code", "run_analysis.R"))`
6. Validate the existence of `tidied.txt` inside `data`.
