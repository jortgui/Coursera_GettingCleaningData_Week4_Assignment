---
title: "README"
author: "Jordi Ortiga"
date: "26/11/2020"
output: html_document
---

## Introduction
The purpose of the files in this repository is to obtain a tidy data set using as raw data the work of:

*Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity*
*Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International*
*Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012*

More information on: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The tidy data set is constructed following the requirements of the week 4 assignment of the Coursera course
*Getting and Cleaning Data*. I want to acknowledge the valuable information to complete this assignment
found in:

* https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
* Help guide published by Luis A Sandino in the week 4 discussion forum of the course.

This repository has the following files:

* **run_analysis.R** is the R script that generates the tidy data set from the raw data.
* **README.md** with an introduction and an explanation step by step of what **run_analysis.R** does.
* **CodeBook.md** list the variables in the final tidy data set.

## R scripts
This project has only one script called **run_analysis.R**. This script does all the operations to
convert the raw data to tidy data.

## Raw Data

Raw data is obtained from *getdata_projectfile_UCI HAR Dataset.zip*. This file should be unzipped 
inside a *data* folder in the working directory. A total of 8 raw data files are loaded into R 
and stored with names starting with **r.** (meaning raw data).

* */data/UCI HAR Dataset/activity_labels.txt* stored as **r.activity**
* */data/UCI HAR Dataset/features.txt* stored as **r.features**
* */data/UCI HAR Dataset/train/X_train.txt* stored as **r.train**
* */data/UCI HAR Dataset/train/y_train.txt* stored as **r.train.activity**  
* */data/UCI HAR Dataset/train/subject_train.txt* stored as **r.train.subject**
* */data/UCI HAR Dataset/test/X_test.txt* stored as **r.test**
* */data/UCI HAR Dataset/test/y_test.txt* stored as **r.test.activity**
* */data/UCI HAR Dataset/test/subject_test.txt* stored as **r.test.subject**

## Data Cleaning
**run_analysis.R** loads all the previous files as data.frame and performs several operations to obtain one
tidy table. The specifications in the course assignment to clean the data are the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
for each activity and each subject.

The following sections explains each of the steps implemented in **run_analysis.R**.
The order of the steps in the script is the same,
except for the two first steps, because I considered it would be better to extract first the mean and std columns
before to join all the tables.

#### 1. Get Only mean() and std()
From **r.train** and **r.test** get only the measurements with
mean and standard deviations values. In this script the selected measurements are those in which the name contains
**-mean()** or **-std()**. The names are obtained from **r.features**, and the
vector with the index with **-mean()** or **-std()** is stored in **i.feat**. A total
of 66 measurements with **-mean()** or **-std()** are selected. After this step **r.train**
and **r.test** will contain only those 66 measurements. Column names for both tables are renamed using the correspoding
names of the measurements.

#### 2. Join all Data
All data is joined into a single data frame named **r.all** as follows:

* Column bind of: **r.train.subject**, **r.train.activity**, **r.train** in this order and stored in **r.train**
* Column bind of: **r.test.subject**, **r.test.activity**, **r.test** in this order and stored in **r.test** 
* Row bind of: **r.train**, **r.test** in this order and stored in **r.all**

The resulting table **r.all** has 68 columns and 10299 rows. 

#### 3. Use descriptive activity names
The 2nd column in **r.all** has the activities encoded as integers from 1 to 6. **r.activity**
has the corresponding activity labels to each integer. Each integer activity value in
**r.all** is replaced by the corresponding label but formatted as follows:

* Replace "_" by "."
* To lowercase

Examples of the resulting activity labels in **r.all**: walking, walking.upstairs, laying...

#### 4. Set descriptive variable names
In this step all variables (colum names) in **r.all** are formatted to descriptive names.
First two columns are renamed as:

* subject (first column)
* activity (second column)

The name for the rest of the columns (3 to 68) comes from step 1 (Get Only mean and std). Those columns are formatted as follows:

* Remove "(" and ")"
* Replace initial lowercase "t" by "t." (time)
* Replace initial lowercase "f" by "f." (Fast Fourier Transform)
* Replace "-" by "."
* Replace final uppercase ".X" to lowercase ".x"
* Replace final uppercase ".Y" to lowercase ".y"
* Replace final uppercase ".Z" to lowercase ".z"
* Replace ".BodyBody" by ".Body"
* Replace ".Gravity" by ".Grav"

As a result, columns 3 to 68 will have the following name format:

* t.**MD**.mean + (.x, .y, .z)
* f.**MD**.mean + (.x, .y, .z)
* t.**MD**.std + (.x, .y, .z)
* f.**MD**.std + (.x, .y, .z)

(.x, .y, .z) is optional, some columns will have component .x, .y or .z, others will not.
**MD** is the measurement descriptor. It is composed of different
components and the script allow uppercase to differentiate between the
several components. e.g.

* **MD** = "BodyAcc" (Body + Acc)
* **MD** = "BodyAccJerk" (Body + Acc + Jerk)

Acc, Gyro, Mag... are not replaced by the complete word to avoid too long names,
in order to apply the same rule, ".Gravity" is replaced by ".Grav". "Body" is 
not replaced because is already short.

#### 5. Create an independent tidy data set
**r.all** has several rows for the same subject and activity. This step
creates a new indpendent table stored in **t.all** with mean values for
those rows with the same subject and activity. The script uses
**group_by** from **dplyr** to gropy by subject and activity, the output is piped
to **summarize_all** to obtain the mean of all values grouped by subject and activity.
**t.all** is the final tidy data set, has 68 columns and 180 rows.

#### 6. Write output
The scripts writes the final tidy data set **t.all** in the working directory 
as a text file following the specifications of the assignment (using **write.table** with
*row.name = FALSE*). The ouput file is *tidy_data.txt* and has the columns separated by space.

The text file can be loaded into R using *read.csv("tidy_data.txt", sep = "")* or *read.table("tidy_data.txt", header = TRUE)*
