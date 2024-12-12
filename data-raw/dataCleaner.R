

library(dplyr)
library(tidyverse)
library(readxl)
library(rvest)


myData<-read_excel('data-raw/World_Population.xlsx',sheet='ESTIMATES',skip=16)

WorldPopulation<-myData%>%filter(Type=="Country/Area")%>%
  select(-1,-2,-4,-5,-6,-7)%>%
  rename("Country"=1)



url<-'https://en.wikipedia.org/wiki/FIFA_World_Cup'

page<-read_html(url)

myTable<-page%>%html_nodes('table')%>%
  .[[4]]%>%
  html_table(header=FALSE,fill=TRUE)

World_Cup<-myTable%>%slice(-28,-27,-26,-25)%>%
  slice(-1,-2)%>%
  select(c(1,2,4,5,6))

# Rename the columns
colnames(World_Cup)<-c("Year","Hosts","Totalattendance","Matches","Averageattendance")

# Clean the data inside
World_Cup<-World_Cup%>%
  mutate(Totalattendance=str_replace_all(Totalattendance,pattern=',',replacement=''))%>%
  mutate(Averageattendance=str_replace_all(Averageattendance,pattern=",",replacement=''))%>%
  mutate(Totalattendance=as.numeric(Totalattendance))%>%
  mutate(Averageattendance=as.numeric(Averageattendance))%>%
  mutate(Matches=as.numeric(Matches))

World_Cup<-World_Cup%>%mutate(WorldCup=str_c(Hosts,Year,sep=""))%>%
  mutate(WorldCup=str_replace_all(WorldCup,regex("\\s*"),""))

World_Cup<-World_Cup%>%select(-Hosts,-Year)

usethis::use_data(World_Cup,overwrite=TRUE)
usethis::use_data(WorldPopulation,overwrite = TRUE)

