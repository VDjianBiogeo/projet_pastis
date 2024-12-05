library(targets)
library(tarchetypes)

# Configuration ----
tar_source()

# Defining pipeline ----
list(
  ## Cities data ----
  tar_target(name = cities_data, command = read_data(path = here::here("data", "cities.csv"), header = TRUE)),
  
  ## Meteo data ----
  tar_target(name = meteo_data, command = read_data(path = here::here("data", "meteo.txt"), header = TRUE, dec = ",")),
  
  ## Make a PCA on meteo data ----
  tar_target(name = pca_meteo,
             command = factopca(meteo_data, 
                                "Ville")),
  
  tar_target(name = pca_meteo_graph,
             command = multivariate_plot(pca_meteo))
)