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

is.multifactor <- function(x){
	if("multifactor" %in% class(x)) {
		return(TRUE)
	} else {
		return(FALSE);
	}
}

"[.multifactor" <- function(x, ..., drop = FALSE){
	y <- NextMethod("[")
	attr(y, "labels") <- attr(x, "labels")
	attr(y, "levels") <- attr(x, "levels")
	attr(y, "ordered") <- attr(x, "ordered")
	attr(y, "prompt_type") <- attr(x, "prompt_type")
	class(y) <- oldClass(x)
	lev <- levels(x)
	if (drop) 
		factor(y, exclude = if (any(is.na(levels(x)))) 
			NULL
		else NA)
	else y	
}

"[[.multifactor" <- function (x, ...) {
	y <- NextMethod("[[")
	attr(y, "labels") <- attr(x, "labels")
	attr(y, "levels") <- attr(x, "levels")
	attr(y, "ordered") <- attr(x, "ordered")
	attr(y, "prompt_type") <- attr(x, "prompt_type")
	class(y) <- oldClass(x)
	y
}

rep.multifactor <- function (x, ...) 
{
	y <- NextMethod()
	structure(y, class = class(x), levels = attr(x, "levels"), labels = attr(x, "labels"), ordered=attr(x, "ordered"), prompt_type = attr(x, "prompt_type"));
}


