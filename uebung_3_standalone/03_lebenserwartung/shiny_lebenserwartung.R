library(shiny)
library(readr)
library(ggplot2)
library(plotly)

workshop_data <- read_delim("data/prepared/workshop_data.csv")

#Define filters
countries <- sort(as.vector(unique(workshop_data$Country)))
regions <- sort(as.vector(unique(workshop_data$Region)))

ui <- fluidPage(
  headerPanel("Shiny Exercise"),
  sidebarPanel(
    width = 3,
    selectizeInput("regions",
      "Select Region",
      regions,
      multiple = T,
      options = list(placeholder = 'Select regions')
    ),
    selectizeInput(
      "countries",
      "Select Countries",
      countries,
      multiple = T,
      options = list(placeholder = 'Select countries')
    ),
    sliderInput(
      "year",
      "Select Year",
      min = 1950,
      max = 2018,
      value = 1980,
      sep = "",
      animate = animationOptions(interval = 100)
    )
  ),
  mainPanel(
    plotOutput("scatter_ggplot", width = "100%", height = "800px")
    #plotlyOutput("scatter_plotly", width = "100%", height = "800px")
  )
)

server <- function(input, output) {
  selected_data <- reactive({
    workshop_data_filted <- subset(workshop_data, Year == input$year, drop = T)
    
    regions <- input$regions
    if (!is.null(regions)) {
      workshop_data_filted <- subset(workshop_data_filted, Region %in% regions, drop = T)
    }
    
    countries <- input$countries
    if (!is.null(countries)) {
      workshop_data_filted <- subset(workshop_data_filted, Country %in% countries, drop = T)
    }
    
    workshop_data_filted
  })
  
  ##Simple ggplot
  output$scatter_ggplot <- renderPlot({
    selected_data() |>
      ggplot(aes(x = LifeExpectancy, y = log10(GdpPerCapita), color = Region)) +
      geom_point(aes(size = Population)) +
      xlim(10, 90) +
      ylim(2, 6) +
      theme(legend.position = "none")
  })
  
  ##Interactive plotly web plot 
  output$scatter_plotly <- renderPlotly(
    selected_data() |>
      plotly::highlight_key( ~ Country) |>
      plot_ly(
        x = ~ LifeExpectancy,
        y = ~ log10(GdpPerCapita),
        size = ~ Population,
        color = ~ Region,
        fill = ~ '',
        type = "scatter",
        mode = "markers",
        opacity = 0.7,
        marker = list(line = list(color = 'black', width = 1), sizemode = 'diameter', sizeref = 0.8),
        hoverinfo = 'text',
        text = ~ paste(
          "Country:", Country,
          "<br>Region:", Region,
          "<br>Life Expectancy:", LifeExpectancy,
          "<br>GDP per Capita:", prettyNum(GdpPerCapita, big.mark = "'"),
          "<br>Population:", prettyNum(Population, big.mark = "'")
        )
      ) |>
      layout(
        showlegend = FALSE,
        xaxis = list(title = 'Life Expectancy', range = c(10, 90)),
        yaxis = list(title = 'GDP per Capita (Log 10)', range = c(2, 6))
      ) |>
      plotly::highlight(on = "plotly_hover", off = "plotly_deselect", opacity = 1)
  )
}

shinyApp(ui, server)
