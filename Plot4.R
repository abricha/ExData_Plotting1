## This script reads the Household power consumption data and plots 4 graphs.
## One graph for the global active power consumption, one for the voltage consumption,
## one for the energy submeterings, and finally one for the global reactive power consumption
## It outputs the graph to a png file named plot4.png.
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


png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
##Plot the Global Active Power
plot(df$DateTime,df$Global_active_power, type="n",
     ylab="Global Active Power",
     xlab="datetime")
lines(df$DateTime,df$Global_active_power, type="l")

##Plot the Voltage
plot(df$DateTime,df$Voltage, type="n",
     ylab="Voltage",
     xlab="datetime")
lines(df$DateTime,df$Voltage, type="l")

##Plot the Energy sub metering
plot(df$DateTime,df$Sub_metering_1, type="n",       ##instantiate a plot but dont plot
     ylab="Energy sub metering",
     xlab="datetime")
lines(df$DateTime,df$Sub_metering_1, type="l")              #plot submetering 1
lines(df$DateTime,df$Sub_metering_2, type="l", col="red")   #plot submetering 2
lines(df$DateTime,df$Sub_metering_3, type="l", col="blue")  #plot submetering 3
legend("topright", col=c("black","red","blue"),             #add legend
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1))

##Plot the Global reactive power
plot(df$DateTime,df$Global_reactive_power, type="n",
     ylab="Global reactive power",
     xlab="datetime")
lines(df$DateTime,df$Global_reactive_power, type="l")

##close the png device
dev.off()
