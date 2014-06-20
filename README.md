Data Cleaning Project
=====================

Intro
-----

This script is for processing the UCI HAR dataset that tracks people's movements using their cellphones.
The original dataset is broken into several different files, which have been combined using this script.
This readme will give an overview of the processes of the script, and you can refer to the included code book
for more details. The script assumes that you already have the dataset root directory as your working
directory.

Loading and Arranging Data
--------------------------

For this assignment, only the features that include the means and standard deviations are required, so first
the features file is read into a table. Using regex, the indicies of the features including mean and standard
deviation data are extracted, and then used to trim down the training and test datasets to only those components.
The subject number and activity number for each entry were read in through their respective files, and added as
columns onto the datasets. Before adding the activities in, however, the numbers were replaced by the descriptive
names provided in the activity_labels.txt file. Once both the training and test data were transformed in this way,
they were combined into one large dataset.

Creating the Tidy Dataset
-------------------------
Now having all of the data in one place, the subject and activity columns were both turned into factor variables
so that they could be more easily iterated over to arrive and the mean for each variable broken down by those
two categories. An empty data frame was initialized, and then added to row by row using nested for loops to select
each subject, and then activity by that subject. The result is a dataset that includes the mean of the means and
standard deviations for each subject's activities. From thirty subjects performing six activities, this makes a set
with one-hundred eighty observations and eighty-one variables including the labels for subject and activity.

Result
------

The result is the tidy_data.txt file included in the repo. It was created using the write.table function in R,
and can easily be loaded back in using read.table. The first line includes the column names, so header option should
be set to true.