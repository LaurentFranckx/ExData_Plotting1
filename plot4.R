unzip("exdata-data-household_power_consumption.zip")                            
consump_raw <- read.csv2("household_power_consumption.txt", nrows = 2075259)

consump_raw$Date2 <- as.Date(as.character(consump_raw$Date), format = "%e/%m/%Y")
datestring <- paste(as.character(consump_raw$Date),as.character(consump_raw$Time), sep =",")
consump_raw$Time2 <- strptime(datestring, format = "%e/%m/%Y, %H:%M:%S")


consump_anal <- consump_raw[consump_raw$Date2  == "2007-02-01"  | consump_raw$Date2 == "2007-02-02"   , ]

var_names <- c("Global_active_power", "Global_reactive_power" ,"Voltage","Global_intensity",
               "Sub_metering_1", "Sub_metering_2")

for(measure in var_names){
        consump_anal[  , measure]   <- as.character(consump_anal[  , measure] )
        consump_anal <- consump_anal[consump_anal[  , measure] != "?", ]
        consump_anal[  , measure]   <- as.numeric(consump_anal[  , measure] )
}




Sys.setlocale("LC_TIME", "English")

png("plot4.png" , width = 480, height = 480)
par(mfrow = c(2,2))

plot(consump_anal$Time2, consump_anal$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(consump_anal$Time2, consump_anal$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")


plot(consump_anal$Time2, consump_anal$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(consump_anal$Time2, consump_anal$Sub_metering_2, col = "red")
lines(consump_anal$Time2, consump_anal$Sub_metering_3, col = "blue")
legend("topright",  lty =1 , col = c("black","red","blue")
       , legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")


plot(consump_anal$Time2, consump_anal$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")


dev.off()

    





