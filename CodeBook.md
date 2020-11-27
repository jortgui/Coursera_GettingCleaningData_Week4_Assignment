---
title: "CodeBook"
author: "Jordi Ortiga"
date: "27/11/2020"
output: html_document
---

## Introduction
This file contains a description of the final tidy data set obtained from the script
**run_analysis.R**. Information about the raw data and all the operations done in the 
script in order to obtain the final data set can be found in the **README.md**.
In this CodeBook, the description of variables is based on the original CodeBook
*features_info.txt* from the raw data.

The final data set can be found in the text file *tidy_data.txt* uploaded in the
assignment. The text file can be loaded into R using *read.csv("tidy_data.txt", sep = "")*
or *read.table("tidy_data.txt", header = TRUE)*

## Description of the data
**tidy_data.txt** has one table with 68 columns and 180 rows, distributed as follows:

**Column 1:**  

* Description: integer to identify each subject.
* Name: subject  
* Class: integer 
* Different values: 30
* Range: 1 to 30  
    
**Column 2:**  
 
* Description: activity that is doing each subject while taking the measurements.
* Name: activity  
* Class: character  
* Different values: 6
* Values: laying, sitting, standing, walking, walking.downstairs, walking.upstairs

**Column 3 to 68:**  

* Description: data in those columns is obtained from the raw data as explained
in **README.md**. Considering all the raw data there are several rows with the
same subject and activity. This table has the mean for all the rows with
the same subject and activity.
* Name: the name for those columns could be one of the following:   
    * t.**MD**.mean + (.x, .y, .z)
    * t.**MD**.std + (.x, .y, .z)
    * f.**MD**.mean + (.x, .y, .z)
    * f.**MD**.std + (.x, .y, .z)  
    (.x, .y, .z) means optional, some names will have .x, .y or .z component, others will not.  
    "t." means "time".  
    "f." means "Fast Fourier Transform".  
    **MD** can be one the following 10 tags:  
        * BodyAcc: Body Acceleration (calculated from acceleration signal).
        * GravAcc: Gravity Acceleration (calculated from acceleration signal).
        * BodyAccJerk: Jerk of BodyAcc.
        * BodyGyro: Body Gyroscope (angular velocity).
        * BodyGyroJerk: Jerk of BodyGyro.
        * BodyAccMag: Magnitude (Euclidean norm) of BodyAcc.
        * GravAccMag: Magnitude (Euclidean norm) of GravAcc.
        * BodyAccJerkMag: Magnitude (Euclidean norm) of BodyAccJerk.
        * BodyGyroMag: Magnitude (Euclidean norm) of BodyGyro.
        * BodyGyroJerkMag: Magnitude (Euclidean norm) of BodyGyroJerk.
        
        Uppercase in tags is allowed to differentiate between the different "components" (e.g.) Body + Acc, Body + Gyro...
* Class: numeric
* Range: -1 to 1

**Full list of column names:**  
Below is the full list of variables (columns) in the tidy data set:

* subject   
* activity   
* t.BodyAcc.mean.x   
* t.BodyAcc.mean.y   
* t.BodyAcc.mean.z   
* t.BodyAcc.std.x   
* t.BodyAcc.std.y   
* t.BodyAcc.std.z   
* t.GravAcc.mean.x   
* t.GravAcc.mean.y   
* t.GravAcc.mean.z   
* t.GravAcc.std.x   
* t.GravAcc.std.y   
* t.GravAcc.std.z   
* t.BodyAccJerk.mean.x   
* t.BodyAccJerk.mean.y   
* t.BodyAccJerk.mean.z   
* t.BodyAccJerk.std.x   
* t.BodyAccJerk.std.y   
* t.BodyAccJerk.std.z   
* t.BodyGyro.mean.x   
* t.BodyGyro.mean.y   
* t.BodyGyro.mean.z   
* t.BodyGyro.std.x   
* t.BodyGyro.std.y   
* t.BodyGyro.std.z   
* t.BodyGyroJerk.mean.x   
* t.BodyGyroJerk.mean.y   
* t.BodyGyroJerk.mean.z   
* t.BodyGyroJerk.std.x   
* t.BodyGyroJerk.std.y   
* t.BodyGyroJerk.std.z   
* t.BodyAccMag.mean   
* t.BodyAccMag.std   
* t.GravAccMag.mean   
* t.GravAccMag.std   
* t.BodyAccJerkMag.mean   
* t.BodyAccJerkMag.std   
* t.BodyGyroMag.mean   
* t.BodyGyroMag.std   
* t.BodyGyroJerkMag.mean   
* t.BodyGyroJerkMag.std   
* f.BodyAcc.mean.x   
* f.BodyAcc.mean.y   
* f.BodyAcc.mean.z   
* f.BodyAcc.std.x   
* f.BodyAcc.std.y   
* f.BodyAcc.std.z   
* f.BodyAccJerk.mean.x   
* f.BodyAccJerk.mean.y   
* f.BodyAccJerk.mean.z   
* f.BodyAccJerk.std.x   
* f.BodyAccJerk.std.y   
* f.BodyAccJerk.std.z   
* f.BodyGyro.mean.x   
* f.BodyGyro.mean.y   
* f.BodyGyro.mean.z   
* f.BodyGyro.std.x   
* f.BodyGyro.std.y   
* f.BodyGyro.std.z   
* f.BodyAccMag.mean   
* f.BodyAccMag.std   
* f.BodyAccJerkMag.mean   
* f.BodyAccJerkMag.std   
* f.BodyGyroMag.mean   
* f.BodyGyroMag.std   
* f.BodyGyroJerkMag.mean   
* f.BodyGyroJerkMag.std