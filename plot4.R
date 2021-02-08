library(sqldf)
library(lubridate)

# Loading data into a data frame
df<-read.csv.sql("household_power_consumption.txt",
             "select * from file
              where Date in ('1/2/2007', '2/2/2007')",
             header = TRUE,
             sep = ";")

# Converting Date values to Date class
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# creating a column with united Date and Time
df$DateTime <- with(df, ymd(df$Date)+hms(df$Time))

# Drawing 4 miniplots by row
png("plot4.png")
par(mfrow = c(2,2))

# plot1
plot(df$DateTime, df$Global_active_power,
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# plot2
plot(df$DateTime, df$Voltage,
     type = "l", xlab = "datetime", ylab = "Voltage")

#plot3
matplot(df$DateTime, cbind(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3),
        type="l", xlab = "", ylab = "Energy sub metering", col = c("black", "red", "blue"),
        lty=1)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

# plot4
matplot(df$DateTime, df$Global_reactive_power, type="l", xlab = "datetime",
        ylab = "Global_reactive_power", lty = 1)
dev.off()