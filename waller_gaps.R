library(leaflet)
library(rgdal)
library(magrittr)
library(mapview)
old.plan <- data.frame(
    "lat" = c(
      30.09660,
      30.06318,
      29.78419,
      30.16720,
      29.96887,
      29.79082
    ), 
    "lng" = c(
      -96.07330,
      -95.92418,
      -95.95013,
      -95.93049,
      -95.99348,
      -95.82107
    ), 
    "names" = c(
      "Waller County Courthouse",
      "Waller ISD Admin Building",
      "Waller County Library at Brookshire",
      "Fieldstore Elementary School",
      "Monaville Fire Dept",
      "Katy VFW Hall"
    )
  )

new.plan <- data.frame(
  "lat" = c(
    30.09739,
    30.07274,
    29.91781,
    30.11524,
    29.78419,
    30.16720
  ), 
  "lng" = c(
    -96.07612,
    -95.99291,
    -95.99395,
    -95.84133,
    -95.95013,
    -95.93049
  ), 
  "names" = c(
    "Waller County Annex",
    "Memorial Student Center",
    "Adam’s Flat Building",
    "Turlington Elementary School",
    "Waller County Library at Brookshire",
    "Fieldstore Elementary School"
  )
)

precincts <- readOGR("precinct/Precincts.shp")
waller.county <- subset(precincts, precincts$CNTY %in% c("473"))
waller.county <- spTransform(waller.county,CRS("+init=epsg:4326"))
leaflet() %>%
  addProviderTiles('CartoDB.Positron') %>%
  addMarkers(data = old.plan, lng = ~lng, lat = ~lat, group = "Waller County Locations", popup = ~names) %>%
  addMarkers(data = new.plan, lng = ~lng, lat = ~lat, group = "Optimized Locations", popup = ~names) %>%
  addPolygons(data = waller.county, fillColor = "#319CF4", color = "#000000", weight = 1, popup = paste("Precinct #: ", waller.county$PREC)) %>%
  addLogo(img = "http://januaryadvisors.com/wp-content/uploads/2013/05/ja-og.png", position = c("bottomleft"), offset.x = 10, offset.y = 10, width = 90, height = 90, alpha = 0.9) %>%
  addLayersControl(baseGroups = c("Waller County Locations","Optimized Locations"),options = layersControlOptions(collapsed = FALSE))
