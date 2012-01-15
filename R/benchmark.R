## TODO: Add comment
## 
## Author: jeroen
################################################################################
#
#
#benchmark <- function(campaign.prefix = "urn:campaign:loadtest:jeroen", prompt_id_list="urn:ohmage:special:all", ...){
#	
#	campaigndata <- oh.campaign.read();
#	allcampaigns <- grep(campaign.prefix, campaigndata$UUID, value=T);
#	
#	if(length(allcampaigns)==0){
#		stop("No campaigns found this this prefix. Use oh.campaign.read to get a list of campaigns.")
#	}
#	
#	allsizes <- sort(as.numeric(sapply(strsplit(allcampaigns, ":"), tail, 1)));
#	
#	mydf <- data.frame(size=rep(NA, length(allsizes)), user.self=NA, sys.self=NA, elapsed=NA, user.child=NA, sys.child=NA);	
#	for(i in 1:length(allsizes)){
#		thissize <- allsizes[i];
#		campaign_id <- paste(campaign.prefix, thissize, sep=":");
#		cat("Testing", campaign_id, "...\n")
#		mytime <- system.time(oh.survey_response.read(campaign_id, prompt_id_list = prompt_id_list, ...));
#		print(mytime);
#		mydf[i,] <- c(thissize, unname(mytime));
#	}
#	
#	return(mydf);	
#}
#
#profileFunction <- function(expr){
#	
#	#prepare
#	library(proftools);
#	Rprof(proftmp <- tempfile(), interval=0.01);
#	
#	#call the function
#	expr
#	
#	#parse the output
#	Rprof(memory.profiling=FALSE)
#	profdata <- as.data.frame(flatProfile(readProfileData(proftmp)));
#	profdata <- cbind(functionname=format(row.names(profdata), width=14), profdata);
#	return(profdata);
#}
