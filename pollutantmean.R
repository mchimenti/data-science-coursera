pollutantmean <- function(directory, pollutant, id = 1:332) {
      
        #get the current directory, store for later
        current <- getwd()
       
        #get full list of files in user supplied directory
        all_mons <- list.files(directory)
        
        #change into user supplied directory
        setwd(paste(current,"/",directory,sep=""))
        
        #create list of dataframes from csv files, sliced full list by "id" 
        mon_datafr_list <- lapply(all_mons[id], read.csv)
        
        #"rbind" all dataframes together into one big one
        all_data <- do.call("rbind", mon_datafr_list)
        
        #return mean of user specified column
        poll_mean <- mean(all_data[,pollutant], na.rm=TRUE)
        
        #return to parent directory
        setwd("/Users/sandro/coursera/coursera_repo")
        
        print(poll_mean)
}