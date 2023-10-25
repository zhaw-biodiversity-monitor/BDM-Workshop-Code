

library(shiny)
library(ggvis)
library(readr)
library(dplyr)

workshop_data <- read_csv("data/prepared/workshop_data.csv")

min_year <- min(workshop_data$Year)
max_year <- max(workshop_data$Year)
min_gdp <- min(log10(workshop_data$GdpPerCapita))
max_gdp <- max(log10(workshop_data$GdpPerCapita))
min_le <- min(workshop_data$LifeExpectancy)
max_le <- max(workshop_data$LifeExpectancy)
regions <- unique(workshop_data$Region)

myvis1 <- function(dataset, year, region){
  # browser()
  dataset %>% 
    # filter(Year ==  year) %>%
    filter(Region == region) %>%
    # filter(Country %in% c("Afghanistan", "Eswatini")) %>%
    plotly::plot_ly(y = ~LifeExpectancy, color = ~Country, x = ~log10(GdpPerCapita),size = ~Population, text = ~Country) %>% 
    plotly::add_trace(mode = "lines+markers") %>% 
    plotly::layout(yaxis = list(range = list(min_le, max_le)), xaxis = list(range = list(min_gdp, max_gdp)))
  
  
}

ui <- fluidPage(
  # sliderInput("inputyear",label = "Year", value = min_year, min =min_year, max = max_year, sep = "",animate = TRUE),
  selectInput("Region","Region",selected = regions[1], choices = regions),
  plotlyOutput("myvis")
)


server <- function(input, output, session){
  
  output$myvis <- renderPlotly(myvis1(workshop_data, input$inputyear, input$Region))
}


shinyApp(ui, server)