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
  geom_line(mapping = aes(x = year, y = avg)) +
  geom_line(mapping = aes(x = year, y = pop_avg)) +
  labs(x = "Year",
       y = "Population",
       title = "General Population and Jail Population in the US Over Time") #How do I make a legend?
comp_plot

race <- incarceration %>%
  select(year, aapi_jail_pop, black_jail_pop, latinx_jail_pop, native_jail_pop, white_jail_pop, total_jail_adm) %>% 
  group_by(year) %>% 
  na.omit() %>% 
  mutate(avg_appi_jail_pop = mean(aapi_jail_pop)) %>% 
  mutate(avg_black_jail_pop = mean(black_jail_pop)) %>% 
  mutate(avg_latinx_jail_pop = mean(latinx_jail_pop)) %>% 
  mutate(avg_native_jail_pop = mean(native_jail_pop)) %>% 
  mutate(avg_white_jail_pop = mean(white_jail_pop)) %>% 
  pivot_longer(col = c(avg_appi_jail_pop, avg_black_jail_pop, avg_latinx_jail_pop, avg_native_jail_pop, avg_white_jail_pop),
               names_to = "race and ethnicity") #What does 'value' mean?
View(race)

race <- incarceration %>%
  select(year, aapi_jail_pop, black_jail_pop, latinx_jail_pop, native_jail_pop, white_jail_pop, total_jail_adm) %>% 
  filter(year == 2018) %>% 
  na.omit() %>% 
  mutate(avg_appi_jail_pop = mean(aapi_jail_pop)) %>% 
  mutate(avg_black_jail_pop = mean(black_jail_pop)) %>% 
  mutate(avg_latinx_jail_pop = mean(latinx_jail_pop)) %>% 
  mutate(avg_native_jail_pop = mean(native_jail_pop)) %>% 
  mutate(avg_white_jail_pop = mean(white_jail_pop)) %>% 
  pivot_longer(col = c(avg_appi_jail_pop, avg_black_jail_pop, avg_latinx_jail_pop, avg_native_jail_pop, avg_white_jail_pop),
               names_to = "race and ethnicity") #What does 'value' mean?
View(race)

racial_inequity <- race %>% 
  ggplot(mapping = aes(x = total_jail_adm, y = race, fill = race)) +
  geom_line() +
  labs(x = "hi",
       y = "hi",
       title = "hi")
racial_inequity
