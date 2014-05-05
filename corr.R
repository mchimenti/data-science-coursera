corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        
        setwd("~/coursera/coursera_repo")
        
        ##get current directory
        
        current <- getwd()
        
        ## generate list of files in user-supplied directory
        
        all_mons <- list.files(directory)
        
        ## init list used in loop
        
        threshold_list <- list()
        
        ## read into dataframe all csv files one at a time in the loop
        
        for(i in 1:length(all_mons)){
                new_csv <- read.csv(paste(current,"/",directory, "/", all_mons[i], sep=""), header=TRUE)
                
                ## test for threshold complete cases at each csv file across cols 2 and 3 
                
                if(sum(complete.cases(new_csv[,2:3])) > threshold){
                        
                        #keep file number in list if test is met
                        
                        threshold_list <- c(threshold_list, i)
                }
        }
        
        ## turn the list of monitors into a vector for looping
        
        thresh_vec <- as.numeric(threshold_list)
        
        ## check to see if any files met threshold test, if not, exit with message
        
        if(length(thresh_vec) == 0){
                print("no data files meet your threshold, please try a lower threshold value")
                return(thresh_vec)
        }
        
        ## loop over the threshold vector, read each csv, compute the corr and store the result
        
        corrs <- numeric()
        
        for(i in 1:length(thresh_vec)){
                csv <- read.csv(paste(current,"/",directory, "/", all_mons[thresh_vec[i]], sep=""), header=TRUE)
                cor_matrix <- cor(csv[,c(2,3)], use="pairwise", method="pearson")
                corrs <- c(corrs, cor_matrix[2,1])
        
        }
        return(corrs)
}