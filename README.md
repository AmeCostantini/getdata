##Goals
This document aims to explain how the code run_analysis.R was written and why I made my choices in performing the analysis.

##Overview
The run_analysis.R was created in order to create a tidy dataset according to the requirements of the coursera **Getting and Cleaning Data** course.

##Structure
The script is splitted into 7 chunks. Each one performs a critical step in the analysis devoted to the creation of the new dataset. Now I am going to describe each single step. You can relate them with the ones in the script looking at comments.

###Step 0: setting the working directories and downloading the files
I used the package "downloader" to download and unzip the files related to the analysis


###Step 1: Merges the training and the test sets to create one data set
For both the train and the test dataset I have performed separately the import of the measurements and the one of the activities and subjects whose measurements were taken. I united measurements and activities/subjects with bind_rows (dply package) after a check on the identity of number of rows.


###Step 2: properly naming variables
Activities and subjects (the first two columns) were named in their respective read.table statements (see step 1), while the measurements were properly named in a dedicated statement, after importing the names.


###Step 3: Decoding activities information
Through left join I retrieved the information on the label of the activity code.


###Step 4: Etracting only measurement on mean and standard deviation
This step has been performed in two sub-steps. First of all I removed some variables that were duplicated (same names, different columns - no one of them containing mean or std summaries), and then, thanks to select function in dplyr I selected (in addition to subject and activity) only the variables containing mean() or std(). So I decided to ignore meanFreq, since after reading the features_info.txt it seemed to me that it consisted of a different kind of measurement.



###Step 5: Calculating mean for this variables grouping by activity and subject
Simple summary of all numeric variables grouping by subject and activity (using activity labels). I did it through the summarise_each function in dplyr. After that I added the word AVERAGE to rename properly the variables of the new tidy dataset requested by the assignment. It is in a long format because I feel that long format is closer to the idea of tidy dataset.



###Step 6: write.table
I think no comments are needed here.
