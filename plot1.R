## Getting the data
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL, "Dataset.zip")
unzip("Dataset.zip")
dir()

DT <- read.table(".//household_power_consumption.txt", 
                 sep = ";", header = TRUE, na.strings = "?")

# Subsetting dates 2007-02-01 and 2007-02-02. 
DTsub <- DT %>% 
  filter(Date %in% c("1/2/2007","2/2/2007"))

# Checking data structure
str(DT)


# Converting character vectors to date/time and numeric vectors
DTsub$Date <- as.Date(DTsub$Date, "%d/%m/%Y") 
DTsub$Time <- strptime(DTsub$Time, format ="%H:%M:%S") 
DTsub$Time <- format(DTsub$Time, format ="%H:%M:%S") 

DTsub[, 3:8] <- lapply(DTsub[, 3:8], as.numeric)


# Create a histogram
hist(DTsub$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = paste("Global active power"))


# Save my results as a png
dev.copy(png, file="plot1.png")
dev.off()