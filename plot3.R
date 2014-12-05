## Electric power consumption: Energy sub metering through time
#  (2007-02-01 and 2007-02-02)

# Reading dataset form csv file (if it doesn't exists allready)
if(!exists("df.all")) {
    df.all <- read.csv("../data//household_power_consumption.txt", sep = ";")
}

# Transforming strings in Date column to dates and appending DateTime column
df.all$Date <- as.Date(df.all$Date, format = "%d/%m/%Y")
df.all$DateTime <- strptime(paste(df.all$Date, " ", df.all$Time), "%Y-%m-%d %H:%M:%S")

# Transforming numeric values from levels
df.all$Global_active_power <- as.numeric(as.character(df.all$Global_active_power))
df.all$Sub_metering_1 <- as.numeric(as.character(df.all$Sub_metering_1))
df.all$Sub_metering_2 <- as.numeric(as.character(df.all$Sub_metering_2))
df.all$Sub_metering_3 <- as.numeric(as.character(df.all$Sub_metering_3))

# subseting only data for required dates
df <- subset(df.all,
             df.all$Date >= as.Date('2007-02-01') & df.all$Date <= as.Date('2007-02-02'))

# setting locale to en_US for proper day in a week labels
locale_original <- Sys.getlocale( category = "LC_TIME" )
Sys.setlocale( category = "LC_TIME", locale = "en_US.UTF-8")

# plotting graph to png image file
png("plot3.png", width = 504, height = 504)
plot(x = df$DateTime, y = df$Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = "" )
points(x = df$DateTime, y = df$Sub_metering_2, type = "l", col = "red")
points(x = df$DateTime, y = df$Sub_metering_3, type = "l", col = "blue")

legend(x = "topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"))

dev.off()

# restoring original locale
Sys.setlocale( category = "LC_TIME", locale = locale_original )
