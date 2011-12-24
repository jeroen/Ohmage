# TODO: Add comment
# 
# Author: jeroen
###############################################################################


#' Depricated wrapper for oh.survey_response.read
#' @param serverurl url of server 
#' @param token token
#' @param ... other args
#' @export
oh.getdata <- function(serverurl, token, ...){
	
	if(is.null(token) | is.null(serverurl)){
		stop("Need to supply both server and valid token.");
	}
	
	options(SERVERURL = serverurl)
	options(TOKEN=token)
	
	#remainig arguments should contain read data.
	mydata <- oh.survey_response.read(...);	
	return(mydata);
}
