#this project is just me introducing myself to mapbox through the mapdeck package
if(!require(pacman)) install.packages('pacman')
p_load(
  tidyverse,  #tidy tools
  RSocrata,   #accesing data
  lubridate,  #date helpers
  sf,         #geo data
  mapdeck     #interactive maps
)

### Load Data -------------------------------------------------------------------------------------
source(file.path('RCode', '01-Data.R')) #load Nashville crime dataset
source(file.path('mapdeck_key.R')) #load mapdeck key

## Explore Mapdeck --------------------------------------------------------------------------------
source(file.path('RCode', '02-Layers.R'))