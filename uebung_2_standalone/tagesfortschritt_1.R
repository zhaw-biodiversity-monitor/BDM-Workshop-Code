library(shiny)
library(lubridate)

ui <- tagList(
     h1("Tagesfortschritt"),
     p("Wie Weit ist der Tag fortgeschritten?"),
     textOutput("progress")
  )


server <- function(input, output, session){
  now <- Sys.time()
  
  percent <- ((hour(now) + minute(now)/60 + second(now)/3600)/24)*100
  
  output$progress <- renderText(percent)
  
}

shinyApp(ui, server)