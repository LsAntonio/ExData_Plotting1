# Download the data [optional]
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./file.zip")
unzip("file.zip")

# Read the data
#21997: Number of minutes to skip until January 01, 2007
#44640: Total number of minutes in January 2007 [31 days]
#66637: Total number of rows to skip until February 01, 2007
#2880: Total minutes in two days [2007-02-01 and 2007-02-02]

pData <- read.table("household_power_consumption.txt", sep = ";",
                    header = FALSE, skip = 66637,
                    nrows = 2880, col.names = c("Date","Time", "Global_active_power", "Global_reactive_power",
                                                "Voltage", "Global_intensity", "Sub_metering_1",
                                                "Sub_metering_2", "Sub_metering_3"))
# Convert to Datetime format
pData$datetime <- as.character(paste(pData$Date, pData$Time))
pData$datetime <- strptime(pData$datetime, "%d/%m/%Y %H:%M:%S")

# Plot 4
png("plot4.png", height = 480, width = 480)

par(mfcol = c(2,2))

## Sub Plot 1
with(pData, plot(datetime, Global_active_power, type = "l",
                 ylab = "Global Active Power", xlab = ""))

## Sub Plot 2
with(pData, plot(datetime, Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = ""))
lines(pData$datetime, pData$Sub_metering_2, col = "red")
lines(pData$datetime, pData$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty= "solid", bty = "n")

## Sub Plot 3
with(pData, plot(datetime, Voltage, type = "l"))

## Sub Plot 4
with(pData, plot(datetime, Global_reactive_power, type = "l"))

dev.off()