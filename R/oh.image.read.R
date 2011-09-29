# TODO: Add comment
# 
# Author: jeroen
###############################################################################


oh.image.read <- function(campaign_urn, owner, id, ...){
	tf <- oh.call("/image/read ", responseformat="file", campaign_urn=campaign_urn, owner=owner, id=id, ...);
	if(attr(tf,"Content-Type") != "image/jpeg"){
		stop("Unknown image format: ",attr(tf,"Content-Type"),". Please update in oh.image.read.");
	}
	newname <- paste("/tmp/", id,".jpg", sep="");	
	file.rename(tf, newname);
	return(newname);
}
