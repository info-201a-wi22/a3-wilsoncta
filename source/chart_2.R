setwd("~/INFO_201/a3-wilsoncta/source")

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
View(incarceration)

library(dplyr)
library(tidyr)
library(ggplot2)



#race <- incarceration %>%
#  select(year, aapi_jail_pop, black_jail_pop, latinx_jail_pop, native_jail_pop, white_jail_pop) %>% 
#    group_by(year) %>% 
#    na.omit() %>% 
#      mutate(avg_appi_jail_pop = mean(aapi_jail_pop)) %>% 
#      mutate(avg_black_jail_pop = mean(black_jail_pop)) %>% 
#      mutate(avg_latinx_jail_pop = mean(latinx_jail_pop)) %>% 
#      mutate(avg_native_jail_pop = mean(native_jail_pop)) %>% 
#      mutate(avg_white_jail_pop = mean(white_jail_pop)) %>% 
#    pivot_longer(col = c(avg_appi_jail_pop, avg_black_jail_pop, avg_latinx_jail_pop, avg_native_jail_pop, avg_white_jail_pop),
#      names_to = "race and ethnicity") #What does 'value' mean?
#race

#racial_inequity <- race %>% 
#  ggplot(mapping = aes(x = , y = , fill() = )) +
#    geom_bar() +
#    labs(x = "",
#         y = "",
#         title = "")

black_pop <- incarceration %>%
  group_by(year) %>% 
  summarise(avg = mean(black_jail_pop, na.rm = TRUE))

white_pop<- incarceration %>%
  na.omit() %>% 
  group_by(year) %>% 
  summarise(avg = mean(white_jail_pop, na.rm = TRUE))

racial_inequity <- ggplot(mapping = aes(x = black_pop, y = white_pop)) +
  geom_point() +
  labs(x = "Year",
       y = "Total Jail Population",
       title = "Total Jail Population vs. Year")
racial_inequity