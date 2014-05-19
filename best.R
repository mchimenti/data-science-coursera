## best takes args state, outcome

best <- function(state, outcome){
        
        ## read the file into a data frame; coerce all cols to be character vectors, 
        ##deal with NAs in cols of interest
        all_data <- read.table("outcome-of-care-measures.csv", header=TRUE, sep = ",", na.strings="Not Available", colClasses="character")
        
        ##convert columns with numbers of interest to numerics
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
        
        ## collect the dataframe from the state of interest
        state_data <- all_state_data[[state]]
        
        ## return the hospital name in the first row of the selected state
        if(outcome == "heart attack"){
                ordered_data <- state_data[order(state_data[,11]),]
                 print(ordered_data[1:5,c(2,11)])
        }
         
        if(outcome == "heart failure"){
                 ordered_data <- state_data[order(state_data[,17]),]
                  print(ordered_data[1:5,c(2,17)])               
        }
         
        if(outcome == "pneumonia"){
                 ordered_data <- state_data[order(state_data[,23]),]
                  print(ordered_data[1:5,c(2,23)])
        }
}