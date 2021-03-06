# Exploratory Data Analysis @ Coursera.org
# Course Project 1
# Plot 1
# by Hao Wu
# Read original data from text file, assuming data file is in the same folder of this script.
temp <- tempfile()
curl::curl_download(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
                    temp)
originalData <- read.table(file=unz(temp, 'household_power_consumption.txt'),
                           sep=';', quote='', dec='.', header=T,
                           stringsAsFactors=F,
                           colClasses=c('character','character', rep('numeric', times=7)),
                           na.strings=c('?', 'na', 'null'))
# Subset interesting data and combine Date and Time.
require(dplyr)
data <- originalData %>% 
        filter(Date %in% c('1/2/2007','2/2/2007')) %>%
        mutate(DateTime=as.POSIXct(paste(Date,Time,sep=' '), format='%d/%m/%Y %H:%M:%S'))
# Open png file as graphic device and specify output file size
png(filename='./plot3.png',
    width=480, height=480, units='px', pointsize=12,
    bg='white')
# Make plot
with(data, { plot(x=DateTime, y=Sub_metering_1, type='l', col='black', xlab='', ylab='Energy sub metering');
             lines(x=DateTime, y=Sub_metering_2, type='l', col='green');
             lines(x=DateTime, y=Sub_metering_3, type='l', col='blue');
    })
legend("topright", lty=1, cex=0.7,
       col=c('black', 'green', 'blue'),
       legend=c('Sum_metering_1', 'Sum_metering_2', 'Sum_metering_3'))

# Close graphic device
dev.off()

