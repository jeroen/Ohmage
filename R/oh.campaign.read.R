# TODO: Add comment
# 
# Author: jeroen
###############################################################################


oh.campaign.read <- function(output_format="short", to.data.frame=TRUE, ...){
	xhr <- oh.call("/campaign/read", output_format=output_format, ...);
	if(output_format=="xml"){
		xhr$data$xmlTree <- xmlTreeParse(xhr$data$configuration, useInternalNodes=T);
	}
	
	if(!to.data.frame){
		return(xhr);
	}
	
	if(output_format=="short"){
		#unlist some stuff
		for(i in 1:length(xhr$data)){
			xhr$data[[i]] <- unlist(lapply(xhr$data[[i]][-1], unlist)); #note that the [-1] excludes the user role list.
		}
		
		mydataframe <- as.data.frame(do.call(rbind, xhr$data));
		mydataframe$UUID <- row.names(mydataframe);
		#row.names(mydataframe) <- NULL;
		return(mydataframe);
	}
	
	if(output_format=="long"){
		#unlist some stuff
		for(i in 1:length(xhr$data)){
			xhr$data[[i]]$classes <- unlist(xhr$data[[i]]$classes);
			xhr$data[[i]]$user_role_campaign <- lapply(xhr$data[[i]]$user_role_campaign, unlist)
			xhr$data[[i]]$user_roles <- unlist(xhr$data[[i]]$user_roles);
		}
		
		xhr$metadata$items <- unlist(xhr$metadata$items);
	}	
	
	return(xhr)
}

