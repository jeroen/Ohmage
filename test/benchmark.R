library(Mobilize);
oh.login("ohmage.admin", "Very.healthy1", "https://test.mobilizingcs.org/app");
campaigns <- row.names(oh.campaign.read());
campaigns <- grep("urn:campaign:loadtest:jeroen", campaigns, value=T);
sizes <- as.numeric(substring(campaigns, 30));
myorder <- order(sizes);
campaigns <- campaigns[myorder];
sizes <- sizes[myorder];

#Benchmark parsing all prompts in survey_response/read
benchmark_read <- data.frame(size=sizes, test="Ohmage", user.self=NA, sys.self=NA, elapsed=NA, user.child=NA, sys.child=NA);
bla <- oh.survey_response.read(campaigns[1])
for(i in 1:length(campaigns)){
	cat("Benchmarking size: ", sizes[i], "\n");
	benchmark_read[i, 3:7] <- unclass(system.time(oh.survey_response.read(campaigns[i])));
}

#Breakdown Benchmark Responseplot:
benchmark_responseplot <- data.frame(size=sizes, test="responseplot", user.self=NA, sys.self=NA, elapsed=NA, user.child=NA, sys.child=NA);
print(responseplot(campaigns[1]));
for(i in 1:length(campaigns)){
	cat("Benchmarking size: ", sizes[i], "\n");
	benchmark_responseplot[i, 3:7] <- unclass(system.time(print(responseplot(campaigns[i]))));
}

benchmark_opencpu <- data.frame(size=sizes, test="opencpu", user.self=NA, sys.self=NA, elapsed=NA, user.child=NA, sys.child=NA);
baseurl = paste("http://test-r.mobilizingcs.org/R/call/Mobilize/responseplot/png?token='", getOption("TOKEN"), "'&server='", getOption("SERVERURL"), "'&campaign_urn='", sep="");
for(i in 1:length(campaigns)){
	cat("Benchmarking size: ", sizes[i], "\n");
	thisurl <- paste(baseurl, campaigns[i], "'", sep="");
	benchmark_opencpu[i, 3:7] <- unclass(system.time(download.file(thisurl, tempfile())));
}

benchmark_proxy <- data.frame(size=sizes, test="proxy", user.self=NA, sys.self=NA, elapsed=NA, user.child=NA, sys.child=NA);
baseurl <- paste("https://test.mobilizingcs.org/app/viz/survey_response_count/read?client=gwt&width=640&height=480&auth_token=", getOption("TOKEN"), "&campaign_urn=", sep="");
for(i in 1:length(campaigns)){
	cat("Benchmarking size: ", sizes[i], "\n");
	thisurl <- paste(baseurl, campaigns[i], sep="");
	benchmark_proxy[i, 3:7] <- unclass(system.time(download.file(thisurl, tempfile(), method="wget", cacheOK=FALSE, extra="--cache=off")));
}

#Post processing
library(reshape2);
library(ggplot2);
benchmarks <- data.frame(size=sizes);
benchmarks$Ohmage <- benchmark_responseplot$elapsed - benchmark_responseplot$user.self;
benchmarks$R <- benchmark_responseplot$elapsed;
benchmarks$OpenCPU <- benchmark_opencpu$elapsed;
benchmarks$Proxy <- benchmark_proxy$elapsed;
mydata <- melt(benchmarks, "size", variable.name="test", value.name="seconds");
mydata$test <- factor(mydata$test, levels=c("Ohmage", "R", "OpenCPU", "Proxy"), 
		labels=c("DB (Ohmage)", "Plot (R)", "HTTPd (OpenCPU)", "Proxy (Ohmage-Viz)"), ordered=T)
myplot <-  qplot(size, seconds, color=test, data=mydata, geom=c("point"), 
	ylab="Cumulative time (seconds)", xlab="Number of users") +
	geom_smooth(method="lm", se=F);
print(myplot);