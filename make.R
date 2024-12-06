# Setup ----

## Load package and function ----
targets::tar_config_set(store = here::here("outputs", "pipeline"),
                        script = here::here("analyses", "pipeline.R"))

## Pre visualisation ----
targets::tar_visnetwork()

## Launch pipeline ----
targets::tar_make()

## Post visualisation ----
targets::tar_visnetwork()

quarto::quarto_render(input = here::here("index.qmd"))
