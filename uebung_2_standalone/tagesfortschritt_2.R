library(shiny)
library(lubridate)

get_percent <- function(x){
  now <- Sys.time()
  diff <- ((hour(now) + minute(now)/60 + second(now)/3600)/24)*100
  return(diff)
}

ui <- tagList(
  h1("Tagesfortschritt"),
  p("Wie Weit ist der Tag fortgeschritten?"),
  textOutput("progress")
)


server <- function(input, output, session){
  output$progress <- renderText({
    invalidateLater(100)
    get_percent()
    })
}
  

shinyApp(ui, server)