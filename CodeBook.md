---
title: "CodeBook"
author: "Jordi Ortiga"
date: "27/11/2020"
output: html_document
---

## Introduction
This file contains a description of the final tidy data set obtained from the script
**run_analysis.R**. Information about the raw data and all the operations done in the 
script in order to obtain the final data set can be found in the **README.md** file.

The final data set can be found in the text file *tidy_data.txt* uploaded with the
assignment. The text file can be loaded into R using *read.csv("tidy_data.txt", sep = "")*
or *read.table("tidy_data.txt", header = TRUE)*

## Description of the data
**tidy_data.txt** has 68 columns and 180 rows of data, distributed as follows:

| **Column 1:**  
|    Description: integer to identify each subject
|    Name: subject  
|    Class: integer  
|    Different values: 30
|    Range: 1 to 30  
| **Column 2:**  
|    Description: activity that is doing each subject while taking the measurements
|    Name: activity  
|    Class: character  
|    Different values: 6
|    Values: laying, sitting, standing, walking, walking.downstairs, walking.upstairs
| **Column 3 to 68:**
|    Description: data in those columns is obtained from the raw data as explained 
|        in **README.md**. Considering all the raw data there are several measurements 
|        for the same subject and activity. So the data in those columns are the mean
|        values for the same subject and activity.
|    Name: the name for those columns could be one of the following, where () means optional:
|        - time.**MD**.mean + (.x, .y, .z)
|        - time.**MD**.std + (.x, .y, .z)
|        - freq.**MD**.mean + (.x, .y, .z)
|        - freq.**MD**.std + (.x, .y, .z)
|        where freq. means frequency.
|        **MD** can be one the following 10 tags:
|            BodyAcc
|            GravAcc
|            BodyAccJerk
|            BodyGyro
|            BodyGyroJerk
|            BodyAccMag
|            GravityAccMag
|            BodyAccJerkMag
|            BodyGyroMag
|            BodyGyroJerkMag
|        Uppercase in tags is allowed to differentiate between the different "components"
|        (e.g.) Body + Acc, Body + Gyro...
|    Class: numeric
|    Range: -1 to 1