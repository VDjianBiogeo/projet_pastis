# Setup ----

## Load package and function ----
library(targets)
tar_config_set(store = here::here("outputs", "pipeline"), 
               script = here::here("analyses", "pipeline.R"))

## Launch pipeline ----
tar_make()

