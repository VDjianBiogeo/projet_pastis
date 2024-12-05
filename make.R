# Setup ----

## Load package and function ----
library(targets)
targets::tar_config_set(store = here::here("outputs", "pipeline"), 
               script = here::here("analyses", "pipeline.R"))

## Launch pipeline ----
targets::tar_make()

## Visualisation ----
targets::tar_visnetwork()
