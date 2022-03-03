setwd("c:/Users/ohhay/OneDrive/Documents/INFO201/a3-wilsoncta/source")

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
View(incarceration)

library(shiny)
library(stringr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(leaflet)
library(tidyverse)
library(maps)
library(usmap)
library(mapproj)

max_jail_adm <- incarceration %>% #Which county has the highest total jail admission
  filter(year == 2018, na.rm = TRUE) %>% 
  filter(total_jail_adm == max(total_jail_adm, na.rm = TRUE)) %>%
  pull(county_name)
max_jail_adm

min_jail_adm <- incarceration %>% #Which county has the lowest total jail admission
  filter(year == 2018, na.rm = TRUE) %>% 
  filter(total_jail_adm == min(total_jail_adm, na.rm = TRUE)) %>% 
  pull(county_name)
View(min_jail_adm)

blank_theme <- theme_bw() +
  theme ( 
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank (),
    panel.border = element_blank())

jail_adm <- incarceration %>%
  select(year, fips, state, county_name, total_jail_adm) %>%
  filter(year == 2018)

county <- map_data("county") %>%
  unite(polyname, region, subregion, sep = ",") %>%
  left_join(county.fips, by = "polyname")

map <- county %>%
  left_join(jail_adm, by = "fips")
View(map)

test <- map %>% 
  ggplot(mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = map$total_jail_adm)) + 
  coord_quickmap() + 
  scale_fill_continuous(limits= c(0, max(map$total_jail_adm)))+
  blank_theme +
  labs(title = "Jail Admissions in the United States by County in 2018", fill = "total_jail_pop",
       total_jail_adm = "Total Jail Population") #How to change legend title
test
