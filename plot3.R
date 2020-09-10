library(dplyr)

#Read the data
unzip("./exdata_data_household_power_consumption.zip")
data=read.csv("./household_power_consumption.txt",sep = ";",nrows = 100000)

#Transform the "Date" column to Date/Time format
data$Date=as.Date(data$Date,"%d/%m/%Y")

#Filter the dates we are going to use for the analysis
data=filter(data,Date==(as.Date("2007-02-01")) |  Date==as.Date("2007-02-02"))

#Filter the dates we are going to use for the analysis
data=filter(data,Date=="1/2/2007" |  Date=="2/2/2007")

#Transform into one column with date and time
data=mutate(data, DateTime=paste(data$Date,data$Time))

#Delete the Date and Time columns
data=select(data,Global_active_power:DateTime)

#Transform the "DateTime" column to Date/Time format
data$DateTime=strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")

#Make the scatterplot of Energy sub metering by day and add lines
plot(data$DateTime,data$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
lines(data$DateTime,data$Sub_metering_1,lwd=1,col="black")
lines(data$DateTime,data$Sub_metering_2,lwd=1, col="red")
lines(data$DateTime,data$Sub_metering_3,lwd=1, col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

#Export the Histogram as a png file
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()