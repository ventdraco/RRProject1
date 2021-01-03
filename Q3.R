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

##Calculating missing data
sum(is.na(xdata$steps))

##Calculating the media for the data
meanasbd <- mean(asbd$steps)

pdata <- transform(xdata, steps = ifelse(is.na(xdata$steps), yes = meanasbd, no = xdata$steps))

atsbd <- aggregate(steps~date, pdata, sum)
##Histogram
hist(atsbd$steps, xlab="Steps per day", ylab="Number of Days", main="Steps taken each day")

meanatsbd <- mean(atsbd$steps)
        
medianatsbd <- median(atsbd$steps)

dev.copy(png,file = 'hist2.png',width = 480, height = 480)
dev.off()
