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

#paste date and time together into new column and convert to posixCT

hpc[,10] <- paste(hpc[,1], hpc[,2])
hpc[,10] <- as.POSIXct(hpc[,10])

#rename col 10 as "posixct"

names(hpc)[names(hpc) == 'V10'] <- "posixct"
str(hpc)

#do the plots in a 2x2 matrix, left to right, top to bottom

par(mfrow = c(2,2))

with(hpc, plot(posixct, Global_active_power, type='l', ylab="Global Active Power", xlab="Datetime"))

with(hpc, plot(posixct, Voltage, type='l', ylab="Voltage", xlab="Datetime"))

with(hpc, plot(posixct, Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab=""))
with(hpc, {
        lines(posixct, Sub_metering_2, col="red")
        lines(posixct, Sub_metering_3, col="blue")
})

with(hpc, plot(posixct, Global_reactive_power, type='l', ylab="Global Reactive Power", xlab="Datetime"))

#save the plot as PNG

dev.copy(png, file = "Quad_panel_plot4.png")
dev.off()