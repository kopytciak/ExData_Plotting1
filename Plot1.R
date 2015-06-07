library(sqldf) #required for the read.csv.sql

filePath    <- "~/Coursera/lectures/Exploratory Data Analysis/PA1/household_power_consumption.txt"

#reads only the selected part of the data, takes care of the date/time formatting.
#I tried with read.table and fread (way faster) before, but this is much nicer! 
rawFrame <- read.csv.sql( file=filePath,
                      sep=";",
                      sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                      header=TRUE)

#prepare graphic device 
png(filename='plot1.png', width = 480, height = 480, units = 'px', bg = 'white')
#create the graph
hist(rawFrame$Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Plot 1")
#clean up graphic device
dev.off()