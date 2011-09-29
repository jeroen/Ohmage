# TODO: Add comment
# 
# Author: jeroen
###############################################################################


parse.date <- function(obj){
	varname <- names(obj);
	values <- sapply(obj[[1]]$values, parsevector);
	
	return(as.POSIXct(strptime(values, format="%Y-%m-%d %H:%M:%S")));
}
