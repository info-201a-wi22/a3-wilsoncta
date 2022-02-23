setwd("~/INFO_201/a3-wilsoncta/source")

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
View(incarceration)

library(dplyr)
library(tidyr)
library(ggplot2)

incar_over_time <- incarceration %>%
  group_by(year) %>% 
  summarise(avg = mean(total_jail_pop, na.rm = TRUE)) %>% 
  ggplot(mapping = aes(x = year, y = avg)) +
  geom_point() +
  labs(x = "Year",
       y = "Total Jail Population",
       title = "Total Jail Population vs. Year")
incar_over_time
