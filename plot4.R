plot4 <- function() {

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

t<-newdata$Global_reactive_power
newdata$Global_reactive_power <-t[!t %in% c("?")]
newdata$Global_reactive_power <- as.numeric(as.character(newdata$Global_reactive_power))


t<-newdata$Sub_metering_1 
newdata$Sub_metering_1 <-t[!t %in% c("?")]
newdata$Sub_metering_1 <- as.numeric(as.character(newdata$Sub_metering_1))

t<-newdata$Sub_metering_2 
newdata$Sub_metering_2 <-t[!t %in% c("?")]
newdata$Sub_metering_2 <- as.numeric(as.character(newdata$Sub_metering_2))

t<-newdata$Sub_metering_3 
newdata$Sub_metering_3 <-t[!t %in% c("?")]
newdata$Sub_metering_3 <- as.numeric(as.character(newdata$Sub_metering_3))


t<-newdata$Voltage 
newdata$Voltage <-t[!t %in% c("?")]
newdata$Voltage <- as.numeric(as.character(newdata$Voltage))

x<-paste(newdata$Date,newdata$Time)
newdata$timestamp<-strptime(x,"%Y-%m-%d %H:%M:%S")


           # Starting the Plots 
par(mfrow=c(2,2))
               
              #Plot 1
plot(newdata$timestamp,newdata$Global_active_power, type="l", xlab="", ylab="Global Active Power")

              #Plot 2
plot(newdata$timestamp,newdata$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
              #Plot 3

plot(newdata$timestamp,newdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(newdata$timestamp,newdata$Sub_metering_2,col="red")
lines(newdata$timestamp,newdata$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) 
        
              #Plot 4

plot(newdata$timestamp,newdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
              # create the png file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
      }
plot4()

 