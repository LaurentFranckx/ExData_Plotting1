unzip("exdata-data-household_power_consumption.zip")                            
consump_raw <- read.csv2("household_power_consumption.txt", nrows = 2075259)

consump_raw$Date2 <- as.Date(as.character(consump_raw$Date), format = "%e/%m/%Y")
datestring <- paste(as.character(consump_raw$Date),as.character(consump_raw$Time), sep =",")
consump_raw$Time2 <- strptime(datestring, format = "%e/%m/%Y, %H:%M:%S")


consump_anal <- consump_raw[consump_raw$Date2  == "2007-02-01"  | consump_raw$Date2 == "2007-02-02"   , ]

var_names <- c("Global_active_power", "Global_reactive_power" ,"Voltage","Global_intensity",
               "Sub_metering_1", "Sub_metering_2")


Sys.setlocale("LC_TIME", "English")

png("plot4.png" , width = 480, height = 480)
par(mfrow = c(2,2))

consump_gap <- consump_anal
consump_gap$Global_active_power <- as.character(consump_gap$Global_active_power)
consump_gap <- consump_gap[ consump_gap$Global_active_power != "?", ]
consump_gap$Global_active_power <- as.numeric(consump_gap$Global_active_power)
plot(consump_gap$Time2, consump_gap$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

consump_volt <- consump_anal
consump_volt$Voltage <- as.character(consump_volt$Voltage)
consump_volt <- consump_volt[ consump_volt$Voltage != "?", ]
consump_volt$Voltage <- as.numeric(consump_volt$Voltage)
plot(consump_volt$Time2, consump_volt$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")


consump_submet <- consump_anal
consump_submet$Sub_metering_1 <- as.character(consump_submet$Sub_metering_1)
consump_submet$Sub_metering_2 <- as.character(consump_submet$Sub_metering_2)
consump_submet$Sub_metering_3 <- as.character(consump_submet$Sub_metering_3)
consump_submet <- consump_submet[consump_submet$Sub_metering_1 != "?", ]
consump_submet <- consump_submet[consump_submet$Sub_metering_2 != "?", ]
consump_submet <- consump_submet[consump_submet$Sub_metering_3 != "?", ]
consump_submet$Sub_metering_1 <- as.numeric(consump_submet$Sub_metering_1)
consump_submet$Sub_metering_2 <- as.numeric(consump_submet$Sub_metering_2)
consump_submet$Sub_metering_3 <- as.numeric(consump_submet$Sub_metering_3)
plot(consump_submet$Time2, consump_submet$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(consump_submet$Time2, consump_submet$Sub_metering_2, col = "red")
lines(consump_submet$Time2, consump_submet$Sub_metering_3, col = "blue")
legend("topright",  lty =1 , col = c("black","red","blue")
       , legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")



consump_react <- consump_anal
consump_react$Global_active_power <- as.character(consump_react$Global_active_power)
consump_react <- consump_react[ consump_react$Global_active_power != "?", ]
consump_react$Global_active_power <- as.numeric(consump_react$Global_active_power)
plot(consump_react$Time2, consump_react$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")


dev.off()

    





