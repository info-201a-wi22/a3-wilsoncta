setwd("~/INFO_201/a3-wilsoncta/source")

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
View(incarceration)

library(dplyr)
library(tidyr)
library(ggplot2)

avg_aapi <- incarceration %>% 
  group_by(year) %>% 
  summarise(aapi = sum(aapi_jail_pop, na.rm = TRUE))

avg_black <- incarceration %>% 
  group_by(year) %>% 
  summarise(black = sum(black_jail_pop, na.rm = TRUE))

avg_latinx <- incarceration %>% 
  group_by(year) %>% 
  summarise(latinx = sum(latinx_jail_pop, na.rm = TRUE))

avg_native <- incarceration %>% 
  group_by(year) %>% 
  summarise(native = sum(native_jail_pop, na.rm = TRUE))

avg_white <- incarceration %>% 
  group_by(year) %>% 
  summarise(white = sum(white_jail_pop, na.rm = TRUE))

race <- avg_aapi %>%
  left_join(avg_black, by = "year") %>% 
  left_join(avg_latinx, by = "year") %>% 
  left_join(avg_native, by = "year") %>% 
  left_join(avg_white, by = "year") %>% 
  tail(34)
View(race)

race_comp <- race %>% 
  ggplot(aes (x = year)) +
  geom_line(aes(y = aapi, color = "AAPI")) +
  geom_line(aes(y = black, color = "Black")) +
  geom_line(aes(y = latinx, color = "Latinx")) +
  geom_line(aes(y = native, color = "Native American")) +
  geom_line(aes(y = white, color = "White")) +
  scale_x_continuous() +
  labs(x = "Year",
       y = "Population",
       title = "Jail Population by Race in the US Over Time",
       color = "Race")
race_comp

black_before_pop <- race %>% 
  filter(year == 1985) %>% 
  pull(black)
black_before_pop

black_after_pop <- race %>% 
  filter(year == 2018) %>% 
  pull(black)
black_after_pop

black_comp <- black_after_pop / black_before_pop
black_comp

white_before_pop <- race %>% 
  filter(year == 1985) %>% 
  pull(aapi)
white_before_pop

white_after_pop <- race %>% 
  filter(year == 2018) %>% 
  pull(aapi)
white_after_pop

white_comp <- white_after_pop / white_before_pop
white_comp