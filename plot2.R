
plot2 <- function() {
           # reading the file, unzip, and data clean
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile<-"power_consumption.zip"
method<-"libcurl"
data<-download.file(url, destfile, method)
filename<-unzip (destfile)
data <- read.table(filename, header=T,sep=";")

t<-data$Date 
data$Date <-t[!t %in% c("?")]
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
newdata <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]

t<-newdata$Global_active_power
newdata$Global_active_power <-t[!t %in% c("?")]
newdata$Global_active_power <- as.numeric(as.character(newdata$Global_active_power))

x<-paste(newdata$Date,newdata$Time)
newdata$timestamp<-strptime(x,"%Y-%m-%d %H:%M:%S")

#newdata <- transform(newdata, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

           # plot the file
plot(newdata$timestamp,newdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
           # create the png file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
      }
plot2()
