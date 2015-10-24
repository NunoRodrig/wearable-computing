###############################################################
## Getting and Cleaning Data Course Project Week3
###############################################################


##############################################################
## Part 1: Merge the training and test data sets into one
##############################################################

# Doanload the data set, store it to a working directory

fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileURL, destfile = './DataCleanW3/projectdata.zip')

# unzip the files and re-set Working directory
setwd('./DataCleanW3')
unzip('projectdata.zip')
setwd('./UCI HAR Dataset')


## create data objects from the text files 
## => start with the training files, renaming columns to make sense

x_train <- read.table('./train/X_train.txt')
subject_train <- read.table('./train/subject_train.txt')
names(subject_train)[1] <- 'subject'
label_train <- read.table('./train/y_train.txt')
names(label_train)[1] <- 'activity'


## => now the test files

x_test <- read.table('./test/X_test.txt')
subject_test <- read.table('./test/subject_test.txt')
names(subject_test)[1] <- 'subject'
label_test <- read.table('./test/y_test.txt')
names(label_test)[1] <- 'activity'

# concatenate the train and test files

ttrain <- cbind(subject_train, label_train, x_train)
ttest <- cbind(subject_test, label_test, x_test)

# merge Files Train and test
dat <- rbind(ttrain, ttest)


########################################################################
## Part 2: Extract the mean and standard deviation for each measurement
########################################################################

# create a vector of column means
average_value <- apply(dat[3:563], 2, mean)

#create a vector of column sd
standard_deviation <- apply(dat[3:563], 2, sd) 

# combine them
aggstats <- cbind(average_value, standard_deviation) 

########################################################################
## Part 3: Use descriptive activity names to name the activities in the data set
########################################################################

# make sure of the column name for activities
names(dat[1:2])

dat$activity[which(dat$activity == 1)] <- 'Walking'
dat$activity[which(dat$activity == 2)] <- 'Walking upstairs'
dat$activity[which(dat$activity == 3)] <- 'Walking downstairs'
dat$activity[which(dat$activity == 4)] <- 'Sitting'
dat$activity[which(dat$activity == 5)] <- 'Standing'
dat$activity[which(dat$activity == 6)] <- 'Laying'


########################################################################
## Part 4: Appropriately labels the data set with descriptive names
########################################################################

# create column labels
features <- read.table('features.txt')
features$V1 <- NULL

# Assign each row name from the 'features' data frame to the appropriate column
# in the 'dat' data frame

m <- 1
n <- m + 2

while (m < 562) {
     ren <- features[m,]
     colnames(dat)[n] <- paste(ren)
     m = m + 1
     n = n + 1
}


########################################################################
## Part 5: Create a new tidy data set with the average of each variable 
## for each activity and each subject
########################################################################

# initialize a temporary data frame
sumdata <- aggregate(dat[,3] ~ subject + activity, data = dat, FUN = 'mean')

#calculate the means for each column
for (i in 4:ncol(dat)) {
     sumdata[,i] <- aggregate(dat[,i] ~ subject + activity, data = dat, FUN = 'mean')[,3]
}

# renames the columns to the descriptive name
colnames(sumdata) <- colnames(dat)

# go to the main data directory, and write the new tidy data file
setwd('..')
write.table(sumdata, 'tidydata.txt', row.name=FALSE )
