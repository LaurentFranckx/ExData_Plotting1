unzip("exdata-data-household_power_consumption.zip")                            
consump_raw <- read.csv2("household_power_consumption.txt", nrows = 2075259)

consump_raw$Date2 <- as.Date(as.character(consump_raw$Date), format = "%e/%m/%Y")

datestring <- paste(as.character(consump_raw$Date),as.character(consump_raw$Time), sep =",")

consump_raw$Time2 <- strptime(datestring, format = "%e/%m/%Y, %H:%M:%S")


consump_anal <- consump_raw[consump_raw$Date2  == "2007-02-01"  | consump_raw$Date2 == "2007-02-02"   , ]
consump_anal$Global_active_power <- as.character(consump_anal$Global_active_power)
consump_anal <- consump_anal[ consump_anal$Global_active_power != "?", ]
consump_anal$Global_active_power <- as.numeric(consump_anal$Global_active_power)

Sys.setlocale("LC_TIME", "English")
plot(consump_anal$Time2, consump_anal$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")


dev.copy(png, "plot2.png" , width = 480, height = 480)
dev.off()

    





