#' Country Population
#'
#' Country population is a function that takes as an input the string name of
#' a country and returns the graph of estimated population over time. The data
#' is obtained using the World Population data that is found in this
#' package.
#'
#'
#'
#'
#' @param country A string that represents the name of the country
#'
#' @return A ggplot object of population over time of the input country
#' @examples
#' CountryPopulation("China")
#' CountryPopulation("Tuvalu")
#' @export

CountryPopulation<- function(country){

  if (any(WorldPopulation==country)==FALSE){
    stop("Entered country does not exist")

  }



  tempData<-WorldPopulation%>%filter(Country==country)%>%
    pivot_longer(2:72,names_to = "Year",values_to="Population")%>%
    mutate(Year=as.numeric(Year))%>%
    mutate(Population=as.numeric(Population))



  # Manipulating the table so that it is easier to graph


  title=paste("Population of",country)

  Out_Plot<-ggplot(data=tempData,aes(x=Year,y=Population))+geom_point()+
    ggtitle(title)+
    labs(x="Year",y="Population (thousands) ")

  return(Out_Plot)
}
