library(shiny)
library(lubridate)

#Calculation of time
now <- now()
hours_dec <- hour(now) + minute(now) / 60 + second(now) / 3600;
percent <- hours_dec / 24 * 100

#UI
ui <-tagList(
  
  h1("Tagesfortschritt"),
  p("Wie weit ist der Tag schon fortgeschritten?"),
  tags$label(percent, "for" = "progress"),
  tags$progress(id = "progress", value = percent, max = 100)
)

#Server
server <- function(input, output, session) {
}
  
shinyApp(ui, server)
