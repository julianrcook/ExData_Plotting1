library(sqldf)
hpcfile<-"household_power_consumption.txt"
hpcsql<-"SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
hpc2007 <- read.csv.sql(hpcfile, hpcsql, header=T, sep=";", comment.char="")
hpc2007[ hpc2007$sub_metering_1 == "?" ] = NA
hpc2007[ hpc2007$sub_metering_2 == "?" ] = NA
hpc2007[ hpc2007$sub_metering_3 == "?" ] = NA
#Create datetime column
hpc2007 <- within(hpc2007, Datetime <- as.POSIXlt(paste(Date, Time),format="%d/%m/%Y %H:%M:%S") )

#Open for pNG
png("plot4.png", width=480, height=480, units="px")
## 4-panel lpot
par(mfrow=c(2,2))
# 1st plot element
yrange = hpc2007$Global_active_power
plot(xrange,yrange, ylab="Global Active Power",xlab="",pch="")
lines(xrange,yrange, ylab="Global Active Power",type='l')
# 2nd element of plt4
yrange<-hpc2007[,5]
plot(xrange,yrange, ,ylab="voltage",xlab="datetime",pch="")
lines(xrange,yrange, ylab="voltage",type='l',col="black")
# 3rd element
yrange1<-hpc2007[,7]
yrange2<-hpc2007[,8]
yrange3<-hpc2007[,9]
plot(xrange,yrange1, ylab="Energy sub metering",xlab="",pch="")
lines(xrange,yrange1, ylab="Energy sub metering",type='l',col="black")
lines(xrange,yrange2, ylab="Energy sub metering",type='l',col="red")
lines(xrange,yrange3, ylab="Energy sub metering",type='l',col="blue")
#legend("topright",pch=1,legend=c("sub_metering_1","sub_metering_2","sub_metering_2"))
legend("topright", col = c("black", "red", "blue"), lty= "solid", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
# 4th element of plt4
yrange<-hpc2007[,4]
plot(xrange,yrange, ,ylab="Global_reactive_power",xlab="datetime",pch="")
lines(xrange,yrange, ylab="Global_reactive_power",type='l',col="black")

par(mfrow=c(2,2))
# close
dev.off()