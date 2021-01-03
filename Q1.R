library(dplyr)
filename <- "Dataset.zip"
##checking if the file already exists, if it doesn't it will download it
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
        download.file(fileURL, filename, method="curl")
} 
##unzip the file, if it doesn't exists on the path.
if (!file.exists("Factivity")) { 
        unzip(filename) 
}
##checking files
list.files("./", recursive=TRUE)

##Read data
xdata <- read.csv("activity.csv", sep = "," ,header = TRUE)

##Reading steps by day.
tsbd<-aggregate(steps~date, xdata, sum)

##Histogram
hist(atsbd$steps, xlab="Steps per day", ylab="Number of Days", main="Steps taken each day")
##Mean
meantsbd <- mean(tsbd$steps)

##Median
mediantsbd <- median(tsbd$steps)


dev.copy(png,file = 'hist1.png',width = 480, height = 480)
dev.off()