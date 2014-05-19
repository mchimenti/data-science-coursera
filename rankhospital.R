rankhospital <- function(state, outcome, num){
        
        ## read the file into a data frame; coerce all cols to be character vectors, deal with NAs in cols of interest
        all_data <- read.table("outcome-of-care-measures.csv", header=TRUE, sep = ",", na.strings="Not Available", colClasses="character")
        all_data[,c(11,17,23)] <- lapply(all_data[,c(11,17,23)], as.numeric)
        
        ## create a vector with viable column titles to compare against
        outcomes <- c('heart attack', 'heart failure', 'pneumonia')
        
        ## check the state input against the data frame state column values using the %in% method
        if(state %in% all_data[,7] == TRUE){print("STATE OK")}
        
        else {stop("Invalid State ID")}
        
        ## check the outcome input against the titles vector
        if(outcome %in% outcomes == TRUE){print("OUTCOME OK")}
        
        else {stop("Invalid Outcome ID")}
        
        ## split the data frame by state
        all_state_data <- split(all_data, all_data$State)
        
        state_data <- all_state_data[[state]]
        
        if(outcome == "heart attack"){
                ordered_data <- state_data[order(state_data[,11]),]
                print(ordered_data[num,c(2,11)])
        }
        
}