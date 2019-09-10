library(leaflet)
df <- cleaned_dataset
index <- sample(1:nrow(df), 10000)
data <- df[index,]
data$popup <- paste("<b>Incident #: </b>", data$trip_id, "<br>", 
                    "<br>", "<b>Description: </b>", data$trip_route_category,
                    "<br>", "<b>Day of week: </b>", data$start_time_day_name,
                    "<br>", "<b>Date: </b>", data$trip_start_date,
                    "<br>", "<b>Time: </b>", data$start_time,
                    "<br>", "<b>Longitude: </b>", data$start_lat,
                    "<br>", "<b>Latitude: </b>", data$start_lon)

m <- leaflet(data, height=800 ,width = "100%") %>% addTiles() %>%
  addTiles(group = "OSM (default)") %>%
  #addProviderTiles(provider = "Esri.WorldStreetMap",group = "World StreetMap") %>%
 # addProviderTiles(provider = "Esri.WorldImagery",group = "World Imagery") %>%
  # addProviderTiles(provider = "NASAGIBS.ViirsEarthAtNight2012",group = "Nighttime Imagery") %>%
  addMarkers(lng = ~start_lon, lat = ~start_lat, popup = data$popup, clusterOptions = markerClusterOptions())
library(htmlwidgets)
saveWidget(m, file="m.html")