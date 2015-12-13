
library(lubridate)
library(data.table)
library(png)
data<-read.table('household_power_consumption.txt',header = T,sep=';',dec='.',stringsAsFactors = F,as.is = T
)

data$datetime<-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(dmy(data$Date))
data$Time<-hms(data$Time)

data<-subset(data,Date>='2007-02-01' & Date<='2007-02-02' )

for (i in 3:9){
  data[,i]<-as.numeric( data[,i])
}


##Plot 3
png(filename = 'plot3.png',width = 480, height = 480, units = "px")
plot(
  c(min(data$datetime),max(data$datetime))
  ,   c(
    min(
      min(data$Sub_metering_1),
      min(data$Sub_metering_2),
      min(data$Sub_metering_3)
    ) 
    ,
    max(
      max(data$Sub_metering_1),
      max(data$Sub_metering_2),
      max(data$Sub_metering_3)
    ) 
    
  )
  
  , type="n", xlab="" , ylab="Energy Sub Metering")


lines(data$datetime, data$Sub_metering_1, col="black", lwd=2)
lines(data$datetime, data$Sub_metering_2, col="red", lwd=2)
lines(data$datetime, data$Sub_metering_3, col="blue", lwd=2)
legend("topright"
       ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,horiz=FALSE
       ,col=c("black","red","blue")
       ,lty=c(1) 
       ,lwd=c(1)
)

dev.off()