#' Read Mobility data
#' 
#' @param date date in ISO format
#' @param username name of user to query (only works when server allows to see others data). 
#' @param ... stuff passed to oh.call
#' @return a dataframe with mobility data
#' @export
oh.mobility.read <- function(date = today(), username=getOption("ohmage_username"), with_sensor_data=TRUE, ...){
	if(is.character(date) && nchar(date) != "10"){
		stop("Date has to be in format YYYY-mm-dd");
	} 
	if("Date" %in% class(date)){
		date <- as.character(date);
	}
	if("POSIXt" %in% class(date)){
		date <- as.character(as.Date(date));
	}
	xhr <- oh.call("/mobility/read", date=date, username=username, with_sensor_data=with_sensor_data, ...);		
	
	output <- as.data.frame(do.call("rbind",lapply(lapply(lapply(xhr$data, "[[", "l"), parsevector), unlist)), stringsAsFactors=FALSE);
	output$id <- unlist(lapply(xhr$data, "[[", "id"));
	output$t <- structure(as.numeric(unlist(lapply(xhr$data, "[[", "t")))/1000, class=class(Sys.time()));
	output$lo <- as.numeric(output$lo);
	output$la <- as.numeric(output$la);
	
	#sort
	output <- output[order(output$t),];
	return(output);
}
