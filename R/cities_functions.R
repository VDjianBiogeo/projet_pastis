#' @title Unique zip codes
#' 
#' @description
#' This function extract zip codes from a given dataset.
#' 
#' @param data Dataset containing zip codes.
#' 
#' @export
#' 
#' @importFrom stats na.omit

unique_zipcodes = function(data) {
  data = as.data.frame(data)
  zipcodes_vec = stats::na.omit(as.numeric(unique(unlist(data))))
  return(zipcodes_vec)
}

################################ 

#' @title Unique zip codes
#' 
#' @description
#' This function extract zip codes from a given dataset.
#' 
#' @param data Dataset containing zip codes.
#' 
#' @export
#' 
#' @importFrom stats na.omit

extract_coordinates_from_zipcode = function(data) {
  
}