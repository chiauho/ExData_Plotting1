#Create a plot of household power consumption against Date & Time
#Output to a png file - plot2.png
#plot2.R - By Chiau Ho ONG

print("Reading file .....")
#Borrow the following lines from Roger DPeng to speed things up...
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
png(filename = "plot2.png",width=480,height=480)
with(tabsub,plot(DateTime, Global_active_power, type="n", xlab="",ylab="Global Active Power (kilowatts)"))
with(tabsub,lines(DateTime, Global_active_power))
dev.off()
