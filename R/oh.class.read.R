# TODO: Add comment
# 
# Author: jeroen
###############################################################################


oh.class.read <- function(class_urn_list="urn:ohmage:special:all", ...){
	xhr <- oh.call("/class/read", class_urn_list=class_urn_list, ...);	
	return(xhr);	
}
