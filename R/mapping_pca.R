#' @title mapping_pca
#' 
#' @description
#' This function uses pca data from our PCA on french towns to create a map
#' of the first PCA axis' coordinates for our towns.
#' 
#' @param pca_data an output from the FactoMineR::PCA function
#' 
#' @export
#' 
#' @return a ggplot2 object
#' @import ggplot2
#' 

mapping_pca <- function(pca_data){
  library(ggplot2)
  
  # Download France shapefile
  france <- geodata::gadm(country = "FRA",
                level = 1,
                path = here::here("data"))
  
  # Importing PCA coordinates
  row_coord <- as.data.frame(pca_data$ind)[,1:5]
  row_coord$label <- tolower(rownames(row_coord))
  
  # Get list of towns to extract coordinates for
  list_cities <- unique(row_coord$label)
  
  # Importing spatial coordinates for french towns
  xy <- read.csv(here::here("data", "cities.csv"))[,c("label",
                                                      "longitude",
                                                      "latitude")]
  
  xy <- xy[xy$label %in% list_cities,] |> 
    unique() |>
    dplyr::group_by(label) |>
    dplyr::summarise(x = mean(longitude), y = mean(latitude)) |>
    as.data.frame()
  
  # Joining dataframes
  mapping_data <- dplyr::inner_join(x = row_coord,
                            y = xy, 
                            by = "label")
  
  map <- ggplot() +
    geom_sf(data = sf::st_as_sf(france)) +
    geom_point(aes(x = x,
                   y = y,
                   fill = `coord.Dim.1`),
               pch = 23, color = 'black', size = 4,
               data = mapping_data) +
    ggrepel::geom_label_repel(aes(x = x,
                                  y = y,
                                  label = label),
                              data = mapping_data) +
    scale_fill_viridis_c() +
    coord_sf(expand = F, crs = 4326) +
    theme_minimal() +
    theme(axis.title = element_blank()) +
    labs(fill = "Coordinates on\nfirst PCA's axis")
  
  ggsave(filename = here::here("figures",
                               "pca_mapping.jpg"),
         plot = map,
         width = 8,
         height = 8,
         units = "in",
         dpi = "retina")
  
  return(map)
}