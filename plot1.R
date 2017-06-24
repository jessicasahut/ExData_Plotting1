##---------------------------------------------------------------------------------------------------
## code to produce plot1 - HISTOGRAM
##---------------------------------------------------------------------------------------------------

## HOUSEKEEPING: FILE LOCATIONS, PACKAGES ETC------------------------------------------

library(lubridate);library(dplyr)

coursera <- "C:/Users/sahutj/Box Sync/Resources/R/Coursera"
course<-"4.ExploratoryDataAnalysis"
folder<- "Week1 - base plotting system"
sub<-"ExData_Plotting1"
f<-file.path(coursera,course,folder,sub)
setwd(f)
getwd()


## DOWNLOAD AND UNZIP DATA, INTO DATA FRAME------------------------------------------

fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("household_power_consumption.txt")) {
  download.file(fileURL, destfile = "data.zip")
  unzip("data.zip")
  downloadDate<-Sys.Date()
  }

if (!exists("rawpower")) {
  rawpower<-read.table("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE) 
}


## FEW TRANSFORMATIONS TO GET DATA INTO SHAPE------------------------------------------

View(rawpower)
head(rawpower)
summary(rawpower)

df<-rawpower %>%
    mutate(Date=dmy(Date)) %>% #converting date to Date format
    subset(Date >=ymd("2007-02-01") & Date<= ymd("2007-02-02")) #only keeping dates in given window

## HISTOGRAM------------------------------------------


#initialize plot
hist(df$Global_active_power
     , col="red"
     , breaks=15
     , main="Global Active Power"
     , xlab="Global Active Power (kilowatts)"
     , xaxt='n'
     )
#annotate
axis(side=1, at=seq(0,6,2), labels=seq(0,6,2))

#copy plot to png format and turn png device off
dev.copy(png,file="plot1.png", width=480, height=480) 
dev.off()


