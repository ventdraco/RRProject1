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

asbd<-aggregate(steps~interval, xdata, mean, na.rm = FALSE)

with(asbd, plot(interval, steps, col = "red", type = "l"))

asbd[which.max(asbd$steps), ]$interval

dev.copy(png,file = 'plot1.png',width = 480, height = 480)
dev.off()
