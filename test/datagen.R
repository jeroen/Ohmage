#test if it works:
library(Ohmage);
oh.login('ohmage.jeroen','Very.healthy1','https://test.mobilizingcs.org/app');
loadtest(10);
loadtest.wipe(10);

#bigger loadtest
sizes <- c(50,100,200,300,400,500,600,700,800,900,1000);
for(thissize in sizes){
  oh.logout();
  oh.login('ohmage.jeroen','Very.healthy1','https://test.mobilizingcs.org/app');
  loadtest(thissize, user.prefix="tests");
}

#new server
library(Ohmage);
oh.login('ohmage.admin','ohmage.passwd','https://cens.opencpu.org/app');

