# Clean up workspace
rm(list = ls())

# Read in data
filename = 'exploratorydataanalysis_week1/household_power_consumption.txt'
data <- read.table(file = filename, sep = ";" , header = T, na.strings ="?", stringsAsFactors= F)

data$datetime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

date_format = "%d/%m/%Y"
data$Date = as.Date(data$Date, date_format)
# this time column has the wrong date attached to it
data$Time = strptime(data$Time, format = "%H:%M:%S")

# Segment data
date_format = "%d-%m-%Y"
data_segment = data[(data$Date == as.Date("01-02-2007", date_format) | data$Date == as.Date("02-02-2007", date_format)), ]

# Create & save plot (using base library)
png("exploratorydataanalysis_week1/plot2.png", width = 480, height = 480)

plot(data_segment$datetime, data_segment$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
lines(data_segment$datetime, data_segment$Global_active_power, type = "l")

dev.off()
