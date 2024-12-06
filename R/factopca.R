#' @title FactoPCA
#' @description
#' This function executes a PCA on a given dataframe.
#' 
#' @param data a dataframe with quantitative values
#' @param col_rownames a column name of qualitative values to use as rownames
#' 
#' @export
#' @return a FactoMineR PCA object

factopca <- function(data, col_rownames){
  
  if(exists("col_rownames")){
    rownames(data) <- data[,col_rownames]
    data <- data[, -grep(pattern = col_rownames,
                         x = colnames(data))]
    
    pca_output <- FactoMineR::PCA(X = data, scale.unit = T)
  } else {
    
    pca_output <- FactoMineR::PCA(X = data[,sapply(data, typeof) == "double"], 
                    scale.unit = T)
  }
  return(pca_output)
}
