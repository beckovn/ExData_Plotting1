library(sqldf)

# Reading the file into a data frame
df <- read.csv.sql("household_power_consumption.txt",
                    "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                    sep = ";")

# Date conversion
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

# Drawing plot1 and copying it to a .png file
hist(df$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power",
     col = "red")
dev.copy(png, file="plot1.png")
dev.off()