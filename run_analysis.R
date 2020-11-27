#-- SUMMARY -------------------------------------------------------------------

#IMPORTANT: The zip file must be unzipped inside a "data" folder inside the working
#directory. So inside the working directory should exists:
# /data/UCI HAR Dataset/...
# /data/UCI HAR Dataset/train/...
# /data/UCI HAR Dataset/test/...

#This script load the raw data for two different sets of data (train and test)
#and perform several operations in order to get the following:
#- For the two main tables in train and test, get the columns only with
#  the mean or the standard deviation: -mean() or -std()
#- Join all the data in one single table
#- Add meaning activity values as characters instead of integer values
#- Format column names 
#- Summarize data doing the mean by subject and activity, obtaining the final
#  tidy table, stored in t.all

#Variables in this script, anything starting by... means...
# p... = path (e.g. p.test, p.train)
# r... = raw data (e.g. r.test, r.test.subject, r.test.activity)
# i... = index for columns or rows (e.g. i.feat)
# t... = tidy data (e.g. t.all)


#--- LOAD DATA ----------------------------------------------------------------
library(dplyr)

#zip file is unzip inside data folder of the working directory
#Set path to root, test and train folders (as they exists after unzip data file)
p.root <- file.path("data", "UCI HAR Dataset")
p.test <- file.path("data", "UCI HAR Dataset", "test")
p.train <- file.path("data", "UCI HAR Dataset", "train")

#Read tables from "train" folder
#Raw data tables has the same name that original *.txt files
r.train <- read.table(file.path(p.train, "X_train.txt"),
                      colClasses = "numeric") #file reading 3 times faster if specify column classes
r.train.subject <- read.table(file.path(p.train, "subject_train.txt"))
r.train.activity <- read.table(file.path(p.train, "y_train.txt"))

#Read tables from "test" folder
#Raw data tables has the same name that original *.txt files
r.test <- read.table(file.path(p.test, "X_test.txt"),
                     colClasses = "numeric") #file reading 3 times faster if specify column classes
r.test.subject <- read.table(file.path(p.test, "subject_test.txt"))
r.test.activity <- read.table(file.path(p.test, "y_test.txt"))

#Read features.txt as a table, first column = integer, second column = name of feature
r.features <- read.table(file.path(p.root, "features.txt"),
                         stringsAsFactors = FALSE)

#Read activity labels
r.activity <- read.table(file.path(p.root, "activity_labels.txt"),
                         stringsAsFactors = FALSE)


#-- 1 (STEP2) -----------------------------------------------------------------
#Extracts only the measurements on the mean and standard deviation for each
#measurement

#from r.features, search which rows has "-mean()" or "-std()"
#i.feat = index with the positions with "-mean()" or "-std()"
i.feat <- grep("\\-mean\\(\\)|\\-std\\(\\)", r.features[,2])

#using index i, get from raw data only columns with "-mean()" or "-std()"
r.train <- r.train[,i.feat]
r.test <- r.test[,i.feat]
#set names for the selected columns
colnames(r.train) <- r.features[i.feat,2] #set column names using raw features
colnames(r.test) <- r.features[i.feat,2]  #set column names using raw features


#-- 2 (STEP 1) ----------------------------------------------------------------
#Merges the training and the test sets to create one data set

r.train <- cbind(r.train.subject, r.train.activity, r.train)
r.test <- cbind(r.test.subject, r.test.activity, r.test)
r.all <- rbind(r.train, r.test) #r.all includes train and test sets


#-- 3 (STEP 3) ----------------------------------------------------------------
#Uses descriptive activity names to name the activities in the data set

#format activity labels (stored in r.activity) as:
#- All to lowercase
#- Replace "_" by "."
#... so activities with 2 descriptors will be like "walking.upstairs"
#... so activities with 1 desprcitor will be like "walking"
r.activity <- gsub("_", ".", tolower(r.activity[,2]))

#replace integer activities by the corresponding formated activity label
r.all[,2] <- r.activity[r.all[,2]]


#-- 4 (STEP 4) ----------------------------------------------------------------
#Appropriately labels the data set with descriptive variable names.

#Set names for subject and activity columns
colnames(r.all)[1:2] <- c("subject", "activity")

#For all the other columns (derived from features.txt):
#- Remove ()
#- Replace initial lowercase t by "time."
#- Replace initial lowercase f by "freq." (frequency)
#- Replace "-" by "."
#- Replace ".BodyBody" by ".Body"
#- Replace ".Gravity" by ".Grav"
#
#As a result, columns 3 to 68 will have the following format:
# time.@.mean
# freq.@.mean
# time.@.std
# freq.@.std
# ... additionally, any of the previous could end with ".x", ".y" or ".z"
# @ is the main magnitude descriptor. It is composed of different
# components so I allow the uppercase to differentiate between the
# several components. e.g.
# @ = "BodyAcc" (Body + Acc)
# @ = "BodyAccJerk" (Body + Acc + Jerk)
#
#Acc, Gyro, Mag... are not replaced by the complete word to avoid
#too long names. Even ".Gravity" is replaced with ".Grav" to apply 
#the same rule for all. "Body" not replaced because is already 
#short

#get the names to be formatted (columns 3 to last column)
r.col.names <- colnames(r.all)[3:ncol(r.all)]
r.col.names <- gsub("\\(|\\)","",r.col.names)
r.col.names <- gsub("-",".",r.col.names)
r.col.names <- gsub("^t","time.",r.col.names)
r.col.names <- gsub("^f","freq.",r.col.names)
r.col.names <- gsub(".X$",".x",r.col.names)
r.col.names <- gsub(".Y$",".y",r.col.names)
r.col.names <- gsub(".Z$",".z",r.col.names)
r.col.names <- gsub(".BodyBody",".Body",r.col.names)
r.col.names <- gsub(".Gravity",".Grav",r.col.names)

#set the labels to table
colnames(r.all)[3:ncol(r.all)] <- r.col.names


#-- 5 (STEP 5) ----------------------------------------------------------------
#From the data set in step 4, creates a second, independent tidy data set with
#the average of each variable for each activity and each subject.

t.all <- group_by(r.all, subject, activity) %>% summarize_all(mean)


#-- 6 (Write output) ----------------------------------------------------------
#write output
write.table(t.all, "tidy_data.txt", row.names = FALSE)


