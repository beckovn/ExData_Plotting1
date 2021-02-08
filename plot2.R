library(sqldf)
library(lubridate)

# Reading the file into a data frame
df <- read.csv.sql("household_power_consumption.txt",
                    "select * from file where Date = '1/2/2007'
                         or Date = '2/2/2007'",
                    sep = ";",
                   header = TRUE)

# Date conversion
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$DateTime <- with(df, ymd(Date)+hms(Time))

# Drawing plot2 and copying it to a .png file
png(filename = "plot2.png", width = 480, height = 480,
    units = "px")
plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()