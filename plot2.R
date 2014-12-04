## Electric power consumption: Global Active Power through time
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

# subseting only data for required dates
df <- subset(df.all, df.all$Date >= as.Date('2007-02-01') & df.all$Date <= as.Date('2007-02-02'))

# setting locale to en_US for proper day in a week labels
locale_original <- Sys.getlocale( category = "LC_TIME" )
Sys.setlocale( category = "LC_TIME", locale = "en_US.UTF-8")

# plotting histogram to png image file
png("plot2.png", width = 504, height = 504)
plot(x = df$DateTime, y = df$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "" )
dev.off()

# restoring original locale
Sys.setlocale( category = "LC_TIME", locale = locale_original )
