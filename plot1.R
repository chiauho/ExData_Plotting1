#Create a histogram of household power consumption
#Output to a png file
#plot1.R - By Chiau Ho ONG

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

#Subset data
tabsub <- subset(tab1000,Date==startdate | Date==enddate)

#Finally write hist to file
png(filename = "plot1.png",width=480,height=480)
hist(tabsub$Global_active_power,main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylim=c(0,1200), col="red")

dev.off()

