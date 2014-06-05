## This script reads the Household power consumption data and plots a graph
## of energy sub metering measurements. It outputs the graph to a png file named plot3.png.
## To run the script, please set your working directory to where the script and the data are located.

if (!file.exists("household_power_consumption")) {
  if (!file.exists("exdata-data-household_power_consumption.zip")) {
    stop("was expecting exdata-data-household_power_consumption Dataset folder or zip file")
  } else {
    unzip("exdata-data-household_power_consumption.zip")
  }
}

## Subsetting and formatting date and time
df      <- read.table("household_power_consumption.txt", 
                      sep=";", header=TRUE, stringsAsFactors=FALSE)
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df      <-df[df$Date=="2007-02-01" | df$Date=="2007-02-02",]
df$DateTime <- paste(df$Date, df$Time, sep=" ")
df$DateTime <- strptime(df$DateTime, format="%Y-%m-%d %H:%M:%S")
df$Global_active_power <-as.numeric(df$Global_active_power)

## Plotting the graph using the base system
png(file="plot3.png", width=480, height=480)        ##open the a png device
plot(df$DateTime,df$Sub_metering_1, type="n",       ##instantiate a plot but dont plot
     ylab="Energy sub metering",
     xlab="")
lines(df$DateTime,df$Sub_metering_1, type="l")              #plot submetering 1
lines(df$DateTime,df$Sub_metering_2, type="l", col="red")   #plot submetering 2
lines(df$DateTime,df$Sub_metering_3, type="l", col="blue")  #plot submetering 3
legend("topright", col=c("black","red","blue"),             #add legend
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1))

dev.off()                                           #close the device
