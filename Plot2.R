
# Download
if(!file.exists("./data")){dir.create("./Data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("./data/exdata_data_household_power_consumption.zip"))
{download.file(fileUrl,  "./Data/exdata_data_household_power_consumption.zip", mode="wb") }

# Unzip the file

if(!file.exists("./Data/household_power_consumption.txt")){
  unzip("./Data/exdata_data_household_power_consumption.zip", files = NULL, exdir="./Data")
}

#Read the informtion from the file
powerconsumition <- read.table("./Data/household_power_consumption.txt", sep=";",  header=TRUE,colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'),na.strings="?")
#Transform to Date
powerconsumition$Date<-as.Date(powerconsumition$Date,"%d/%m/%Y")
#Take information form 2007/02/01 and 2007/02/02
PWCD <- powerconsumition[ powerconsumition$Date=="2007-02-01" | powerconsumition$Date=="2007-02-02", ] 





# Plot 2
par(mfrow=c(1,1))


datetime<-strptime(with(PWCD,paste(Date,Time, sep=" ")),format="%Y-%m-%d %H:%M:%S")

PWCD<-cbind(PWCD, datetime) #Add new column datetime to PWCD

with(PWCD ,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowats)") )

#Generate the file 
dev.copy(png, file="Plot2.png") 
#close the PNG device
dev.off()

