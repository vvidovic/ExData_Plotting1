## Electric power consumption: Energy sub metering through time
#  (2007-02-01 and 2007-02-02)

# Extracted csv file (put to "../data" directory), data source:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Reading dataset form csv file (if it doesn't exists allready)
if(!exists("df.all")) {
    df.all <- read.csv("../data//household_power_consumption.txt", sep = ";", na.strings = "?")
} else {
    print("skipping read.csv, using existing data...")
}

# subseting only data for required dates
df <- subset(df.all, df.all$Date == '1/2/2007' | df.all$Date == '2/2/2007')

# Transforming strings in Date column to dates and appending DateTime column
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$DateTime <- strptime(paste(df$Date, " ", df$Time), "%Y-%m-%d %H:%M:%S")

# setting locale to en_US for proper day in a week labels
locale_original <- Sys.getlocale( category = "LC_TIME" )
Sys.setlocale( category = "LC_TIME", locale = "en_US.UTF-8")

# plotting graph to png image file - transparent background as in examples
png("plot3.png", width = 480, height = 480, bg = "transparent")
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
