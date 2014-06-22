#4.Appropriately labels the data set with descriptive variable names. 
if(read==0){
  labels<-read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("index","activity"))
  features<-read.table("./UCI HAR Dataset/features.txt",col.names=c("index","features"))
  trainDS<-read.table("./UCI HAR Dataset/train/X_train.txt",col.names=features[,2])
  testDS<-read.table("./UCI HAR Dataset/test/X_test.txt",col.names=features[,2])
  train_label<-read.table("./UCI HAR Dataset/train/y_train.txt",col.names="activity")
  test_label<-read.table("./UCI HAR Dataset/test/y_test.txt",col.names="activity")
  train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt",col.names="subject")
  test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt",col.names="subject")
  read=1
}

#1. Merge test and train measurements
test<-cbind(test_subject,test_label,testDS)
train<-cbind(train_subject,train_label,trainDS)
alldata<-rbind(test,train)
#2.Extract mean and std measurements
x<-grep("([Mm]ean|std)",features[,2])
data_mean_std<-alldata[,x]
#3.Use descriptive name to activities in the data set
data_mean_std[,2]<-as.factor(data_mean_std[,2])
levels(data_mean_std[,2])<-labels[,2]
#5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data_set<-aggregate(data_mean_std,list(data_mean_std$subject,data_mean_std$activity),mean)
data_set[,(3:4)]<-data_set[,(1:2)]
data_set<-data_set[,-(1:2),drop=FALSE]
write.table(data_set,file="./tidy_data.txt",)
