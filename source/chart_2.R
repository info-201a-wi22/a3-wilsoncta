setwd("~/INFO_201/a3-wilsoncta/source")

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
View(incarceration)

library(dplyr)
library(tidyr)
library(ggplot2)

racial_inequity <- incarceration %>%
  group_by(year) %>% 
  summarise(avg = mean(black_jail_pop, na.rm = TRUE)) %>% 
  mutate()
  
  
  ggplot(mapping = aes(x = black_jail_pop, y = white_jail_pop)) +
  geom_point() +
  labs(x = "Year",
       y = "Total Jail Population",
       title = "Total Jail Population vs. Year")
racial_inequity
