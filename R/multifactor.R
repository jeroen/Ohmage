# TODO: Add comment
# 
# Author: jeroen
###############################################################################


multifactor <- function(values, levels, labels, ordered=TRUE){
	newvalues <- sapply(values, paste, collapse="+");
	newvalues[is.na(values)] <- NA;
	attr(newvalues, "levels") <- levels;
	attr(newvalues, "labels") <- labels;
	attr(newvalues, "ordered") <- ordered;
	class(newvalues) <- c("multifactor", "character");
	return(newvalues);	
}

as.vector.multifactor <- function(x, mode){
	myvec <- unlist(strsplit(x, "+", fixed=TRUE));
	myfactor <- factor(myvec, attr(x, "levels"), attr(x, "labels"), attr(x, "ordered"));
	return(myfactor);
}

levelinfactor <- function(mylist, mylevel){
	if(length(mylevel) != 1) {
		stop("level has to be of length 1.");
	}
	return(sapply(sapply(mylist, "==", mylevel), any));
}

expand.multifactor <- function(x){
	newvalues <- strsplit(x, "+", fixed=TRUE);
	mydf <- as.data.frame(sapply(attr(x, "levels"), levelinfactor, mylist=newvalues));
	colnames(mydf) <- attr(x, "labels");
	return(mydf);
}

dim.multifactor <- function(x){
	return(sapply(strsplit(x, "+", fixed=TRUE), length));
}