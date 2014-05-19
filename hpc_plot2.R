#Plot 2

## read full table starting only at line 66638, read only 2880 lines (2 days worth)
## na.strings converts any ? to NAs; col.names are gathered from line 1

hpc <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880, 
                  sep = ";", na.strings="?", 
                  col.names = colnames(read.table("household_power_consumption.txt",
                  nrow = 1, header = TRUE, sep=";"))) 

#convert date from factor to date format
hpc[,1] <- as.Date(hpc[,1], format="%d/%m/%Y")

#convert power measurements to numeric
for(i in 3:9){
        hpc[,i] <- as.numeric(hpc[,i])
}

#convert time to character
hpc[,2] <- as.character(hpc[,2])

#paste date and time together and convert to posixCT

hpc[,10] <- paste(hpc[,1], hpc[,2])
hpc[,10] <- as.POSIXct(hpc[,10])
names(hpc)[names(hpc) == 'V10'] <- "posixct"
str(hpc)
#do the plot
with(hpc, plot(posixct, Global_active_power, type='l', ylab="Global Active Power", xlab="Day"))
dev.copy(png, file = "Global_Active_Power_Plot2.png")
dev.off()