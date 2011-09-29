# TODO: Add comment
# 
# Author: jeroen
###############################################################################

oh.auth_token <-	function(user, password, ...){
	xhr <- oh.call("/user/auth_token", user=user, password=password, ...);
	assign("TOKEN",xhr$token,"package:Ohmage");
	message("Login successful.");
	return(xhr$token);
}


