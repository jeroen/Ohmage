#' Authenticate with an ohmage server
#' @param user ohmage username
#' @param password ohmage passwd
#' @param serverurl url to the ohmage server
#' @param ... extra parameters for oh.call
#' @return null
#' @author jeroen
#' @example examples/example.R
#' @export

oh.login <- function(user, password, serverurl, ...){
	if(!is.null(getOption("TOKEN"))){
		stop("Already logged in. Please logout first.");
	}	
	message("Trying to login to ", serverurl, " with username: ",user);
	mytoken <- oh.auth_token(user, password, serverurl, ...);

	options(SERVERURL = serverurl);
	options(TOKEN = mytoken);
	options(ohmage_username = user);
	
	return(mytoken);
}