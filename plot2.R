data <- read.table("household_power_consumption.txt", header=TRUE, sep = ";") ## Load data set
data$Date <- as.Date(data$Date, format="%d/%m/%Y") ## Convert to Date column
subset_data <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),] ## Subset to target date range


subset_data$DateTime = paste(subset_data$Date,subset_data$Time, sep = ' ') ## Combine date and time
subset_data$DateTime <- strptime(subset_data$DateTime, format = "%Y-%m-%d %H:%M:%S") ## Convert to date and time


as.numeric.factor <- function(x) {as.numeric(levels(x))[x]} ## Function to convert factors to numeric
subset_data$Global_active_power <- as.numeric.factor(subset_data$Global_active_power) ## Convert to numeric


png(filename = "plot2.png", width=480, height=480) ## Make file
plot(subset_data[,"DateTime"], subset_data[,"Global_active_power"], type='l', main = "", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
