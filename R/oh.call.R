# Author: jeroen
###############################################################################

oh.call <- function(xpath, serverurl=SERVERURL, token=TOKEN, responseformat="json", verbose=FALSE, ...){
	if(verbose){
		print(match.call());
	}
	
	if(is.null(serverurl)){
		stop("Serverurl is missing. Either use oh.login() or specify 'serverurl' and 'token' arguments in plot call.")
	}
	
	posturl <- paste(serverurl, xpath, sep="");
	
	curl = getCurlHandle()
	h = dynCurlReader(curl, binary = TRUE)
	
	#some calls don't need a token (e.g. /auth_token)
	if(!is.null(token)){
		response <- postForm(curl = curl, uri=posturl, .opts = list(ssl.verifyhost= FALSE, ssl.verifypeer=FALSE, headerfunction = h$update, verbose = verbose, connecttimeout=10), client=CLIENTNAME, style="post", binary=TRUE, auth_token=token, ...);	  		
	} else {
		response <- postForm(curl = curl, uri=posturl, .opts = list(ssl.verifyhost= FALSE, ssl.verifypeer=FALSE, headerfunction = h$update, verbose = verbose, connecttimeout=10), client=CLIENTNAME, style="post", binary=TRUE, ...);		
	}

	#parse response
	headers <- parseHTTPHeader(h$header());
	httpstatus <- headers[["status"]];
	response <- h$value();
	
	if(verbose) cat("HTTP", httpstatus, "\n");

	if(httpstatus != 200){
		if(is.raw(response)){
			stop("Ohmage error: HTTP ", httpstatus, ".\n", rawToChar(response), "\n");	
		} else {
			stop("Tomcat error: HTTP ", httpstatus, ".\n", response, "\n");
		}
	}
	
	#this should never happen:
	if(length(response)==0){
		stop("server returned no content (check tomcat error log).");
	}
	
	if(!is.raw(response)){
		stop(response);
	}

	if(verbose){
		cat(rawToChar(response),"\n\n");
	}	
	
	if(responseformat == "file"){

		if(length(response) < 1000){
			warning("File less than 1KB: ", rawToChar(response));
		}

		tf <- tempfile(pattern="image", tmpdir="/tmp");
		if(file.create(tf)){
			con <- file(tf,"wb");
		} else {
			stop("Could not create temporary file.")
		}
		writeBin(as.vector(response), con);
		close(con);

		attr(tf,"Content-Type") <- attr(response,"Content-Type");
		return(tf);		
	}
	
	xhr <- fromJSON(rawToChar(response), simplifyWithNames=FALSE);
	
	if(xhr$result == "success"){
		return(xhr)
	} else {
		stop(xhr$errors[[1]]$text);
	}
}
