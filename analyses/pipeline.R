library(targets)
library(tarchetypes)

# Configuration ----
tar_config_set(store = here::here("outputs", "pipeline"), 
               script = here::here("analyses", "pipeline.R"))
tar_source()

# Defining pipeline ----
list(
  ## Path to meteo data ----
  tar_target(name = meteo_path, 
             here::here("data", "Meteo.txt"), 
             format = "file"),
  
  ## Reading meteo data ----
  tar_target(name = meteo_data, 
             command = read.table(meteo_path, header = T, dec = ",")),
  
  ## Make a PCA on meteo data ----
  tar_target(name = pca_meteo,
             command = factopca(meteo_data, 
                                "Ville")),
  
  tar_target(name = pca_meteo_graph,
             command = multivariate_plot(pca_meteo))
  
  
)