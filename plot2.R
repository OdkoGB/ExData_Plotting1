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

## creat plot and saving into plot2.png file
png("plot2.png", width = 480, height = 480)
with(dataset2, plot(date_time, Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)"))
dev.off()

