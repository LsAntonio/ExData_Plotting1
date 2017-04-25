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

# Plot 1
png("plot1.png", height = 480, width = 480)

hist(pData$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
