### Nashville Crime Data
#pull max date
max_dt <- read.socrata("https://data.nashville.gov/resource/2u6v-ujjs.csv?$order=incident_occurred DESC &$limit=10") %>% 
  pull(incident_occurred) %>%
  max(na.rm=TRUE)
#now pull n most recent weeks of data
n <- 3
start_dt <- max_dt - weeks(n)
dataDF <- read.socrata(paste0(
  "https://data.nashville.gov/resource/2u6v-ujjs.csv?$order=incident_occurred DESC &$where=incident_occurred >", 
  "'", format.POSIXct(start_dt, format = "%Y-%m-%dT%H:%M:%S"), "'"
))
mapSF <- dataDF %>%
  #drop blank coords
  filter(!is.na(longitude) | !is.na(latitude)) %>%
  #drop coord errors (i.e. coords way outside of Nashville)
  filter(latitude > 35 & latitude < 36.7) %>%
  filter(longitude > -87.7 & longitude < -85.7) %>%
  #it seems like there are multiple entries for a given coord at the same time
  #for the sake of geo calcs, I'm keeping one entry per coord per datetime
  distinct(incident_occurred, latitude, longitude, .keep_all = TRUE) %>%
  #make sf object
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326)
rm(dataDF, max_dt, n, start_dt)

#load Nashville census polygon data
polyLS <- readRDS(gzcon(url("https://github.com/mcnewcp/Nashville-census-tracts/blob/master/Nashville_Census_Polygons_2019.RDS?raw=true")))
#census tracts
tractSF <- polyLS$tract %>%
  #count points in each polygon
  mutate(incidents = lengths(st_intersects(., mapSF)))
#census block groups
blockgroupSF <- polyLS$block_group %>%
  #count points in each polygon
  mutate(incidents = lengths(st_intersects(., mapSF)))
#census voting districts
votingdistrictSF <- polyLS$voting_district %>%
  #count points in each polygon
  mutate(incidents = lengths(st_intersects(., mapSF)))
rm(polyLS)
