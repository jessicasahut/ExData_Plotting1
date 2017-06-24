##---------------------------------------------------------------------------------------------------
## code to produce plot4 - 4 GRAPHS ON ONE PAGE
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

head(rawpower)

df<-rawpower %>%
    mutate(Date=dmy(Date)) %>% #converting date to Date format
    mutate(DateTime=ymd_hms(paste(Date,Time))) %>% #putting together date and time to make datetime
    subset(Date >=ymd("2007-02-01") & Date<= ymd("2007-02-02")) #only keeping dates in given window


## LINE GRAPHs------------------------------------------

png('plot4.png', width=480, height=480)
#note - if you try to copy to png the legend gets cut off.   
#need to write directly to png to make it work.

par(mfrow=c(2,2))


#initialize first plot
plot(df$DateTime,df$Global_active_power
     , ylab="Global Active Power"
     , type="l"
     , xlab=""
      )

#initialize second plot
plot(df$DateTime,df$Voltage
     , ylab="Voltage"
     , type="l"
     , xlab="datetime"
      )

#initialize third plot
plot(df$DateTime,df$Sub_metering_1
     , ylab="Energy sub metering"
     , col="black"
     , type="l"
     , xlab=""
     )
#adding second line to third plot
points(df$DateTime,df$Sub_metering_2
     , ylab="Energy sub metering"
     , col="red"
     , type="l"
     , xlab=""
    )
#adding third line to third plot
points(df$DateTime,df$Sub_metering_3
       , ylab="Energy sub metering"
       , col="blue"
       , type="l"
       , xlab=""
    )
#adding legend to third plot
legend("topright"
       ,lty=1
       ,col=c("black","blue","red")
       ,box.lty = 0
       ,bg="transparent"
       ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 

#initialize fourth plot
plot(df$DateTime,df$Global_reactive_power
     , ylab="Global_reactive_power"
     , type="l"
     , xlab="datetime"
      )

dev.off()



