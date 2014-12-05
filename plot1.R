## Electric power consumption: histogram of measurements of Global Active Power
#  (2007-02-01 and 2007-02-02)

# Reading dataset form csv file (if it doesn't exists allready)
if(!exists("df.all")) {
    df.all <- read.csv("../data//household_power_consumption.txt", sep = ";")
}

# Transforming strings in Date column to dates
df.all$Date <- as.Date(df.all$Date, format = "%d/%m/%Y")

# Transforming numeric values from levels
df.all$Global_active_power <- as.numeric(as.character(df.all$Global_active_power))

# subseting only data for required dates
df <- subset(df.all,
             df.all$Date >= as.Date('2007-02-01') & df.all$Date <= as.Date('2007-02-02'))

# plotting histogram to png image file
png("plot1.png", width = 504, height = 504)
hist(df$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

