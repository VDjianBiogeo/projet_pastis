#' @title Plotting a multivariate graph
#' @description
#' This function takes a PCA analysis output from the FactoMineR R package
#' and plot the individuals' coordinates.
#' 
#' @param multi_output an FactoMineR PCA analysis object
#' 
#' @return a ggplot2 graphic object
#' @export
#' 

multivariate_plot <- function(multi_output){
  
  row_coord <- as.data.frame(multi_output$ind) 
  col_coord <- as.data.frame(multi_output$var)
  eig_percent <- as.data.frame(multi_output$eig)
  
  library(ggplot2)
  
  multi_plot <- ggplot() +
    geom_hline(aes(yintercept = 0), linetype = 2) +
    geom_vline(aes(xintercept = 0), linetype = 2) +
    # geom_point(aes(x = `coord.Dim.1`,
    #                y = `coord.Dim.2`),
    #            pch = 23, color = "black", size = 3,
    #            data = row_coord) +
    ggrepel::geom_label_repel(aes(x = `coord.Dim.1`,
                                  y = `coord.Dim.2`,
                                  label = rownames(row_coord)),
                              data = row_coord) +
    theme_bw(base_size = 18) +
    labs(x = paste0("Dim1 (",
                    round(eig_percent[1,2], digits = 2),
                    "%)"),
         y = paste0("Dim2 (",
                    round(eig_percent[2,2], digits = 2),
                    "%)"))

  ggsave(filename = here::here("figures",
                               "pca meteo villes.png"),
         plot = multi_plot,
         dpi = "retina",
         units = "px",
         height = 2940,
         width = 3660)
  
  return(multi_plot)
}
