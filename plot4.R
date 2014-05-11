#
# This script is used to generate Plot 4 of Plotting Assignment 1 for Exploratory Data Analysis
#

#
# This part is used to separate the two days of relevant data from the original set
# OS level calls made to generate "filtered.txt"
#
system('cat household_power_consumption.txt | grep "^1/2/2007" > filtered.txt')
system('cat household_power_consumption.txt | grep "^2/2/2007" >> filtered.txt')

# load data into data frame
ds4_data <- read.table("filtered.txt", header = FALSE, sep=";")

# add column names
colnames(ds4_data) <- c('date', 'time', 'global_active_power', 'global_reactive_power', 'voltage', 'global_intensity', 'sub_metering_1', 'sub_metering_2', 'sub_metering_3')

# use strptime to convert 1st and 2nd columns into date with time
ds4_data <- transform(ds4_data, datetime = strptime(paste(ds4_data$date, ',', ds4_data$time, sep=''), format='%d/%m/%Y,%H:%M:%S'))

# use as.Date to convert first column into Date
ds4_data$date <- as.Date(ds4_data$date, format='%d/%m/%Y')

#plot histogram
png('plot4.png', width = 480, height = 480)

par(mfrow = c(2,2))

with(ds4_data, {

plot(global_active_power ~ datetime, type = "n", data = ds4_data, xlab = '', ylab = 'Global Active Power')
lines(ds4_data$datetime, ds4_data$global_active_power, col="black")

plot(voltage ~ datetime, type = "n", data = ds4_data, xlab = 'datetime', ylab='Voltage')
lines(ds4_data$datetime, ds4_data$voltage, col="black")

plot(sub_metering_1 ~ datetime, type = "n", data = ds4_data, xlab = '', ylab = 'Energy sub metering')
lines(ds4_data$datetime, ds4_data$sub_metering_1, col="black")
lines(ds4_data$datetime, ds4_data$sub_metering_2, col="red")
lines(ds4_data$datetime, ds4_data$sub_metering_3, col="blue")
legend("topright", col= c("black", "red", "blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), bty="n")

plot(global_reactive_power ~ datetime, type = "n", data = ds4_data, xlab = 'datetime', ylab='Global_reactive_power')
lines(ds4_data$datetime, ds4_data$global_reactive_power, col="black")
})
dev.off()
