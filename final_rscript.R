# tabula rasa
rm(list = ls()) #clears environment
cat("\014") #clears console


library(dplyr)
library(leaflet)
library(sf)
library(rgdal)


setwd("C:\\Users\\tuo27112\\OneDrive - Temple University\\Geoviz\\Labs\\final\\")

trees <- rgdal::readOGR("PPR_Tree_inventory_2021.geojson")

trees_df <- as.data.frame(trees)

data1 <- trees_df[grep("HEAVEN", trees_df$TREE_NAME), ]

trees_subset <- trees_df %>% 
  dplyr::filter(TREE_NAME == "AILANTHUS ALTISSIMA - TREE OF HEAVEN")

tg(trees_subset, "trees_sub_geo", c(LOC_X, LOC_Y))

trees_subset.SP  <- SpatialPointsDataFrame(trees_subset[,c(5,6)],trees_subset[,-c(6,5)])
str(trees_subset.SP) # Now is class SpatialPointsDataFrame

#Write as geojson
writeOGR(trees_subset.SP, 'heaven.geojson','heaven', driver='GeoJSON', overwrite_layer = TRUE)
