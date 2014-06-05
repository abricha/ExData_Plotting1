## This script reads the Household power consumption data and plots a graph
## of global active power in kilowats.It outputs the graph to a png file named plot2.png.
## To run the script, please set your working directory to where the script and the data are located.

if (!file.exists("household_power_consumption")) {
  if (!file.exists("exdata-data-household_power_consumption.zip")) {
    stop("was expecting exdata-data-household_power_consumption Dataset folder or zip file")
  } else {
    unzip("data/exdata-data-household_power_consumption.zip")
  }
}

## Subsetting and formatting date and time
df      <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df      <-df[df$Date=="2007-02-01" | df$Date=="2007-02-02",]
df$DateTime <- paste(df$Date, df$Time, sep=" ")
df$DateTime <- strptime(df$DateTime, format="%Y-%m-%d %H:%M:%S")
df$Global_active_power <-as.numeric(df$Global_active_power)

## Plotting the graph using the base system
png(file="plot2.png", width=480, height=480)
plot(df$DateTime,df$Global_active_power, type="n",
     ylab="Global Active Power (kilowatts)",
     xlab="")
lines(df$DateTime,df$Global_active_power, type="l")

dev.off()
