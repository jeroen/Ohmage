library(Ohmage);
system("export _JAVA_OPTIONS=-Xmx16m", intern=TRUE);

#authenticate with token
oh.login('ohmage.admin','Very.healthy1','https://test.mobilizingcs.org/app');
#oh.login('loadtest.admin1', 'Test.123', 'https://test.mobilizgincs.org/app')

#get a campaign
snackxml <- system.file(package="Ohmage", "files/snack.xml");
sleepxml <- system.file(package="Ohmage", "files/sleep.xml");
advertisementxml <- system.file(package="Ohmage", "files/advertisement.xml");

joshxml <- system.file(package="Ohmage", "files/josh.xml");
photoxml <- system.file(package="Ohmage", "files/photosnack.xml");

#generate some data
loadtest(snackxml, 20, 5, 2);
loadtest(sleepxml, 50, 5, 2);
loadtest(advertisementxml, 50, 5, 2);
loadtest(photoxml, 10, 5, 2);
loadtest(joshxml, 100, 5, 2, verbose=T);

#moooore
loadtest(snackxml, 100, 5, 2);
loadtest(snackxml, 1000, 5, 2);
loadtest(snackxml, 10000, 5, 2);

#to wipe data
loadtest.wipe(joshxml, 1000)

#undo stuff
oh.class.delete("urn:class:loadtest");
oh.campaign.delete("urn:campaign:loadtest:Advertisement:10");
oh.user.delete("loadtest.Snack10.j")
oh.logout();

### test scale
library(Ohmage);
system("export _JAVA_OPTIONS=-Xmx16m", intern=TRUE);
joshxml <- system.file(package="Ohmage", "files/josh.xml");

#authenticate with token
oh.login('ohmage.admin','Very.healthy1','https://test.mobilizingcs.org/app');
loadtest(joshxml, 20, 5, 2, verbose=T);
