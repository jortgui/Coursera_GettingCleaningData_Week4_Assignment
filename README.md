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

This repository has the following files:

* <span style="color: blue;">run_analysis.R</span> is the R script that generates the tidy data set from the raw data.
* README.md with an introduction and an explanation step by step of what <span style="color: blue;">run_analysis.R</span> does.
* CodeBook.md with an explanation of the final variables in the tidy data set.

## Scripts
This project has only one script called <span style="color: blue;">run_analysis.R</span>. This script does all the operations to
convert the raw data to tidy data.

## Raw Data

Raw data is obtained from *getdata_projectfile_UCI HAR Dataset.zip*. This file should be unzipped 
inside a *data* folder in the working directory. A total of 8 raw data files are loaded into R 
and stored with names starting with <span style="color: blue;">r.</span> meaning raw data.

* */data/UCI HAR Dataset/activity_labels.txt* stored as <span style="color: blue;">r.activity</span> 
* */data/UCI HAR Dataset/features.txt* stored as <span style="color: blue;">r.features</span>   
* */data/UCI HAR Dataset/train/X_train.txt* stored as <span style="color: blue;">r.train</span> 
* */data/UCI HAR Dataset/train/y_train.txt* stored as <span style="color: blue;">r.train.activity</span>  
* */data/UCI HAR Dataset/train/subject_train.txt* stored as <span style="color: blue;">r.train.subject</span>  
* */data/UCI HAR Dataset/test/X_test.txt* stored as <span style="color: blue;">r.test</span>  
* */data/UCI HAR Dataset/test/y_test.txt* stored as <span style="color: blue;">r.test.activity</span>  
* */data/UCI HAR Dataset/test/subject_test.txt* stored as <span style="color: blue;">r.test.subject</span>   

## Data Cleaning
<span style="color: blue;">run_analysis.R</span> loads all the previous files as <span style="color: blue;">data.frame</span>
and performs several operations to obtain one tidy table. The operations are described in the same order they are coded
in <span style="color: blue;">run_analysis.R</span>. The order for the two first steps is different with respect
the course assignment.

#### 1. Get Only mean() and std()
From <span style="color: blue;">r.train</span> and <span style="color: blue;">r.test</span> get only those columns with
mean and standard deviations values. In this script the selected columns are those in which the column name contains
**-mean()** or **-std()**. The column names are obtained from <span style="color: blue;">r.features</span>, and the
selected column index with **-mean()** or **-std()** are stored in <span style="color: blue;">i.feat</span>. A total
of 66 columns with **-mean()** or **-std()** are selected. After this step <span style="color: blue;">r.train</span>
and <span style="color: blue;">r.test</span> will contain only those 66 columns. For both <span style="color: blue;">r.train</span>
and <span style="color: blue;">r.test</span> those 66 column names are renamed using the correspoding name from
<span style="color: blue;">r.features</span>.

#### 2. Join all Data
All data is joined into a single data frame named <span style="color: blue;">r.all</span> as follows:

* Column bind of: <span style="color: blue;">r.train.subject</span>,
                  <span style="color: blue;">r.train.activity</span>,
                  <span style="color: blue;">r.train</span> in this order and stored in
                  <span style="color: blue;">r.train</span>
* Column bind of: <span style="color: blue;">r.test.subject</span>,
                  <span style="color: blue;">r.test.activity</span>,
                  <span style="color: blue;">r.test</span> in this order and stored in
                  <span style="color: blue;">r.test</span>                  
* Row bind of: <span style="color: blue;">r.train</span>,
               <span style="color: blue;">r.test</span> in this order and stored in
               <span style="color: blue;">r.all</span>

The resulting table <span style="color: blue;">r.all</span> has 68 columns and 10299 rows. 

#### 3. Use descriptive activity names
The 2nd column in <span style="color: blue;">r.all</span> has the activities from <span style="color: blue;">r.train.activity</span>
and <span style="color: blue;">r.test.activity</span> encoded as integers from 1 to 6. <span style="color: blue;">r.activity</span>
has the corresponding activity labels to each integer. Each integer activity value in
<span style="color: blue;">r.all</span> is replaced by the corresponding label but formatted as following:

* Replace "_" by "."
* To lowercase

Examples of the resulting activity labels in <span style="color: blue;">r.all</span>: walking, walking.upstairs...

#### 4. Set descriptive variable names
In this step all variables (colum names) in <span style="color: blue;">r.all</span> are formatted to descriptive names.
First two columns are renamed as:

* subject (first column)
* activity (second column)

The name for the rest of the columns (3 to 68) comes from step 1 (Get Only mean and std). Those columns are formatted as follows:

* Remove "(" and ")"
* Replace initial lowercase t by <span style="color: blue;">time.</span>
* Replace initial lowercase f by <span style="color: blue;">freq.</span> (frequency)
* Replace "-" by "."
* Replace final uppercase ".X" to lowercase ".x"
* Replace final uppercase ".Y" to lowercase ".y"
* Replace final uppercase ".Z" to lowercase ".z"

As a result, columns 3 to 68 will have the following name format:

* time.**MD**.mean
* freq.**MD**.mean
* time.**MD**.std
* freq.**MD**.std
* ... additionally, any of the previous could end with ".x", ".y" or ".z"

**MD** is the main magnitude descriptor. It is composed of different
components the script allow uppercase to differentiate between the
several components. e.g.

* **MD** = "BodyAcc" (Body + Acc)
* **MD** = "BodyAccJerk" (Body + Acc + Jerk)

#### 5. Create an independent tidy data set
<span style="color: blue;">r.all</span> has several rows for the same subject and activity. This step
creates a new indpendent table stored in <span style="color: blue;">t.all</span> with mean values for
those rows with the same subject and activity. To do that the script used
<span style="color: green;">group_by</span> from <span style="color: green;">dplyr</span> to gropy by
subject and activity, the output is piped to <span style="color: green;">summarize_all</span> to obtain
the mean of all values grouped by subject and activity. <span style="color: blue;">t.all</span>
has 68 columns and 180 rows.
