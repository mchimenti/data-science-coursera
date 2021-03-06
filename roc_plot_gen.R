#Function to generate an ROC plot from a dataframe of unranked score, hit pairs
#This function takes a comma separated file with 2 columns (with headers), 
#first column is score (i.e, docking score) and second column is hit y/n (denoted as 1 or 0). 
#Michael Chimenti, April 2014

## check if required pracma package is present, if not, install it

checkPkgs <- function() {
        pkg.inst <- installed.packages()
        pkgs <- ("pracma")
        have.pkg <- pkgs %in% rownames(pkg.inst)
        
        if(any(!have.pkg)) {
                cat("Some packages need to be installed\n")
                r <- readline("Install necessary packages [y/n]? ")
                if(tolower(r) == "y") {
                        need <- pkgs[!have.pkg]
                        message("installing packages ",
                                paste(need, collapse = ", "))
                        install.packages(need)
                }
        }
}

## call checkpg first

checkPkgs()

## roc_plot_gen

roc_plot_gen <- function(file) {
        
        library(pracma)
        
        ## open the supplied file ##
        
        roc_table <- read.table(file, header = TRUE, sep = ",")
        
        ## test that the file has 2 columns ##
        
        if(ncol(roc_table) != 2){
                stop("Please input a CSV file with 2 columns!\n\n")
              
        }
        
        ## order by first column, i.e., "score" or "energy level" ##
        
        roc_sorted <- roc_table[order(roc_table[,1]),]
        
        ## calculate number of false and true negatives ##
        
        true_neg <- nrow(subset(roc_sorted, roc_sorted[,2]==0))
        cat("Number of true negatives = ", true_neg, "\n")
        
        false_neg <- nrow(subset(roc_sorted, roc_sorted[,2]==1))
        cat("Number of false negatives = ", false_neg, "\n")
        
        ## create and initialize true positive and true negative vectors ##
        
        true_pos_vec <- numeric(length = nrow(roc_sorted))
        
        false_pos_vec <- numeric(length = nrow(roc_sorted))
        
        ## 2 'for' loops to calculate true pos and true neg vectors (i.e., 'running count' of 1s and 0s) ##
        
        for(i in 1:nrow(roc_sorted)){
                if(roc_sorted[i,2] == 1) {
                        true_pos_vec[i+1] = true_pos_vec[i] + 1 
                }
                else{true_pos_vec[i+1] <- true_pos_vec[i]}
        }
        
        for(i in 1:nrow(roc_sorted)){
                if(roc_sorted[i,2] == 0) {
                        false_pos_vec[i+1] = false_pos_vec[i] + 1 
                }
                else{false_pos_vec[i+1] <- false_pos_vec[i]}
        }
        
        #remove the leading "0" from vectors to get correct length vectors
        
        true_pos_vec <- true_pos_vec[-1]
        false_pos_vec <- false_pos_vec[-1]
        
        ## initialize true_pos_rate and false_pos_rate vectors ##
        
        true_pos_rate <- numeric(length = nrow(roc_sorted))
        
        false_pos_rate <- numeric(length = nrow(roc_sorted))
        
        ## calculate true positive rate and false positive rate ("1-sp") ##
        ## true pos rate = true_pos_vec / #false neg ##
        ## false pos rate = false_pos_vec / #true neg ##
         
        true_pos_rate <- lapply(true_pos_vec, function(true_pos_vec){true_pos_vec/false_neg})
       
        false_pos_rate <- lapply(false_pos_vec, function(false_pos_vec){false_pos_vec/true_neg})

        ## calculate AUC using "trapz" function from library "pracma" ##
        
        auc <- trapz(as.numeric(false_pos_rate), as.numeric(true_pos_rate))
        
        ## force rounding to 2 digits
        
        auc_r <- round(auc, digits=2)
        
        ## output AUC value
        
        cat("AUC is equal to:", auc_r)
        
        ## Do the ROC PLOT; True Pos rate as function of False Pos rate ##
        
        plot(y= true_pos_rate, x= false_pos_rate, type='l', xlab='False positive rate', ylab='True positive rate', main=paste('ROC Analysis; AUC =', auc_r), cex.lab=1.65, cex.axis=1.5, lwd=5, xaxs='i', yaxs='i', ylim=c(0,1), mgp=c(2.5,1,0))
        
        abline(0,1)
       
        
        
}


