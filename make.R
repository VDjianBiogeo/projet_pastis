# Setup ----

## Load package and function ----
library(targets)
targets::tar_config_set(store = here::here("outputs", "pipeline"), 
               script = here::here("analyses", "pipeline.R"))

## Visualisation ----
targets::tar_visnetwork()

## Launch pipeline ----
targets::tar_make()

## Visualisation ----
targets::tar_visnetwork()