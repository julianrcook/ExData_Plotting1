library(sqldf)
hpcfile<-"household_power_consumption.txt"
hpcsql<-"SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
hpc2007 <- read.csv.sql(hpcfile, hpcsql, header=T, sep=";", comment.char="")
hpc2007[ hpc2007$sub_metering_1 == "?" ] = NA
hpc2007[ hpc2007$sub_metering_2 == "?" ] = NA
hpc2007[ hpc2007$sub_metering_3 == "?" ] = NA
#Create datetime column
hpc2007 <- within(hpc2007, Datetime <- as.POSIXlt(paste(Date, Time),format="%d/%m/%Y %H:%M:%S") )
#Open for png
png("plot3.png", width=480, height=480, units="px")

par(mfrow=c(1,1))
xrange = hpc2007$Datetime

#plot3
yrange1<-hpc2007[,7]
yrange2<-hpc2007[,8]
yrange3<-hpc2007[,9]
plot(xrange,yrange1, ylab="Energy sub metering",xlab="",pch="")
lines(xrange,yrange1, ylab="Energy sub metering",type='l',col="black")
lines(xrange,yrange2, ylab="Energy sub metering",type='l',col="red")
lines(xrange,yrange3, ylab="Energy sub metering",type='l',col="blue")
# Legend TopR
legend("topright", col = c("black", "red", "blue"), lty= "solid", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
dev.off()