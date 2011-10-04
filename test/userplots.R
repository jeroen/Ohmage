library(Mobilize);
serverurl <- "https://dev3.mobilizingcs.org/app";
mytoken <- oh.login("ohmage.jeroen", "ohmage.jeroen", serverurl);

#list some campaigns
campaigns <- oh.campaign.read(output="long");
Advertisement <- grep("Advertisement",names(campaigns$data), value=T)[1]
Sleep <- grep("Sleep",names(campaigns$data), value=T)[1]
Snack <- grep("Snack",names(campaigns$data), value=T)[1]

#get some data
Advertisement.data <- oh.getdata(serverurl, mytoken, Advertisement);
Sleep.data <- oh.getdata(serverurl, mytoken, Sleep);
Snack.data <- oh.getdata(serverurl, mytoken, Snack);

#response plots
print(responseplot(serverurl, mytoken, Advertisement));
print(responseplot(serverurl, mytoken, Sleep));
print(responseplot(serverurl, mytoken, Snack));

#prompt lists
names(Snack.data)


userplot(serverurl, mytoken, Snack, "HealthyLevel", "ohmage.baa");
userplot(serverurl, mytoken, Snack, "WhoYouSnackWith", "ohmage.baa");
