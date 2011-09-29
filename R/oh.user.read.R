# TODO: Add comment
# 
# Author: jeroen
###############################################################################


oh.user.read <- function(user_list, ...){
	xhr <- oh.call("/user/read ", user_list=user_list, ...);		
	return(xhr);	
}
