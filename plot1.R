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

## create plot and saving into plot1.png file
png("plot1.png", width = 480, height = 480)
with(dataset2, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()
