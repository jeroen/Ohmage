oh.login <- function(user, password, serverurl, ...){
	if(!is.null(Ohmage::TOKEN)){
		stop("Already logged in. Please logout first.");
	}	
	message("Trying to login to ", serverurl, " with username: ",user);
	mytoken <- oh.auth_token(user, password, serverurl, ...);

	assign("SERVERURL", serverurl, "package:Ohmage");	
	assign("TOKEN",mytoken,"package:Ohmage");
}