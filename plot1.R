data <- read.table("household_power_consumption.txt", header=TRUE, sep = ";") ## Load data set
data$Date <- as.Date(data$Date, format="%d/%m/%Y") ## Convert to Date column
subset_data <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),] ## Subset to target date range

as.numeric.factor <- function(x) {as.numeric(levels(x))[x]} ## Function to convert factors to numeric
subset_data$Global_active_power <- as.numeric.factor(subset_data$Global_active_power) ## Convert to numeric

png(filename = "plot1.png", width=480, height=480) ## Make file
hist(subset_data[,"Global_active_power"], col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
