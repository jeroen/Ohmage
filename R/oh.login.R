oh.login <- function(user, password, server, ...){
	if(!is.null(Ohmage::TOKEN)){
		stop("Already logged in. Please logout first.");
	}	
	message("Trying to login to ", server, " with username: ",user);
	assign("SERVERURL", server, "package:Ohmage");
	oh.auth_token(user, password, ...);
}