data <- read.table("household_power_consumption.txt", header=TRUE, sep = ";") ## Load data set
data$Date <- as.Date(data$Date, format="%d/%m/%Y") ## Convert to Date column
subset_data <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),] ## Subset to target date range


subset_data$DateTime = paste(subset_data$Date,subset_data$Time, sep = ' ') ## Combine date and time
subset_data$DateTime <- strptime(subset_data$DateTime, format = "%Y-%m-%d %H:%M:%S") ## Convert to date and time

## All my dataframe values are factors. Probably imported them wrong. Now we get to convert them. Cool.

as.numeric.factor <- function(x) {as.numeric(levels(x))[x]} ## Function to convert factors to numeric
subset_data$Global_active_power <- as.numeric.factor(subset_data$Global_active_power) ## Convert to numeric
subset_data$Global_reactive_power <- as.numeric.factor(subset_data$Global_reactive_power) ## Convert to numeric
subset_data$Voltage <- as.numeric.factor(subset_data$Voltage) ## Convert to numeric
subset_data$Sub_metering_1 <- as.numeric.factor(subset_data$Sub_metering_1) ## Convert to numeric
subset_data$Sub_metering_2 <- as.numeric.factor(subset_data$Sub_metering_2) ## Convert to numeric
subset_data$Sub_metering_3 <- as.numeric.factor(subset_data$Sub_metering_3) ## Convert to numeric

png(filename = "plot4.png", width=480, height=480) ## Make file
par(mfrow = c(2,2)) ## Make grid for plots
## Plot 1
plot(subset_data[,"DateTime"], subset_data[,"Global_active_power"], type='l', main = "", xlab = "", ylab = "Global Active Power (kilowatts)")

## Plot 2
plot(subset_data[,"DateTime"], subset_data[,"Voltage"], type='l', xlab = "datetime", ylab = "Voltage")

## Plot 3
plot(subset_data[,"DateTime"], subset_data[,"Sub_metering_1"], type='l', ylab = "Energy sub metering", xlab = "")
lines(subset_data[,"DateTime"], subset_data[,"Sub_metering_2"], type='l', col = "red")
lines(subset_data[,"DateTime"], subset_data[,"Sub_metering_3"], type='l', col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

## Plot 4
plot(subset_data[,"DateTime"], subset_data[,"Global_reactive_power"], type='l', main = "", xlab = "", ylab = "Global_reactive_power")
dev.off()
