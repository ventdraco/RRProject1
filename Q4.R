library(dplyr)
filename <- "Dataset.zip"
##checking if the file already exists, if it doesn't it will download it
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
        download.file(fileURL, filename, method="curl")
} 
##unzip the file, if it doesn't exists on the path.
if (!file.exists(filename)) { 
        unzip(filename) 
}
##checking files
list.files("./", recursive=TRUE)

##Read data
xdata <- read.csv("activity.csv", sep = "," ,header = TRUE)

##Calculating the media for the data
meanasbd <- mean(asbd$steps)

pdata <- transform(xdata, steps = ifelse(is.na(xdata$steps), yes = meanasbd, no = xdata$steps))

pdata$date<-as.Date(pdata$date)

ydata<-pdata%>%
        mutate(week = ifelse(weekdays(date)=="Saturday" | weekdays(date)=="Sunday", "Weekend", "Weekday")) %>%
                group_by(week, interval) %>%
                        summarize(tasteps=sum(steps))

edata <- subset(ydata, week == "Weekend")
ddata <- subset(ydata, week == "Weekday")

par(mfrow=c(1,2))
with(edata, plot(interval, tasteps, type = "l"))
with(ddata, plot(interval, tasteps, type = "l"))

dev.copy(png,file = 'plot2.png',width = 480, height = 480)
dev.off()
