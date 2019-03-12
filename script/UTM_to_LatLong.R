#Convert UTMs to Lat/Long
library(tidyverse)
HistSampleLakes <- read_csv("data/InvertSamples_MYLfrog.csv")

library(rgdal)

#prepare UTM coordinates matrix
utmcoord <- SpatialPoints(cbind(HistSampleLakes$lake_utm_east, HistSampleLakes$lake_utm_north), proj4string = CRS("+proj=utm +zone=11"))

#utmdata$X and utmdata$Y are corresponding to UTM Easting and Northing, respectively.
#zone = UTM zone

#Converting
all_lakes_latlong <- spTransform(utmcoord,CRS("+proj=longlat"))
write.csv(all_lakes_latlong, file = "HistSampleLakes_LongLatCoord")

NoRASI <- filter(HistSampleLakes, HistSampleLakes$ramurasi == "No")

NoRASI_utm <- SpatialPoints(cbind(NoRASI$lake_utm_east, NoRASI$lake_utm_north), proj4string = CRS("+proj=utm +zone=11"))

NoRASI_latlong <- spTransform(NoRASI_utm, CRS("+proj=longlat"))
write.csv(NoRASI_latlong, file = "data_output/NoRASI_latlong.csv")
