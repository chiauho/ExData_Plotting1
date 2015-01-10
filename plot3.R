#Create a plot of sub metering 1,2&3 against Date & Time
#Output to a png file - plot3.png
#plot3.R - By Chiau Ho ONG

print("Reading file .....")
#Borrow the following lines from Roger DPeng to speed things up ...
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep = ";")
classes <- sapply(tab5rows, class)
#Read first 100,000 lines will do since the date we want is within the first 100,000 lines
tab1000 <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = classes, comment.char="", nrows=100000)

print("Converting Date ....")
tab1000$Date <- as.Date(tab1000$Date,"%d/%m/%Y")

startdate <- as.Date(c("01/02/2007"),"%d/%m/%Y")
enddate <- as.Date(c("02/02/2007"),"%d/%m/%Y")

#Subset the data
tabsub <- subset(tab1000,Date==startdate | Date==enddate)

#Combine Date & Time and create a new column with combined value
tabsub$DateTime <- paste(tabsub$Date, tabsub$Time)
tabsub$DateTime <- strptime(tabsub$DateTime,format="%Y-%m-%d %H:%M:%S")

#Finally write output to png file
png(filename = "plot3.png",width=480,height=480)
with(tabsub,plot(DateTime, Sub_metering_1, type="n", xlab="",ylab="Energy sub metering"))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(tabsub,lines(DateTime, Sub_metering_1, col="black"))
with(tabsub,lines(DateTime, Sub_metering_2, col="red"))
with(tabsub,lines(DateTime, Sub_metering_3, col="blue"))

dev.off()
