## EDA course assignment 1

#Plot 1

hpc <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880, 
                  sep = ";", na.strings="?", 
                  col.names = colnames(read.table("household_power_consumption.txt",
                  nrow = 1, header = TRUE, sep=";"))) 

hpc[,1] <- as.Date(hpc[,1], format="%d/%m/%Y")


hist(hpc$Global_active_power, col ="orange", xlab = "Global Active Power (kWatts)", main="GLOBAL ACTIVE POWER")
dev.copy(png, file = "Global_Active_Power.png")
dev.off()

