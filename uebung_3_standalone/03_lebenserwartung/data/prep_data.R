library(readr)
library(readxl)
library(tidyr)
library(dplyr)

population <- read_delim("03_Shiny_GDP/03_lebenserwartung/data/raw/population-and-demography.csv") |> select("Country name", Year, Population)
lifeExp <- read_delim("03_Shiny_GDP/03_lebenserwartung/data/raw/life-expectancy.csv") |> select(Code, Year, Entity, "Life expectancy at birth (historical)")
gdpPerCapita <- read_delim("03_Shiny_GDP/03_lebenserwartung/data/raw/gdp-per-capita-maddison-2020.csv") |> select(Code, Year, "GDP per capita")
metadata <- read_excel("03_Shiny_GDP/03_lebenserwartung/data/raw/P_Popular Indicators_Metadata.xlsx", sheet = "Country - Metadata") |> select(Code, Region)

workshop_data <- lifeExp |>
  inner_join(gdpPerCapita, by = c("Code" = "Code", "Year" = "Year")) |>
  inner_join(population, by = c("Entity" = "Country name", "Year" = "Year")) |>
  inner_join(metadata, by = c("Code" = "Code"))
names(workshop_data) <- c("Code", "Year", "Country", "LifeExpectancy", "GdpPerCapita", "Population", "Region")


workshop_data %>% filter(is.na(Code))

write_csv(workshop_data, "03_Shiny_GDP/03_lebenserwartung/data/prepared/workshop_data.csv")
