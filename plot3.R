data <- read.table("household_power_consumption.txt", header=TRUE, sep = ";") ## Load data set
data$Date <- as.Date(data$Date, format="%d/%m/%Y") ## Convert to Date column
subset_data <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),] ## Subset to target date range


subset_data$DateTime = paste(subset_data$Date,subset_data$Time, sep = ' ') ## Combine date and time
subset_data$DateTime <- strptime(subset_data$DateTime, format = "%Y-%m-%d %H:%M:%S") ## Convert to date and time


as.numeric.factor <- function(x) {as.numeric(levels(x))[x]} ## Function to convert factors to numeric
subset_data$Sub_metering_1 <- as.numeric.factor(subset_data$Sub_metering_1) ## Convert to numeric
subset_data$Sub_metering_2 <- as.numeric.factor(subset_data$Sub_metering_2) ## Convert to numeric
subset_data$Sub_metering_3 <- as.numeric.factor(subset_data$Sub_metering_3) ## Convert to numeric

png(filename = "plot3.png", width=480, height=480) ## Make file
plot(subset_data[,"DateTime"], subset_data[,"Sub_metering_1"], type='l', ylab = "Energy sub metering", xlab = "")
lines(subset_data[,"DateTime"], subset_data[,"Sub_metering_2"], type='l', col = "red")
lines(subset_data[,"DateTime"], subset_data[,"Sub_metering_3"], type='l', col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
dev.off()
