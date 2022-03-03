setwd("~/INFO_201/a3-wilsoncta/source")

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
View(incarceration)

library(dplyr)
library(tidyr)
library(ggplot2)

race <- incarceration %>%
  select(year, aapi_jail_pop, black_jail_pop, latinx_jail_pop, native_jail_pop, white_jail_pop, total_jail_adm) %>% 
  group_by(year) %>% 
  na.omit() %>% 
  mutate(avg_aapi_jail_pop = mean(aapi_jail_pop)) %>% 
  mutate(avg_black_jail_pop = mean(black_jail_pop)) %>% 
  mutate(avg_latinx_jail_pop = mean(latinx_jail_pop)) %>% 
  mutate(avg_native_jail_pop = mean(native_jail_pop)) %>% 
  mutate(avg_white_jail_pop = mean(white_jail_pop))
View(race)

race_comp <- race %>% 
  ggplot(aes (x = year)) +
  geom_line(aes(y = race$avg_aapi_jail_pop, color = "AAPI")) +
  geom_line(aes(y = race$avg_black_jail_pop, color = "Black")) +
  geom_line(aes(y = race$avg_latinx_jail_pop, color = "Latinx")) +
  geom_line(aes(y = race$avg_native_jail_pop, color = "Native American")) +
  geom_line(aes(y = race$avg_white_jail_pop, color = "White")) +
  scale_x_continuous() +
  labs(x = "Year",
       y = "Population",
       title = "Average Jail Population by Race in the US Over Time",
       color = "Race")
race_comp
