data_dir = '~/Downloads/ocw/DataScienceSpecialization/exdata-002/project/01/'

getData <- function(){
  hpc <- read.csv(paste0(data_dir,'household_power_consumption.txt'), sep=';', na.strings='?')
  hpc <- subset(hpc, hpc$Date == '1/2/2007' | hpc$Date == '2/2/2007')
  hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time, sep=' '), '%d/%m/%Y %H:%M:%S')
  hpc
}

#load if not loaded before
if(!exists('hpc')) {
  hpc <- getData()
}

plot1 <- function(not_save = FALSE){
  if(!not_save) { png('plot1.png') }
  hist(hpc$Global_active_power, col = 'red', main = 'Global Active Power', 
    xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency')
  if(!not_save) { dev.off() }
}

plot2 <- function(not_save = FALSE){
  if(!not_save) { png('plot2.png') }
  plot(hpc$DateTime, hpc$Global_active_power, type='l', xlab='', 
    ylab='Global Active Power (kilowatts)')
  if(!not_save) { dev.off() }
}

plot3 <- function(not_save = FALSE){
  if(!not_save) { png('plot3.png') }
  plot(hpc$DateTime, hpc$Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
  points(hpc$DateTime, hpc$Sub_metering_2, type='l', col='red')
  points(hpc$DateTime, hpc$Sub_metering_3, type='l', col='blue')
  legend('topright', lwd=c(1, 1, 1), col=c('black','red','blue'), border=c(1,4,1,1),
    legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
  if(!not_save) { dev.off() }
}

plot4 <- function(){
  png('plot4.png')
  par(mfrow = c(2,2))
  plot2(TRUE)
  plot(hpc$DateTime, hpc$Voltage, type='l', col='black', xlab='datetime', ylab='Voltage')
  plot3(TRUE)
  plot(hpc$DateTime, hpc$Global_reactive_power, type='l', col='black', xlab='datetime', 
    ylab='Global_reactive_power')
  dev.off()
}
