#' @title mapping_survey_pca
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

mapping_survey_pca <- function(pca_data){
  
  library(ggplot2)
  
  # Download France shapefile
  france <- geodata::gadm(country = "FRA",
                          level = 1,
                          path = here::here("data"))
  
  # Importing PCA coordinates
  row_coord <- as.data.frame(pca_data$ind)[,1:5]
  row_coord <- cbind(row_coord,
                     pca_data[["call"]]$X)
  
  map <- ggplot() +
    geom_sf(data = sf::st_as_sf(france)) +
    geom_hline(yintercept = 45.18221, linetype = 2,
               color ='orange', linewidth = 1.5) +
    geom_point(aes(x = "longitude_north",
                   y = "latitude_north"),
               pch = 23, fill = "orange",
               color = 'black', size = 4,
               data = row_coord) +
    ggrepel::geom_label_repel(aes(x = "longitude_north",
                                  y = "latitude_north",
                                  label = rownames(row_coord)),
                              data = row_coord) +
    scale_fill_viridis_c() +
    coord_sf(expand = F, crs = 4326) +
    theme_minimal() +
    theme(axis.title = element_blank())
  
  return(map)
}