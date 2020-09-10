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

#Make the scatterplot of Global Active Power by day and add lines
plot(data$DateTime,data$Global_active_power, pch=20, type="n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$DateTime,data$Global_active_power,lwd=2)

#Export the Histogram as a png file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()