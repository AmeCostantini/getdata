#loading packages
require(dplyr)
#0. setting the working directories and downloading the files

mywd <- "/USers/Americo/Documents/Education/Data_science/Coursera/Getting_and_cleaning_data/wd_ass/dataset"
setwd(mywd)
mywd_UCI <- paste(mywd, "/UCI HAR Dataset", sep = "")
mywd_train <- paste(mywd,"/UCI HAR Dataset/train", sep = "")
mywd_test <- paste(mywd,"/UCI HAR Dataset/test", sep = "")

myurl  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(myurl, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./")

#1. Merges the training and the test sets to create one data set.

#1a: importing test dataset
setwd(mywd_test)
test <- read.table("X_test.txt")
#1b: importing activities for test datasets
test_obs <- read.table("y_test.txt", col.names = "activity_code")
#see if the number of rows is the same
identical(nrow(test), nrow(test_obs))
#yes
#joining the two object
test2 <- bind_cols(test_obs, test)
#importing the subjcet
test_subject <- read.table("subject_test.txt", col.names = "subject")
#see if the number of rows is the same
identical(nrow(test2), nrow(test_subject))
#yes
#joining the two object
test2 <- bind_cols(test_subject, test2)

#1b: importing train dataset
setwd(mywd_train)
train <- read.table("X_train.txt")
#1b: importing activities for test datasets
train_obs <- read.table("y_train.txt", col.names = "activity_code")
#see if the number of rows is the same
identical(nrow(train), nrow(train_obs))
#yes
#joining the two object
train2 <- bind_cols(train_obs, train)
#importing the subjcet
train_subject <- read.table("subject_train.txt", col.names = "subject")
#see if the number of rows is the same
identical(nrow(train2), nrow(train_subject))
#yes
#joining the two object
train2 <- bind_cols(train_subject, train2)


#merging the two datasets. I use bind_rows as I know we don't have any intersection in the two datasets.
adl1 <- bind_rows(train2, test2)

#2. properly naming variables

#2a: importing variables names
setwd(mywd_UCI)
variables  <- read.table("features.txt", stringsAsFactors = FALSE)
#2b: assigning names
colnames(adl1) [3:ncol(adl1)] <- variables$V2

#3. Decoding activities information

#3a: loading the activiy labels dataset
setwd(mywd_UCI)
activity_labels <- read.table("activity_labels.txt", col.names = c("activity_code", "activity_label"))

#3b:  joining in order to decode actitivy
adl2 <- activity_labels %>% 
        left_join(adl1, by ="activity_code")

#4. Etracting only measurement on mean and standard deviation. excluding meanFreq

#4a since some variables are duplicated, first I am going to remove them
dup_check <- duplicated(colnames(adl2))
adl3 <- adl2[,!dup_check]
#extracting variables of interest
adl4  <- adl3 %>%
        select (activity_code, activity_label, subject, contains("mean()"), contains("std()"))

#5 calculating mean for this variables grouping by activity and subject

adl_avg_all <- adl4 %>% 
        group_by(activity_label, subject) %>%
        summarise_each(funs(mean)) %>%
        select(-activity_code)

#5b: renaming properly column
colnames(adl_avg_all)[3:length(colnames(adl_avg_all))] <- paste("AVERAGE", colnames(adl_avg_all)[3:length(colnames(adl_avg_all))])

#6
setwd(mywd)
write.table(x = adl_avg_all, file = "Getdata_project.txt", sep = "\t")
