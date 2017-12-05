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

##
# Create & save plot (using base library)
png("exploratorydataanalysis_week1/plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

# PLOT 1
plot(data_segment$datetime, data_segment$Global_active_power, type = "n", ylab = "Global Active Power", xlab = "")
lines(data_segment$datetime, data_segment$Global_active_power, type = "l")

# PLOT 2
plot(data_segment$datetime, data_segment$Voltage, type = "n", ylab = "Voltage", xlab = "datetime")
lines(data_segment$datetime, data_segment$Voltage, type = "l")

# PLOT 3
plot(data_segment$datetime, data_segment$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(data_segment$datetime, data_segment$Sub_metering_1, type = "l")
lines(data_segment$datetime, data_segment$Sub_metering_2, type = "l", col = 
        "red")
lines(data_segment$datetime, data_segment$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), bty = "n", lty = c(1,1,1)) #lty = line type; can also use pch and lwd

# PLOT 4
plot(data_segment$datetime, data_segment$Global_reactive_power, type = "n", ylab = "Global_reactive_power", xlab = "datetime")
lines(data_segment$datetime, data_segment$Global_reactive_power, type = "l")

dev.off()
