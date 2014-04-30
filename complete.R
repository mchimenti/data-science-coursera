complete <- function(directory, id = 1:332) {
        
        ## get current directory
        
        current <- getwd()
        
        ## get full list of files in user supplied directory
        
        all_mons <- list.files(directory)
        
        ## change into user specified directory
        
        setwd(paste(current,"/",directory,sep=""))
        
        ## open and read "id" monitors into simplified data matrix with sapply
        
        mon_id_matrix <- sapply(all_mons[id], read.csv, simplify=TRUE, USE.NAMES=TRUE)
        
        ## initialize nobs vector to be length of "id"
        
        nobs <- numeric(length = length(id))
        
        ## for loop that subsets matrix on 'sulfate' and 'nitrate' rows and index column
        ## using length of id as the index of the loop
        ## then gets complete.cases and counts the "sum" of the TRUES (1s) and returns value into nobs[i]
        
        for(i in 1:length(id)){
                nobs[i] <- sum(complete.cases(mon_id_matrix[c("sulfate","nitrate"), i]))
        }
        
        ## create a dataframe with "id" and "nobs" to read off results
        
        results <- data.frame(id, nobs)
        
        ## reset working directory
        
        setwd("/Users/sandro/coursera/coursera_repo")
        
        ## return the dataframe
        
        return(results)
        
        
}
