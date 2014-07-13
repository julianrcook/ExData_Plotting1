library(sqldf)
hpcfile<-"household_power_consumption.txt"
hpcsql<-"SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
hpc2007 <- read.csv.sql(hpcfile, hpcsql, header=T, sep=";", comment.char="")

#Create datetime column
hpc2007 <- within(hpc2007, Datetime <- as.POSIXlt(paste(Date, Time),format="%d/%m/%Y %H:%M:%S") )
#Open for png
png("plot2.png", width=480, height=480, units="px")
#plot2
par(mfrow=c(1,1))

xrange = hpc2007$Datetime
yrange = hpc2007$Global_active_power
#plot2
plot(xrange,yrange, ylab="Global Active Power (kilowatts)",xlab="",pch="")
lines(xrange,yrange, ylab="Global Active Power (kilowatts)",type='l')
dev.off()