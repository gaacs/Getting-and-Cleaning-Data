# Introduction

The script `run_analysis.R` performs the 5 steps described in the Getting and Cleaning Data course project's definition.

# Source data

All the process is applied over the UCI HAR Dataset downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Steps

* First, all the data is read into tables.
* Then all the similar data from train and test samples is merged using the `rbind()` function. Meaning by similar those files having the same number of columns and referring to the same entities.
* Then only those columns with the mean and standard deviation measures are taken from the X variables dataset.
* The activities description is assign to the observations.
* Descriptive names are also given to the variables from the features dataset.
* Finally, a new dataset is generated, with the average measures for each subject and activity(30 subjects * 6 activities = 180 rows). The output file is called `tidyData.txt`, and uploaded to this repository.

# Variables

* `activities` and `features` are datasets with descriptions of activities and variables.
* `subjectTrain`, `yTrain`, `xTrain`, `subjectTest`, `yTest` and `xTest` are the table names containing the data from the downloaded data files.  
* `subjectData`, `yData` and `xData` merge the previous datasets to further analysis.
* `allData` merges `yData`, `subjectData` and `xData` in the full dataset.
* Finally, `tidyData` contains the relevant averages which will be later stored in a `.txt` file. The `aggregate()` function with `mean` is used for calculating the requiered averages.
