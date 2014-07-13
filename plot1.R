library(sqldf)
hpcfile<-"household_power_consumption.txt"
hpcsql<-"SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
hpc2007 <- read.csv.sql(hpcfile, hpcsql, header=T, sep=";", comment.char="")

#..Create datetime column later
#Open for png
png("plot1.png", width=480, height=480, units="px")
#plot1
par(mfrow=c(1,1))

hist(hpc2007[,3],col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()