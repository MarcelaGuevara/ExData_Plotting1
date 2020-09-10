library(dplyr)

#Read the data
unzip("./exdata_data_household_power_consumption.zip")
data=read.csv("./household_power_consumption.txt",sep = ";",nrows = 100000)

#Transform the "Date" column to Date/Time format
data$Date=as.Date(data$Date,"%d/%m/%Y")

#Filter the dates we are going to use for the analysis
data=filter(data,Date==(as.Date("2007-02-01")) |  Date==as.Date("2007-02-02"))

#Make the histogram of the Global active power
hist(as.numeric(data$Global_active_power), col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#Export the Histogram as a png file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()