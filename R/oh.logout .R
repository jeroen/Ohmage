# TODO: Add comment
# 
# Author: jeroen
###############################################################################

oh.logout <- function(){
	if(is.null(Ohmage::TOKEN)){
		stop("Not logged in.");
	}
	assign("TOKEN", NULL, "package:Ohmage");
	assign("SERVERURL", NULL, "package:Ohmage");
	message("Logged out.\n")
}

