#Make sure settings are correct
setwd("C://Users/Brenda/Documents/Coursera/UCI HAR Dataset")
library(plyr)
library(dplyr)

#Read data labels
activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels) <- c('activity', 'Activity')
#Read data features. Change () for bb to make replace mean and stb with grep easier. This bb is corrected later on
features <- read.table("features.txt", colClasses = "character")
features <- make.names(as.character(gsub("()", "bb", features[,2], fixed=TRUE)), unique=TRUE)

#Read and combine data test
ytest<-read.table("C://Users/Brenda/Documents/Coursera/UCI HAR Dataset/test/y_test.txt")
xtest<-read.table("C://Users/Brenda/Documents/Coursera/UCI HAR Dataset/test/X_test.txt")
subjecttest<-read.table("C://Users/Brenda/Documents/Coursera/UCI HAR Dataset/test/subject_test.txt")
test<-cbind(subjecttest,ytest,xtest)
#Read and combine data train
ytrain<-read.table("C://Users/Brenda/Documents/Coursera/UCI HAR Dataset/train/y_train.txt")
xtrain<-read.table("C://Users/Brenda/Documents/Coursera/UCI HAR Dataset/train/X_train.txt")
subjecttrain<-read.table("C://Users/Brenda/Documents/Coursera/UCI HAR Dataset/train/subject_train.txt")
train<-cbind(subjecttrain,ytrain,xtrain)
#Combine test and train data
data <-rbind(train,test)
#We are going to use the function merge. This rank will help us to sort the data again. 
data<-cbind(c(1:nrow(data)),data)
#Colnames
colnamesdata<-c('Rank', 'Subject', 'Activity', features)
#Select columnnames with mean and std, and the Rank, Subject and Activity
subset<-sort(c(grep("meanbb", colnamesdata),grep('Meanbb', colnamesdata),grep('stdbb', colnamesdata)))  
data<-data[,c(1:3,subset)]
colnamesdata<-c('Rank', 'Subject', 'Activity',colnamesdata[subset])
#Range the bb that we used to find mean and std for ""
colnamesdata <- gsub("bb", "", colnamesdata, fixed=TRUE)
#Assign final columnnames to data
colnames(data)<-colnamesdata
#Replace activity codes by wording and do a reorder
data <- merge(data,activity_labels, all.x=TRUE)
data <- arrange(data,rank)
data <- cbind(data[,3],data,70],data[,4:69])
#Make more descriptive colnames
colnames(data)[1] <- "Subject"
colnames(data)[2] <- "Activity"
names(data) <- gsub("BodyBody","Body", names(data))
names(data) <- gsub("tBodyAcc","TimeBodyAcceleration", names(data))
names(data) <- gsub("tGravityAcc","TimeGravityAcceleration", names(data))
names(data) <- gsub("tBodyGyro","TimeBodyGyro", names(data))
names(data) <- gsub("fBodyAcc","FrequencyBodyAcceleration", names(data))
names(data) <- gsub("fGravityAcc","FrequencyGravityAcceleration", names(data))
names(data) <- gsub("fBodyGyro","FrequencyBodyGyro", names(data))
#Make and write tiny dataset
Tiny<-data %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
write.table(Tiny, "HumanActivityRecoqnitionTidy.txt", row.name=FALSE)
HumanActivityRecoqnitionTidy<-read.table("HumanActivityRecoqnitionTidy.txt", header=TRUE)
