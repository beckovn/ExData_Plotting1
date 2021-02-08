library(sqldf)
library(lubridate)

# Reading the file into a data frame
df <- read.csv.sql("household_power_consumption.txt",
                   "select * from file where Date = '1/2/2007'
                         or Date = '2/2/2007'",
                   sep = ";",
                   header = TRUE)

# Converting to class Date
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Joining Date and Time in a single column
df$DateTime <- with(df, ymd(df$Date) + hms(df$Time))

# Drawing plot3.png and putting it in a file
png("plot3.png", width = 480, height = 480, units = "px")
matplot(df$DateTime, cbind(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3),
        type="l", xlab = "", ylab = "Energy sub metering", col = c("black", "red", "blue"),
        lty=1)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)
dev.off()