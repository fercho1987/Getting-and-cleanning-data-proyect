###1####
##download files####
if(!file.exists("./data")){dir.create("./data")}
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="./data/dataset2.zip")
unzip("data/dataset2.zip")

##read files####

testfiles <- list.files("UCI HAR Dataset/test",full.names=T) 
datatest <- data.frame (nrows=2947)
for (i in 2:4) {
        datatest <- cbind(datatest, read.table(testfiles[i]))
}



trainfiles <- list.files("UCI HAR Dataset/train",full.names=T) 
datatrain <- data.frame (nrows=7352)
for (i in 2:4) {
        datatrain <- cbind(datatrain, read.table(trainfiles[i]))
}

## merge data####
completedata<-rbind(datatest,datatrain)

###2####
#Extract mean and standard deviation####
meanstd<-read.table("UCI HAR Dataset/featuresmeanstd.txt")
vectvar<-meanstd[,1]+2

subdata<-completedata[,c(2,vectvar,564)]

###3####
#name activities####


for(i in 1:10299){
        if(subdata[i,"V1.2"]=="1"){
                subdata[i,"V1.2"]<-"Walking"
        }else if(subdata[i,"V1.2"]=="2"){
                subdata[i,"V1.2"]<-"Walking_Upstairs"
        }else if(subdata[i,"V1.2"]=="3"){
                subdata[i,"V1.2"]<-"Walking_Downstairs"
        }else if(subdata[i,"V1.2"]=="4"){
                subdata[i,"V1.2"]<-"Sitting"
        }else if(subdata[i,"V1.2"]=="5"){
                subdata[i,"V1.2"]<-"Standing"
        }else {
                subdata[i,"V1.2"]<-"Laying"
        }
}

subdata$V1.2<-as.factor(subdata$V1.2)

#4####
#variables names####

columnames<-c("subject",as.vector(meanstd[,2]),"names_activities")

colnames(subdata)<-columnames

#5####
# tidy data set with the average of each variable for each activity and each subject####

library(reshape2)
tidydata<-melt(subdata,id.vars=c("subject","names_activities"))
finaldata<-dcast(subject+variable~names_activities,data=tidydata,fun=mean)

write.table(finaldata,file="finaldataset.txt",row.name=FALSE)

