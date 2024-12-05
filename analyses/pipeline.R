library(targets)
library(tarchetypes)

# Configuration ----
tar_source()

# Defining pipeline ----
list(
  ## Meteo data ----
  ### Read data
  tar_target(name = meteo_data, command = read_data(path = here::here("data", "meteo.txt"), header = TRUE, dec = ",")),
  
  ### Make a PCA
  tar_target(name = pca_meteo,
             command = factopca(meteo_data, 
                                "Ville")),
  ### Plot graph
  tar_target(name = pca_meteo_graph,
             command = multivariate_plot(pca_meteo)),
  
  ## Survey and Cities data ----
  ### Read cities data
  tar_target(name = cities_data, command = read_data(path = here::here("data", "cities.csv"), header = TRUE)),
  
  ### Read survey data
  tar_target(name = survey_data, command = read_data(path = here::here("data", "survey_data.csv"), header = TRUE, dec = ";"))
  
  ### Combine data
  
)