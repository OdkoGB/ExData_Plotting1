## Read in data:
if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./data/dataset.zip")
unzip("./data/dataset.zip", exdir = "./data")
dataset <- read.table(file = "./data/household_power_consumption.txt", header = TRUE, sep = ";")

## subsetting 2007-02-01 and 2007-02-02
dataset2 <- subset(dataset, Date == "1/2/2007" | Date ==  "2/2/2007")

## converting columns 3 to 9 to numeric values
cols <- names(dataset2)[3:9] 
dataset2[cols] <- lapply(dataset2[cols], as.numeric)

## creating date_time column
dataset2$date_time <- as.POSIXct(paste(dataset2$Date, dataset2$Time), format = "%d/%m/%Y %H:%M:%S")

## gathering submetering 1, 2, 3 into one variable-column
library(tidyr)
dataset3 <- dataset2 %>% gather(metering_type, sub_metering, Sub_metering_1:Sub_metering_3) 
dataset3$metering_type <- as.factor(dataset3$metering_type)

## creating the plot and saving into plot3.png file
png("plot3.png", width = 480, height = 480)
with(dataset3, plot(date_time, sub_metering, type = "n", xlab = NA, ylab = "Energy sub metering"))
with(subset(dataset3, metering_type == "Sub_metering_1"), lines(date_time, sub_metering, type = "l", col = "black"))
with(subset(dataset3, metering_type == "Sub_metering_2"), lines(date_time, sub_metering, type = "l", col = "red"))
with(subset(dataset3, metering_type == "Sub_metering_3"), lines(date_time, sub_metering, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
dev.off()

