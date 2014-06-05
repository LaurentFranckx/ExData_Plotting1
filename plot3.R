unzip("exdata-data-household_power_consumption.zip")                            
consump_raw <- read.csv2("household_power_consumption.txt", nrows = 2075259)

consump_raw$Date2 <- as.Date(as.character(consump_raw$Date), format = "%e/%m/%Y")
datestring <- paste(as.character(consump_raw$Date),as.character(consump_raw$Time), sep =",")
consump_raw$Time2 <- strptime(datestring, format = "%e/%m/%Y, %H:%M:%S")


consump_anal <- consump_raw[consump_raw$Date2  == "2007-02-01"  | consump_raw$Date2 == "2007-02-02"   , ]

consump_anal$Sub_metering_1 <- as.character(consump_anal$Sub_metering_1)
consump_anal$Sub_metering_2 <- as.character(consump_anal$Sub_metering_2)
consump_anal$Sub_metering_3 <- as.character(consump_anal$Sub_metering_3)
consump_anal <- consump_anal[consump_anal$Sub_metering_1 != "?", ]
consump_anal <- consump_anal[consump_anal$Sub_metering_2 != "?", ]
consump_anal <- consump_anal[consump_anal$Sub_metering_3 != "?", ]
consump_anal$Sub_metering_1 <- as.numeric(consump_anal$Sub_metering_1)
consump_anal$Sub_metering_2 <- as.numeric(consump_anal$Sub_metering_2)
consump_anal$Sub_metering_3 <- as.numeric(consump_anal$Sub_metering_3)


Sys.setlocale("LC_TIME", "English")
plot(consump_anal$Time2, consump_anal$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(consump_anal$Time2, consump_anal$Sub_metering_2, col = "red")
lines(consump_anal$Time2, consump_anal$Sub_metering_3, col = "blue")

dev.copy(png, "plot3.png" , width = 480, height = 480)
dev.off()

    





