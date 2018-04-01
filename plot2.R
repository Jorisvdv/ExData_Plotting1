library(data.table)
#library(lubridate)
# Check if data file exists in working directory
if (!(file.exists("household_power_consumption.zip")|file.exists("household_power_consumption.txt"))) {
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")}
if (!file.exists("household_power_consumption.txt")) {
unzip("household_power_consumption.zip")}

#Import dataset
household.power <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")
#Select correct dates and transform variables
household.subset <- household.power[household.power$Date %in% c("1/2/2007","2/2/2007") ,.(DateTime = strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"), Global_active_power)]

#Open png device
png(file="plot2.png",width = 480, height = 480)
#Change locale to ensure correct axis labels
systemtime <- Sys.getlocale(category = "LC_TIME")
Sys.setlocale("LC_TIME", "en_GB.UTF-8")
#Plot data
plot(Global_active_power ~ DateTime, data = household.subset, type="l",xlab="",ylab="Global Active Power (kilowatts)")
#Close png device
dev.off()
#Change locale to previous setting
Sys.setlocale("LC_TIME", systemtime)

