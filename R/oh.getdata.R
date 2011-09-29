# TODO: Add comment
# 
# Author: jeroen
###############################################################################


oh.getdata <- function(serverurl, token, ...){
	
	if(is.null(token) | is.null(serverurl)){
		stop("Need to supply both server and valid token.");
	}
	
	assign("SERVERURL", serverurl, "package:Ohmage");
	assign("TOKEN", token, "package:Ohmage");
	
	#remainig arguments should contain read data.
	mydata <- oh.survey_response.read(...);	
	return(mydata);
}
