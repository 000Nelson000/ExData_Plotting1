
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

##Plot 4
png(filename = 'plot4.png',width = 480, height = 480, units = "px")

par(mfrow = c(2, 2), mar = c(5, 4, 2, 1))
with(data, plot(datetime, Global_active_power, main = "",xlab ="",ylab="Global Active power",type = "l"))
with(data, plot(datetime, Voltage, main = "",xlab ="",ylab="Voltage",type="l"))


######################3
with(data,
     {
       plot(
         c(min(datetime),max(datetime))
         ,   c(
           min(
             min(Sub_metering_1),
             min(Sub_metering_2),
             min(Sub_metering_3)
           ) 
           ,
           max(
             max(Sub_metering_1),
             max(Sub_metering_2),
             max(Sub_metering_3)
           )   )
         , type="n", xlab="" , ylab="Energy Sub Metering")
       lines(datetime, Sub_metering_1, col="black", lwd=2)
       lines(datetime, Sub_metering_2, col="red", lwd=2)
       lines(datetime, Sub_metering_3, col="blue", lwd=2)
       legend("topright"
              ,inset=.05
              ,cex = 1
              ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
              ,horiz=FALSE
              ,col=c("black","red","blue")
              ,lty=c(1) 
              ,lwd=c(1)
              , bty="n"
              #,text.font =1
       )
     }
)

with(data, plot(datetime, Global_reactive_power, main = "",xlab ="",ylab="Global Reactive power",type="l"))

dev.off()