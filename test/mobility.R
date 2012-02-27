library(Ohmage);
oh.login("ohmage.ooms", "vohohdai.g", "https://dev.andwellness.org/app");
mydata <- oh.mobility.read(date="2012-01-09", username="ohmage.josh", with_sensor_data="true", verbose=T);
