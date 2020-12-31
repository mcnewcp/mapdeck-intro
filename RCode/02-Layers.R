#exploring possible layer options

#3d grid
mapdeck(token = mapdeck_key, style = mapdeck_style("dark"), pitch = 45) %>%
  add_grid(
    data = mapSF,
    cell_size = 500,
    elevation_scale = 50,
    layer_id = "grid_layer"
)

#heat map
mapdeck(token = mapdeck_key, style = mapdeck_style('dark'), pitch = 45 ) %>%
  add_heatmap(
    data = mapSF
)

#points
mapdeck(token = mapdeck_key, style = mapdeck_style('dark'), pitch = 45) %>%
  add_polygon(
    data = tractSF,
    fill_colour = "incidents", fill_opacity = 0.9999
    # elevation = "incidents", elevation_scale = 30
  ) %>%
  add_scatterplot(
    data = mapSF,
    fill_colour = "#FFFFFF",
    radius = 150,
    tooltip = "tooltip"
  )

#3d aggregations
mapdeck(token = mapdeck_key, style = mapdeck_style('dark'), pitch = 45) %>%
  add_polygon(
    data = tractSF,
    fill_colour = "incidents", fill_opacity = 0.5,
    elevation = "incidents", elevation_scale = 30,
    tooltip = "tooltip"
) 
mapdeck(token = mapdeck_key, style = mapdeck_style('dark'), pitch = 45) %>%
  add_polygon(
    data = blockgroupSF,
    fill_colour = "incidents", fill_opacity = 0.5,
    elevation = "incidents", elevation_scale = 30,
    tooltip = "tooltip"
) 
mapdeck(token = mapdeck_key, style = mapdeck_style('dark'), pitch = 45) %>%
  add_polygon(
    data = votingdistrictSF,
    fill_colour = "incidents", fill_opacity = 0.5,
    elevation = "incidents", elevation_scale = 30,
    tooltip = "tooltip", 
    legend = TRUE,
    legend_options = list(
      fill_colour = list(title = "Incident <br/>Count", digits = 0)
    )
) 
