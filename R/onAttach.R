# TODO: Add comment
# 
# Author: jeroen
###############################################################################

.onAttach <- function(lib, pkg){
	options(OhCurlHandle = getCurlHandle());
	options(OhCurlReader = dynCurlReader(getOption("OhCurlHandle"), binary = TRUE));
	options(TOKEN = NULL)
	options(SERVERURL = NULL)
	options(CLIENTNAME = "R-Ohmage")
	options(CURLCOUNT = 0);
}