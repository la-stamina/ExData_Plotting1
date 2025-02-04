## Getting the data
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, "Dataset.zip")
unzip("Dataset.zip")
dir()

DT <- read.table(".//household_power_consumption.txt", 
                 sep = ";", header = TRUE)

# Subsetting dates 2007-02-01 and 2007-02-02. 
DTsub <- DT %>% 
  filter(Date %in% c("1/2/2007","2/2/2007"))

# Checking data structure
str(DT)


# Converting character vectors to date/time and numeric vectors
DTsub[, 3:8] <- lapply(DTsub[, 3:8], as.numeric)

DTsub$Date <- as.Date(DTsub$Date, format="%d/%m/%Y")
DTsub$Time <- strptime(DTsub$Time, format="%H:%M:%S")
DTsub[1:1440,"Time"] <- format(DTsub[1:1440,"Time"],"2007-02-01 %H:%M:%S")
DTsub[1441:2880,"Time"] <- format(DTsub[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


time_positions <- seq(min(DTsub$Time), max(DTsub$Time), length.out = 3)

# Create a plot
plot(DTsub$Time, DTsub$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xaxt = "n",
     xlab = "")
lines(DTsub$Time, DTsub$Sub_metering_2, type = "l", col = "red")
lines(DTsub$Time, DTsub$Sub_metering_3, type = "l", col = "blue")
axis(1, at = time_positions, labels = c("Thu", "Fri", "Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)



# Save my results as a png
dev.copy(png, file="plot3.png")
dev.off()