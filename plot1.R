
plot1 <- function() {
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

           # plot the file
hist(newdata$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
           # create the png file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
      }
plot1()