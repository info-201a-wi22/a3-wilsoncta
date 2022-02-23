setwd("~/INFO_201/a3-wilsoncta/source")

incarceration <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
View(incarceration)

library(dplyr)
library(tidyr)
library(ggplot2)
