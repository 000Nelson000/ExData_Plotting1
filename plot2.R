
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


##Plot 2
Sys.setlocale("LC_TIME","English")
png(filename = 'plot2.png',width = 480, height = 480, units = "px")
plot(data$datetime,data$Global_active_power,type ="l",xlab = "",ylab = "Global Active Power(Kilowatts)" )
dev.off()
