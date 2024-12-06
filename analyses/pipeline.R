library(targets)
library(tarchetypes)

# Configuration ----
tar_source()

# Defining pipeline ----
list(
  ## Meteo data ----
  ### Read data
  tar_target(name = meteo_data, 
             command = read_data(path = here::here("data", "meteo.txt"), 
                                 header = TRUE, dec = ",", sep = "\t")),
  
  ### Make a PCA
  tar_target(name = pca_meteo,
             command = factopca(meteo_data, "Ville")),
  ### Plot graph
  tar_target(name = pca_meteo_graph,
             command = multivariate_plot(pca_meteo)),
  
  ### Map PCA values on France
  tar_target(name = pca_map,
             command =  mapping_pca(pca_meteo)),
  
  ## Survey and Cities data ----
  ### Read survey data
  tar_target(name = survey_data, 
             command = read_data(path = here::here("data", "survey_data.csv"), header = TRUE, dec = ",", sep = ";")),
  
  ### Extract zipcodes
  tar_target(name = zipcodes, 
             command = unique_zipcodes(data = survey_data, col = 1:(dim(survey_data)[2]-1))),
  
  ### Read cities data
  tar_target(name = cities_data, 
             command = read_data(path = here::here("data", "cities.csv"), header = TRUE)),
  
  ### Extract cities from zipcodes
  tar_target(name = cities_data_extract, 
             command = extract_coordinates_from_zipcode(data = cities_data, zipcode_col_name = "zip_code", zipcodes_vec = zipcodes)),
  
  ### Combine data
  tar_target(name = childhood_data, command = join_cities_survey(cities_data = cities_data_extract, survey_data = survey_data, type = "childhood")),
  tar_target(name = present_data,   command = join_cities_survey(cities_data = cities_data_extract, survey_data = survey_data, type = "present")),
  tar_target(name = south_data,     command = join_cities_survey(cities_data = cities_data_extract, survey_data = survey_data, type = "south")),
  tar_target(name = north_data,     command = join_cities_survey(cities_data = cities_data_extract, survey_data = survey_data, type = "north")),
  tar_target(name = east_data,      command = join_cities_survey(cities_data = cities_data_extract, survey_data = survey_data, type = "east")),
  tar_target(name = west_data,      command = join_cities_survey(cities_data = cities_data_extract, survey_data = survey_data, type = "west")),
  
  ### Create a joined data with all informations
  tar_target(name = combine_coord_data, 
             command = join_coord_data(data_list = list(childhood_data, present_data, south_data, north_data, east_data, west_data), col_id = "id")),
  
  ### Transform data
  tar_target(name = coord_data_long, 
             command = pivot_data(data = combine_coord_data, col_id = "id")),
  tar_target(name = coord_data, command = pivot_data_w(data = coord_data_long, 
                                                       col_to_keep = c("id", "location", "latitude", "longitude"), 
                                                       names = "location", 
                                                       values = c("latitude", "longitude"))),
  
  ### Make a PCA
  tar_target(name = pca_survey,
             command = factopca(coord_data[,c(1, grep(pattern = "_south", x = colnames(coord_data)))], "id")),
  ### Plot graph
  tar_target(name = pca_survey_graph,
             command = multivariate_plot(pca_survey)),
  
  ### Map PCA values on France
  tar_target(name = pca_map_survey,
             command =  mapping_survey_pca(pca_survey)),
  
  ### Render Quarto documents
  tarchetypes::tar_quarto(name = index_quarto, 
                          path = "meteo_summary.qmd")
)
