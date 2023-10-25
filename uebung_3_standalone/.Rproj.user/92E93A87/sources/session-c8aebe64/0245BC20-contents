

library(shiny)

workshop_data <- read_csv("03_lebenserwartung/data/prepared/workshop_data.csv")

xrange <- range(workshop_data$GdpPerCapita)
yrange <- range(workshop_data$LifeExpectancy)

regions <- unique(workshop_data$Region)

ui <- fluidPage(
  titlePanel("How does GDP affect Life Expectancy?"),
  selectInput("myregion", "Region", regions),
  
  plotOutput("myplot")
)


server <- function(input, output, session){
  
  output$myplot <- renderPlot({
    
    workshop_data %>% 
      filter(Region == input$myregion) %>% 
      ggplot(aes(x = GdpPerCapita, y = LifeExpectancy, color = Country)) +
      geom_path()  +
      scale_x_log10(limits = xrange) +
      scale_y_continuous(limits = yrange) +
      theme(legend.position = "none")
  })
  
  
}


shinyApp(ui, server)