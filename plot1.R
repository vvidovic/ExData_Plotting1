## Electric power consumption: histogram of measurements of Global Active Power
#  (2007-02-01 and 2007-02-02)

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

# plotting histogram to png image file - transparent background as in examples
png("plot1.png", width = 480, height = 480, bg = "transparent")
hist(df$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

