# TODO: Add comment
# 
# Author: jeroen
###############################################################################

library(Ohmage)
oh.login("ohmage.josh", "koorivee.r", "https://dev.mobilizingcs.org/app");
mydata <- oh.survey_response.read('urn:campaign:ca:lausd:Jefferson:ECS:May:2011:Advertisement', prompt_id_list="ProductType", column_list="urn:ohmage:context:timestamp,urn:ohmage:prompt:response,urn:ohmage:survey:id", verbose=T);
loadtest(10);
