#
# This script is used to generate Plot 2 of Plotting Assignment 1 for Exploratory Data Analysis
#

#
# This part is used to separate the two days of relevant data from the original set
# OS level calls made to generate "filtered.txt"
#
system('cat household_power_consumption.txt | grep "^2/2/2007" > filtered.txt')
system('cat household_power_consumption.txt | grep "^1/2/2007" >> filtered.txt')

# load data into data frame
ds4_data <- read.table("filtered.txt", header = FALSE, sep=";")

# add column names
colnames(ds4_data) <- c('date', 'time', 'global_active_power', 'global_reactive_power', 'voltage', 'global_intensity', 'sub_metering_1', 'sub_metering_2', 'sub_metering_3')

# use strptime to convert 1st and 2nd columns into date with time
ds4_data <- transform(ds4_data, datetime = strptime(paste(ds4_data$date, ',', ds4_data$time, sep=''), format='%d/%m/%Y,%H:%M:%S'))

# use as.Date to convert first column into Date
ds4_data$date <- as.Date(ds4_data$date, format='%d/%m/%Y')

#plot histogram
png('plot1.png', width = 480, height = 480)
hist(ds4_data$global_active_power, col="red", xlab='Global Active Power (kilowatts)', main='Global Active Power', )
dev.off()
