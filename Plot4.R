library(sqldf) #required for the read.csv.sql

filePath    <- "~/Coursera/lectures/Exploratory Data Analysis/PA1/household_power_consumption.txt"

#reads only the selected part of the data, takes care of the date/time formatting.
#I tried with read.table and fread (way faster) before, but this is much nicer! 
rawFrame <- read.csv.sql( file=filePath,
                      sep=";",
                      sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                      header=TRUE)

# Format DateTime
rawFrame$DateTime <- paste(rawFrame$Date, rawFrame$Time)
rawFrame$DateTime <- strptime(rawFrame$DateTime, format = '%d/%m/%Y %H:%M:%S')

#prepare graphic device 
png(filename='plot4.png', width = 480, height = 480, units = 'px', bg = 'white')

#Graphic with 2 lnes and two columns
par(mfrow=c(2,2))


# Graphic 1 Plot
plot(rawFrame$DateTime, rawFrame$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

# Graphic 2 Plot
plot(rawFrame$DateTime, rawFrame$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# Graphic Plot
plot(rawFrame$DateTime, rawFrame$Sub_metering_1, col = 'black',
     type="l",
     xlab="",
     ylab="Energy sub metering")

lines(rawFrame$DateTime, rawFrame$Sub_metering_2, col='red')
lines(rawFrame$DateTime, rawFrame$Sub_metering_3, col='blue')
legend("topright",col=c("black", "red", "blue"), c("Sub_metering_1", 
                                                   "Sub_metering_2", "Sub_metering_3"), lty=1)



# Graphic 4 Plot
plot(rawFrame$DateTime, rawFrame$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(rawFrame$DateTime, rawFrame$Global_reactive_power)

#clean up graphic device
dev.off()