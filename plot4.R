library(dplyr)

#Read the data
unzip("./exdata_data_household_power_consumption.zip")
data=read.csv("./household_power_consumption.txt",sep = ";",nrows = 100000)

#Filter the dates we are going to use for the analysis
data=filter(data,Date=="1/2/2007" |  Date=="2/2/2007")

#Transform into one column with date and time
data=mutate(data, DateTime=paste(data$Date,data$Time))

#Delete the Date and Time columns
data=select(data,Global_active_power:DateTime)

#Transform the "DateTime" column to Date/Time format
data$DateTime=strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")


#Set the number of plots by row and column
par(mfrow=c(2,2),mar=c(2.5,5,1,1))

#Plot 1
plot(data$DateTime,data$Global_active_power, type="n", xlab = "", ylab ="Global Active Power (kilowatts)")
lines(data$DateTime,data$Global_active_power,lwd=1)

#Plot 2
plot(data$DateTime,data$Voltage, type="n", xlab = "datetime", ylab ="Voltage" )
lines(data$DateTime,data$Voltage,lwd=1)

#Plot 3

plot(data$DateTime,data$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
lines(data$DateTime,data$Sub_metering_1,lwd=1,col="black")
lines(data$DateTime,data$Sub_metering_2,lwd=1, col="red")
lines(data$DateTime,data$Sub_metering_3,lwd=1, col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1,lwd=1.5,cex=0.8, pt.cex(2),bty="n")

#Plot 4
plot(data$DateTime,data$Global_reactive_power, type="n", xlab = "datetime", ylab ="Global_reative_power" )
lines(data$DateTime,data$Global_reactive_power,lwd=1)

#Export the Histogram as a png file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()