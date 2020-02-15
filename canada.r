# Creates a map based on Road Designation
# Takes in .dbf and .shp files and colors them
# specifically for Canada

library(sf)
library(foreign)
library(tidyverse)
library(lwgeom)
options(stringsAsFactors = FALSE)

# download + unzip SHP file of whatever province
# https://open.canada.ca/data/en/dataset/82efb454-3241-4440-a5d4-8b03a42f4df8

# set the working directory 
setwd("C:/Users/jrao1/Desktop/RoadsProject/Canada/bc")

# change this to the name of the files you downloaded (sans suffix)
filename <- "grnf059r08a_e"

# pick a lat/long to be at the center of your map. this point is in Saskatoon
lat <- 49.261075
long <- -123.121158

# pick a radius to plot the roads in (in meters)
rad <- 12000

# pick the road types
plottypes <-  c('HWY', 'RD', 'AVE', 'ST', 'DR', 'CRES', 'TRAIL', 'LINE')

# set colors for each road type
plotcolors <-  c('HWY' = '#FE4D64', 'RD' = '#4cb580', 'AVE' ='#59c8e5', 'ST' = '#fed032', 'DR' = '#a7abfe',
                 'CRES' = '#fe9ea5', 'TRAIL' = '#2e968c', 'LINE' = '#ff9223', 'Other' = '#cccccc')

#---------------CODE---------------
# import road geography
allroads <- read_sf(".", filename)
allroads$len <- st_length(allroads)

# subset the roads into a circle. remove to plot the entire region
pt <- data.frame(lat = lat, long = long)
pt <- pt %>% st_as_sf(coords = c("long", "lat"), crs = 4326) %>%  st_transform(32195)
circle <- st_buffer(pt, dist = rad)
circle <- circle %>% st_transform(st_crs(allroads))
allroads <- st_intersection(circle, allroads)

# put other roads into their own dataframe
allroads$TYPE[!(allroads$TYPE %in% plottypes)] <- "Other"
otherroads <- allroads[(allroads$TYPE  == "Other"),]
allroads <- allroads[(allroads$TYPE  != "Other"),]

# plot it
blankbg <-theme(axis.line=element_blank(),axis.text.x=element_blank(),
                axis.text.y=element_blank(),axis.ticks=element_blank(),
                axis.title.x=element_blank(), axis.title.y=element_blank(),
                panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
                panel.grid.minor=element_blank(),plot.background=element_blank())

# set the canvas size
ggplot() + blankbg + theme(panel.grid.major = element_line(colour = "transparent")) +
  geom_sf(data=otherroads, size = 1.5, aes(color=TYPE)) +
  geom_sf(data=allroads, size = 1.5, aes(color=TYPE)) +
  scale_color_manual(values = plotcolors, guide = FALSE)

ggsave("myplot.png", plot = last_plot(),
       scale = 1, width = 36, height = 42, units = "in",
       dpi = 500)
