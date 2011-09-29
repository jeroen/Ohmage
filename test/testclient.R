#install.packages("RCurl", repos = "http://www.omegahat.org/R", type = "source")
#install.packages("RJSONIO", repos = "http://www.omegahat.org/R", type = "source")

#Reload package.
if(!is.null(sessionInfo()[5]$otherPkgs$Ohmage)) detach("package:Ohmage");
library(Ohmage);

#authenticate with token
oh.login('ohmage.jeroen','ohmage.jeroen','https://dev3.mobilizingcs.org/app');
oh.logout();

#read campaign info
campaigns <- oh.campaign.read();
campaigns <- oh.campaign.read(output="xml");
campaigns <- oh.campaign.read(output="long");

#extract some campaign and some user
somecampaign <- names(campaigns$data)[1];
someclass <- campaigns$data[[1]]$classes[[1]];
someuser <- campaigns$data[[1]]$user_role_campaign[[1]][[1]]

#read class info
oh.class.read(class_urn_list=someclass);

#read user statistics
oh.user_stat.read(somecampaign, someuser);

#read user info
oh.user_info.read(someuser);

#read some survey responses
oh.survey_response.read(somecampaign, verbose=T);

#try to get csv (doesnt work yet)
oh.survey_response.read(somecampaign, output_format="csv", verbose=T);

############################### HTTPS ####################################
oh.logout();

library(Ohmage);
mytoken <- oh.login('ohmage.jeroen','ohmage.jeroen','https://dev1.andwellness.org/app');
campaigns <- oh.campaign.read();
campaigns <- oh.campaign.read(output="long");


#extract some campaign and some user
CS219 <- names(campaigns$data)[1];
Advertisement <- names(campaigns$data)[4];
Sleep <- names(campaigns$data)[3];
Snack <- names(campaigns$data)[4];

someclass <- campaigns$data[[Snack]]$classes[[1]];
someuser <- campaigns$data[[Snack]]$user_role_campaign[[1]][[1]]

#read class info
classinfo <- oh.class.read(class_urn_list=someclass);

#read user statistics
oh.user_stat.read(Advertisement, "ohmage.jeroen");
oh.user_stat.read(Advertisement, someuser);

#read user info
oh.user.read("ohmage.jeroen", verbose=T);
oh.user.read(someuser);

#read some survey responses
CS219.data <- oh.survey_response.read(CS219);
Advertisement.data <- oh.survey_response.read(Advertisement);
Sleep.data <- oh.survey_response.read(Sleep);
Snack.data <- oh.survey_response.read(Snack);

#note this works only for the advertisement campaign.
someuser <- Advertisement.data[6, "user.id"]
somephoto <- Advertisement.data[6, "prompt.id.AdPhoto"];
oh.image.read(Advertisement, someuser, somephoto, verbose=T)

#some debugging example
raw.obj <- oh.survey_response.read(Sleep, to.data.frame=F);
parse.item(raw.obj$data[[1]]);
parse.item(raw.obj$data[[2]]);
parse.item(raw.obj$data[[3]]);
parse.item(raw.obj$data[[4]]);
parse.item(raw.obj$data[[5]]);
parse.item(raw.obj$data[[6]]);
parse.item(raw.obj$data[[7]]);
parse.item(raw.obj$data[[8]]);
parse.item(raw.obj$data[[9]]);
parse.item(raw.obj$data[[10]]);
parse.item(raw.obj$data[[11]]);
parse.item(raw.obj$data[[12]]);
parse.item(raw.obj$data[[13]]);

#test the oh.data wrapper
myData <- oh.getdata('https://dev.mobilizingcs.org/app', mytoken, Sleep);
