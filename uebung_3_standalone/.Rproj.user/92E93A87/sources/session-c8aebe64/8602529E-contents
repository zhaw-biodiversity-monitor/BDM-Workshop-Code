
library(tidyverse)
library(plotly)
workshop_data <- read_csv("03_lebenserwartung/data/prepared/workshop_data.csv")


workshop_data %>% 
  ggplot(aes(x = GdpPerCapita, y = LifeExpectancy, color = Region, group = Country)) +
  geom_path()  +
  scale_x_log10() +
  theme(legend.position = "none")




myggvis(workshop_data, 1987)


