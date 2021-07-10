
# loading the tidyverse package
library(tidyverse)

# read data in R
collegescorecard<-read_csv("collegescorecard.csv")

# to view its contents
glimpse(collegescorecard)
View(collegescorecard)

# read data in R
collegescorecarddictionary<-read_csv(file.choose())

# to view its contents
glimpse(collegescorecarddictionary)
View(collegescorecarddictionary)


# Use select to extact the significant variables

university<-select(collegescorecard,InstitionName=instnm,City=city,State=stabbr,PredominantDegreeAwarded=preddeg,
             HighestDegreeAwarded=highdeg,state_fips=st_fips,Locale=locale,
             Associate_computer_degree=cip11assoc,Bachelor_computer_degree=cip11bachl,
             Associate_science_technology_degree=cip41assoc,Bachelor_science_technology_degree=cip41bachl,
             CurrentlyOperating=curroper)
View(university)

# filtering the data in terms of those that offer a computer/science degree
# Offers associate/bachelor degree (she wants a 2/4 year degree)
# in a city (filtered with locale (11,12,13))
# filtered with state_fips to remove states not in continental USA i.e Alaska(2),
# Hawaii(15),American_Samoa(60),U.S._Virgin_Islands(78),Northern_Mariana_Islands(69),Puerto_Rico(72)
# filtered with if the uni is currently operating or not
university2<-filter(university,Bachelor_computer_degree>0,HighestDegreeAwarded>1,PredominantDegreeAwarded<4,Locale %in% c(11,12,13),CurrentlyOperating=TRUE,
                    )

# Finding index of rows that contain unis not in continental USA
noncontinentalstates<-which(university2$state_fips %in% c(2,15,60,78,69,72))

# removing them from my tibble
university2<-university2[-noncontinentalstates,]
view(university2)

# importing the crime data
Crime<-read_csv("crime_2015.csv")
View(Crime)
Crime<-mutate(Crime,CrimePercentage=mean(violentcrime,murder,rape,robbery,aggravatedassault,
                                             propertycrime,burglary,theft,motorvehicletheft))

# find the mean percentage crime in terms of city
aggregate(Crime)
