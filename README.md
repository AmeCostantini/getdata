##Goals
This document aims to explain how the code run_analysis.R was written and why I made my choices in performing the analysis.

##Overview
The run_analysis.R was created in order to create a tidy dataset according to te requirements of the coursera **Getting and Cleaning Data** course.

##Structure
The script is splitted into 7 chunks. Each one perform a critical step in the analysis devoted to the creation of the new dataset. Now I am going to describe each single step. You can relate them with the ones in the script looking at comments.

###Step 0: setting the working directories and downloading the files
I used the package "downloader" to download and unzip the files related to the analysis


###Step 1: Merges the training and the test sets to create one data set
For both the train and the test dataset I have performed the import of the measurements and separately the one of the activities and subjects whose measurements were taken. I united measurements and activities/subjects with bind_rows (dply package) after a check on the equality of number of rows.


###Step 2: properly naming variables
Activities and subjects (the first two columns) were named in their respective read.table statements (see step 1), while the measurements were properly named in a dedicated statement, after importing the names.


###Step 3: Decoding activities information
Through left join I retrieved the information on the label of the activity code.


###Step 4: Etracting only measurement on mean and standard deviation
Thsi step has been performed in two sub-steps. First af all I removed some variables that were duplicated (same names, different columns - no one of them containing mean or std summaries), and then, thanks to select function in dplyr I selected (in addition to subject and activity) only the variables containing mean() or std(). So I decided to ignore meanFreq, as reading the features_info.txt seemed to me the it consisted of a different kind of measurement.



###Step 5: Calculating mean for this variables grouping by activity and subject
Simple summary of all numeric variables grouping by subject and activity (using activity labels). I did trough the summarise_each function in dplyr. After that I added the word AVERAGE to rename properly the variables of the new tidy dataset requested by the assignment. It is in a long format as I feel tha long format is closer to the idea of tidy dataset.



###Step 6: write.table
I think no comments are needed here.
