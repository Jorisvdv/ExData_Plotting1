library(data.table)
# Check if data file exists in working directory
if (!(file.exists("household_power_consumption.zip")|file.exists("household_power_consumption.txt"))) {
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")}
if (!file.exists("household_power_consumption.txt")) {
unzip("household_power_consumption.zip")}

#Import dataset
household.power <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")
#Subset data and select variable
household.subset <- household.power[household.power$Date %in% c("1/2/2007","2/2/2007"), Global_active_power]

#Open png device
png("plot1.png", width=480, height=480)
#Create histrogram
hist(household.subset, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
#Close png device
dev.off()