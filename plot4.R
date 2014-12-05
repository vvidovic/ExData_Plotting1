## Electric power consumption: 4 graphs on one image
#  (2007-02-01 and 2007-02-02)

# Reading dataset form csv file (if it doesn't exists allready)
if(!exists("df.all")) {
    df.all <- read.csv("../data//household_power_consumption.txt", sep = ";")
} else {
    print("skipping read.csv, using existing data...")
}

# subseting only data for required dates
df <- subset(df.all, df.all$Date == '1/2/2007' | df.all$Date == '2/2/2007')

# Transforming strings in Date column to dates and appending DateTime column
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$DateTime <- strptime(paste(df$Date, " ", df$Time), "%Y-%m-%d %H:%M:%S")

# Transforming numeric values from levels
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
df$Voltage <- as.numeric(as.character(df$Voltage))

# setting locale to en_US for proper day in a week labels
locale_original <- Sys.getlocale( category = "LC_TIME" )
Sys.setlocale( category = "LC_TIME", locale = "en_US.UTF-8")

# plotting graph to png image file
png("plot4.png", width = 504, height = 504)
par(mfrow = c(2, 2))


plot(x = df$DateTime, y = df$Global_active_power,
     type = "l", ylab = "Global Active Power", xlab = "" )

plot(x = df$DateTime, y = df$Voltage,
     type = "l", ylab = "Voltage", xlab = "datetime" )

plot(x = df$DateTime, y = df$Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = "" )
points(x = df$DateTime, y = df$Sub_metering_2, type = "l", col = "red")
points(x = df$DateTime, y = df$Sub_metering_3, type = "l", col = "blue")
legend(x = "topright", bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"))

plot(x = df$DateTime, y = df$Global_reactive_power,
     type = "l", ylab = "Global_reactive_power", xlab = "datetime" )

dev.off()

# restoring original locale
Sys.setlocale( category = "LC_TIME", locale = locale_original )
