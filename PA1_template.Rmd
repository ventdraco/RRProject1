---
title: "PA1"
author: "Luis"
date: "1/3/2021"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Activity monitoring DATA

# Loading and preprocessing the data

```{r readdata}
library(dplyr)
filename <- "Dataset.zip"
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
        download.file(fileURL, filename, method="curl")
} 
if (!file.exists("Factivity")) { 
        unzip(filename) 
}

## SHOW THE LIST OF FILES IN YOUR PATH list.files("./", recursive=TRUE)
xdata <- read.csv("activity.csv", sep = "," ,header = TRUE)
```

## What is mean total number of steps taken per day?

Calculate the total number of steps taken per day

```{r stepday}
tsbd<-aggregate(steps~date, xdata, sum)
```

 Make a histogram of the total number of steps taken each day

```{r hist1, echo = FALSE}
hist(tsbd$steps, xlab="Steps per day", ylab="Number of Days", main="Steps taken each day")
```


Calculate and report the mean and median of the total number of steps taken per day

```{r meansteps, echo=FALSE} 
##Mean
mean(tsbd$steps)
```

```{r meadsteps, echo=FALSE} 
##Median
median(tsbd$steps)
```

## What is the average daily activity pattern?

Make a time series plot (i.e. \color{red}{\verb|type = "l"|}type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days

```{r mmsteps, echo=FALSE} 
asbd<-aggregate(steps~interval, xdata, mean, na.rm = FALSE)
with(asbd, plot(interval, steps, col = "red", type = "l"))
```

Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
```{r mmstepsI, echo=FALSE} 
asbd[which.max(asbd$steps), ]$interval
```
## Imputing missing values

Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)

``` {r missingsteps}

sum(is.na(xdata$steps))
```

Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

``` {r replacenas}
##Calculating the media for the data
meanasbd <- mean(asbd$steps)

##Replacing values
pdata <- transform(xdata, steps = ifelse(is.na(xdata$steps), yes = meanasbd, no = xdata$steps))
```


Create a new dataset that is equal to the original dataset but with the missing data filled in.

``` {r newdata}
atsbd <- aggregate(steps~date, pdata, sum)
```

Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

``` {r hist2, echo=FALSE}
hist(atsbd$steps, xlab="Steps per day", ylab="Number of Days", main="Impact of Imputed data Steps taken each day", col = "red")
hist(tsbd$steps, xlab="Steps per day", ylab="Number of Days", main="Steps taken each day", col = "blue", add = TRUE)
```

Mean
``` {r newmean, echo = FALSE}
mean(atsbd$steps)
```
Median
``` {r newmedian, echo = FALSE}
median(atsbd$steps)
```

## Are there differences in activity patterns between weekdays and weekends?

Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.

``` {r newfactor}
pdata$date<-as.Date(pdata$date)

ydata<-pdata%>%
        mutate(week = ifelse(weekdays(date)=="Saturday" | weekdays(date)=="Sunday", "Weekend", "Weekday")) %>%
                group_by(week, interval) %>%
                        summarize(tasteps=sum(steps))
```

Make a panel plot containing a time series plot  of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.

``` {r plot2, echo=FALSE}
edata <- subset(ydata, week == "Weekend")
ddata <- subset(ydata, week == "Weekday")

par(mfrow=c(1,2))
with(edata, plot(interval, tasteps, type = "l", main = "weekend"))
with(ddata, plot(interval, tasteps, type = "l", main = "weekday"))
```