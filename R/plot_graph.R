################################ 

#' @title Pivot coordinates data in a longer shape.
#' 
#' @description
#' This function pivot the coordinates data in a longer shape. A key column 
#' must be set.
#' 
#' @param data Coordinates data.
#' @param col_to_keep Names of columns to keep.
#' @param names Columns containing the names of the columns to create
#' @param values Columns containing the values
#' 
#' @export
#'

plot_coord = function(data) {
  library(ggplot2)
  
  PLOT = ggplot(data = data) +
    coord_cartesian(ylim = c(40, 55)) +
    aes(x = location, y = latitude) +
    geom_boxplot() +
    theme_bw()
  
  return(PLOT)
}