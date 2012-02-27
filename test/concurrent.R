library(multicore);
library(RCurl)
library(Mobilize);
oh.login("ohmage.admin", "Very.healthy1", "https://test.mobilizingcs.org/app");
baseurl = paste("http://test-r.mobilizingcs.org/R/call/Mobilize/responseplot/png?token='", getOption("TOKEN"), "'&server='", getOption("SERVERURL"), "'&campaign_urn='", sep="");

NIH <- "urn:campaign:loadtest:Moms:45";
Snack <- "urn:campaign:loadtest:snack:250";
thisurl <- paste(baseurl, Snack, "'", sep="");

output <- list();
N <- 20;
for(k in 1:N){
	cat("Benchmarking, ", k, "concurrent threads...\n")
	for(i in 1:k){
		parallel(unclass(system.time(print(responseplot(Snack)))));
	}
	thedata <- collect();
	collect(wait=TRUE);
	mydf <- try(as.data.frame(thedata));
	if(class(mydf)=="try-error"){
		print(thedata)
	}
	output[[k]] <- mydf;
}


