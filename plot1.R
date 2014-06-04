unzip("exdata-data-household_power_consumption.zip")                            
consump_raw <- read.csv2("household_power_consumption.txt", nrows = 2075259)
summary(consump_raw)
classes <- sapply(consump_raw,class)

consump_raw$Date <- as.Date(as.character(consump_raw$Date), format = "%e/%m/%Y")
#consump_raw$Time <- as.Date(as.character(consump_raw$Time), format = "%H:%M:%S")
consump_anal <- consump_raw[consump_raw$Date  == "2007-02-01"  | consump_raw$Date == "2007-02-02"   , ]
summary(consump_anal)

consump_anal$Global_active_power <- as.character(consump_anal$Global_active_power)
consump_anal <- consump_anal[ consump_anal$Global_active_power != "?", ]

consump_anal$Global_active_power <- as.numeric(consump_anal$Global_active_power)

summary(consump_anal$Global_active_power)
hist(consump_anal$Global_active_power, col = "red", main = "Global active power"
     , xlab = "Global Active Power (kilowatts)")
dev.copy(png, "plot1.png" , width = 480, height = 480)
dev.off()

    





