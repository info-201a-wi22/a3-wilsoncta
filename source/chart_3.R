setwd("c:/Users/ohhay/OneDrive/Documents/INFO201/a3-wilsoncta/source")

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
View(incarceration)

library(shiny)
library(stringr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(leaflet)

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

abb2name <- function(abb) {
  str_to_lower(state.name[grep(abb, state.abb)])
}

recent <- incarceration %>% 
  select(year, fips, state, county_name, yfips, total_jail_adm) %>% 
  filter(year == 2018) %>% 
  mutate(region = as.character(sapply(state, abb2name)),
         subregion = str_to_lower(str_replace(county_name, " County", "")))
View(recent)

map <- map_data("county") %>% 
  left_join(recent)
View(map)

map <- leaflet(data = incarceration) %>%
  addTiles() %>% 
  addMarkers(
    lat = ~lat,
    lng = ~long,
    label = ~paste("Total Jail Admissions")
  )
  
  addProviderTiles("Stamen.TonerLite") %>% # add Stamen Map Tiles
  addCircleMarkers( # add markers for each shooting
    lat = ~lat,
    lng = ~long,
    label = ~paste0(name, ", ", age), # add a hover label: victim's name and age
    color = ~palette_fn(shootings[["race"]]), # color points by race
    fillOpacity = .7,
    radius = 4,
    stroke = FALSE
  ) %>%
  addLegend( # include a legend on the plot
    position = "bottomright",
    title = "race",
    pal = palette_fn, # the palette to label
    values = shootings[["race"]], # again, using double-bracket notation
    opacity = 1 # legend is opaque
  )
