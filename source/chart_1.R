setwd("~/INFO_201/a3-wilsoncta/source")

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
View(incarceration)

library(dplyr)
library(tidyr)
library(ggplot2)

#current <- incarceration %>% #What is the average value of my variable across all the counties (in the current year)?
  #filter(year == 2018) %>% 
 # na.omit() %>% #Difference between na.rm and na.omit
  #mean(total_jail_pop)
#  summarise(avg = mean(total_jail_pop, na.rm = TRUE))
#current

year_max_jail_pop <- incarceration %>% #What year had the highest total jail population
  filter(total_jail_pop == max(incarceration$total_jail_pop, na.rm = TRUE)) %>% 
  pull(year)
  
year_max_pop <- incarceration %>% #What year had the highest total jail population
  filter(total_pop == max(incarceration$total_pop, na.rm = TRUE)) %>% 
  pull(year)

total_jail_pop <- incarceration %>%
  group_by(year) %>%
  summarise(avg = mean(total_jail_pop, na.rm = TRUE))

total_pop <- incarceration %>%
  group_by(year) %>%
    summarise(pop_avg = mean(total_pop, na.rm = TRUE)) #How to make this into its own line?

comparison <- left_join(total_jail_pop, total_pop)
View(comparison)

comp_plot <- comparison %>% 
  ggplot() +
  geom_line(mapping = aes(x = year, y = avg, color = "Jail Population")) +
  geom_line(mapping = aes(x = year, y = pop_avg, color = "General US Population")) +
  labs(x = "Year",
       y = "Population",
       title = "General Population and Jail Population in the US Over Time",
       color = "Average Total Population")
comp_plot
