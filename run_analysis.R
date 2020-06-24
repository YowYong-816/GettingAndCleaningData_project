## reading in datasets for test group
test_y<-read.table("./UCI HAR Dataset/test/y_test.txt")
test_x<-read.table("./UCI HAR Dataset/test/X_test.txt")
test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt")

## reading in datasets for train group
train_y<-read.table("./UCI HAR Dataset/train/y_train.txt")
train_x<-read.table("./UCI HAR Dataset/train/X_train.txt")
train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt")

## merging datasets for train and test groups
train<-cbind(train_subject,train_y,train_x)
test<-cbind(test_subject,test_y,test_x)

## merging train and test groups data into one dataset 
data<-rbind(train,test)

## renaming the variables with descriptive names
features<-read.table("./UCI HAR Dataset/features.txt")
names(data)=c("subject","activity",features[[2]])

## extracting meansurement on the mean and std for each measurement
data_extracted<-select(data,subject,activity,contains(c("mean","std")))

## renaming activity with descriptive activity names
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
data_extracted$activity=as.factor(data_extracted$activity)
levels(data_extracted$activity) = activity_labels[[2]]

## summarising dataset
data_average<-data_extracted%>%
                group_by(subject,activity,)%>%
                summarise_all(mean,na.rm=TRUE)



