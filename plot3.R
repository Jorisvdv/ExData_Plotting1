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
household.subset <- household.power[household.power$Date %in% c("1/2/2007","2/2/2007") ,.(DateTime = strptime(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"), Sub_metering_1, Sub_metering_2, Sub_metering_3)]

#Open png device
png(file="plot3.png",width = 480, height = 480)
#Plot lines and legend
with(household.subset,
     {plot(DateTime, Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(DateTime, Sub_metering_2, type="l", col="red")
lines(DateTime, Sub_metering_3, type="l", col="blue")})
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), col=c("black","red","blue"))
#Close png device
dev.off()
