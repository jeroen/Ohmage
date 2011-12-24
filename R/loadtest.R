# TODO: Add comment
# 
# Author: jeroen
###############################################################################

setXmlValues <- function(xmlfile, n.users){
	xmldoc <- xmlParse(xmlfile);
	urnnode <- getNodeSet(xmldoc, "/campaign/campaignUrn")[[1]];
	namenode <- getNodeSet(xmldoc, "/campaign/campaignName")[[1]];
	oldname <- xmlValue(namenode);
	xmlValue(urnnode) <- paste("urn:campaign:loadtest", oldname, n.users, sep=":");
	xmlValue(namenode) <- paste("loadtest", oldname, n.users, sep=".");
	newfile <- tempfile();
	saveXML(xmldoc, newfile);
	attr(newfile, "oldname") <- oldname;
	return(newfile);	
}

stripspace <-function(x) {
	sub("^\\s*([^ ]*.*[^ ])\\s*$", "\\1",x);
}

stripuuid <- function(datastring){
	newstring <- "12345678-1234-1234-1234-1234567890ab"
	myexpr <- "[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}"
	hasphoto <- length(grep(myexpr, datastring)>0);
	if(hasphoto){
		newdatastring <- gsub(myexpr, newstring, datastring);
	} else {
		newdatastring <- datastring;
	}
	attr(newdatastring, "hasphoto") <- hasphoto;
	return(newdatastring);
}

getuuids <- function(datastring){
	myexpr1 <- "\"value\":\"[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}\""
	myexpr2 <- "[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}"		
	photomatches <- (regmatches(datastring, gregexpr(myexpr1, datastring))[[1]]);
	return(unlist(regmatches(photomatches, gregexpr(myexpr2, photomatches))))
}

makeuuidparams <- function(datastring, testimage){
	uuids <- getuuids(datastring)
	outlist <- list()
	for(i in uuids){
		outlist[[i]] <- testimage;
	}
	return(outlist);
}


numtolet <- function(number, numlength=6){
	num2let <- function(number) return(letters[number])
	number <- as.integer(number);
	number <- formatC(number, digits=0, width=numlength, flag=0, format="f");
	allindexes <- lapply(strsplit(number,""), as.numeric);
	allindexes <- lapply(allindexes, "+", 1)
	strings <- sapply(lapply(allindexes, num2let), paste, collapse="");
	return(strings);	
}

#' Data generations for loadtesting
#' @param xmlfile xml file or string
#' @param n.users number of users to generate
#' @param n.days number of days per user
#' @param n.responses number of responses per day
#' @param recycle if https connection should be kept alive (recommended)
#' @param verbose verbose output
#' @export
loadtest <- function(xmlfile, n.users, n.days=7, n.responses=3, recycle=TRUE, verbose=FALSE){
	
	#statics
	class_urn <- "urn:class:loadtest";
	password <- "Test.123";
	user.prefix <- "loadtest"
	datagenjar <- system.file(package="Ohmage", "files/andwellness-survey-generator-2.9.jar");
	ohmage_username <- getOption("ohmage_username")
	
	#new xml file
	myxmlfile <- tempfile();
	if(isTRUE(regexpr("<?xml", xmlfile, fixed=T))){
		#write to file.
		write(xmlfile, file=myxmlfile);	
	} else if(file.exists(xmlfile)) {
		#copy existing xml file
		file.copy(xmlfile, myxmlfile);
	} else {
		stop("xmlfile argument needs to be xml string or a filename.")
	}
	
	myxmlfile <- setXmlValues(myxmlfile, n.users);

	#parse xml
	oldname <- attr(myxmlfile, "oldname")
	xmldoc <- xmlParse(myxmlfile);
	campaignUrn <- stripspace(xmlValue(getNodeSet(xmldoc, "/campaign/campaignUrn")[[1]]));	
	
	#try to create class (might already exist);
	mytry <- try(oh.class.create(class_urn, "Loadtestclass", recycle=recycle), silent=T);
	if(class(mytry) == "try-error") message(stripspace(paste(strsplit(mytry[1],":")[[1]][-1], collapse=":")));
	oh.class.update(class_urn, user_role_list_add=paste(ohmage_username,";privileged", sep=""));
	
	#create campaign
	oh.campaign.create(xml=paste(readLines(myxmlfile), collapse="\n"), class_urn_list=class_urn);
	creationtime <- as.character(oh.campaign.read(output="short")[campaignUrn,"creation_timestamp"]);
	
	#generate usernames.
	usernames <- paste(user.prefix,".", substring(oldname, 1,5), "." ,n.users, ".",numtolet(0:(n.users-1), ceiling(log(n.users,10))), sep="");
	
	#create users.
	for(thisuser in usernames){
		oh.user.create(thisuser, password, recycle=recycle)
	}
	
	#add them to a class
	user.role.list <- paste(usernames, ";restricted", collapse=",", sep="");
	message("Adding users to class...")
	oh.class.update(class_urn, user_role_list_add=user.role.list);
	
	#build the system command
	command <- paste("java -jar", datagenjar, myxmlfile, n.days, n.responses, "/tmp/datagen.json upload");	
	testimage <- fileUpload(system.file("files/lolcat.jpg", package="Ohmage"), contentType="image/jpg")
	
	#for all users...
	for(thisuser in usernames){
		
		#generate some data
		unlink("/tmp/datagen.json");		
		system(command, intern=TRUE);
		jsondata <- readChar("/tmp/datagen.json", file.info("/tmp/datagen.json")$size);
		uuidparams <- makeuuidparams(jsondata, testimage);
		
		#get hashed passwd
		hashedpass <- oh.user.auth(thisuser, "Test.123", recycle=recycle);

		#call upload function
		surveyargs <- list(campaign_urn=campaignUrn, user=thisuser, password=hashedpass, campaign_creation_timestamp=creationtime, 
				surveys=jsondata, recycle=recycle, verbose=verbose);
		do.call("oh.survey.upload", c(surveyargs, uuidparams));

	}
	
	message("Successfully generated data for ", n.users, " users, ", n.days, " days, and ", n.responses, " responses.\n\n");
}


#' Delete campaign generated by loadtest function
#' @param xmlfile path or string of orriginal xml
#' @param n.users number of users that was generated
#' @param recycle to recycle the connection
#' @export
loadtest.wipe <- function(xmlfile, n.users, recycle=TRUE){
	
	#statics
	user.prefix <- "loadtest"
	
	#new xml file
	myxmlfile <- tempfile();
	if(isTRUE(regexpr("<?xml", xmlfile, fixed=T))){
		#write to file.
		write(xmlfile, file=myxmlfile);	
	} else if(file.exists(xmlfile)) {
		#copy existing xml file
		file.copy(xmlfile, myxmlfile);
	} else {
		stop("xmlfile argument needs to be xml string or a filename.")
	}
	
	myxmlfile <- setXmlValues(myxmlfile, n.users);
	
	#parse xml
	oldname <- attr(myxmlfile, "oldname")
	xmldoc <- xmlParse(myxmlfile);
	campaignUrn <- stripspace(xmlValue(getNodeSet(xmldoc, "/campaign/campaignUrn")[[1]]));	
	
	#usernames
	usernames <- paste(user.prefix,".", substring(oldname, 1,5), "." ,n.users, ".",numtolet(0:(n.users-1), ceiling(log(n.users,10))), sep="");
	
	#remove all
	message("trying to wipe: ", campaignUrn);
	try(oh.campaign.delete(campaignUrn));
	
	for(thisuser in usernames){
		message("Deleting user: ", thisuser);
		try(oh.user.delete(thisuser, recycle=recycle));		
	}
}
