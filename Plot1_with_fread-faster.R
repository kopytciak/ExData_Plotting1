library(data.table)
#library(lubridate)

file    <- "~/Coursera/lectures/Exploratory Data Analysis/PA1/household_power_consumption.txt"

# Read file in a datatable
classes<-c(rep('character',2),rep('numeric',7))
#fread is much faster than read.table, but will read everything as char. 
rawData <- fread(file, header=TRUE, sep=';' , na.strings='?', data.table=TRUE)

# format dates
rawData$Date <- as.Date(rawData$Date, format='%d/%m/%Y')

# Get data of two days
daysPeriod <-  rawData[rawData$Date >= '2007-02-01' & rawData$Date <= '2007-02-01']
# Format DateTime
daysPeriod$DateTime <- paste(daysPeriod$Date, daysPeriod$Time)
daysPeriod$DateTime <- strptime(daysPeriod$DateTime, format = '%Y-%m-%d %H:%M:%S')

# Convert some columns to numeric format
for(col in c(3:9)) {
  daysPeriod[,col] <- as.numeric(as.character(daysPeriod[,col]))
}

hist(daysPeriod$Global_active_power, col = "red", main ="Global Active Power", xlab = "Global Active Power(kilowatts)")