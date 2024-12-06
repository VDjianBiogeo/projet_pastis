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

unique_zipcodes = function(data, col) {
  data = as.data.frame(data)
  zipcodes_vec = as.numeric(stats::na.omit(as.numeric(unique(unlist(data[,col])))))
  return(zipcodes_vec)
}

################################ 

#' @title Extract cities coordinates from zip codes
#' 
#' @description
#' This function extract cities coordinates from a given dataset from given zip codes.
#' 
#' @param data Dataset containing cities informations.
#' @param zipcode_col_name The name of the column containing zip codes.
#' @param zipcodes_vec Vector containing zip codes.
#' 
#' @export
#' 

extract_coordinates_from_zipcode = function(data, zipcode_col_name, zipcodes_vec) {
  data = as.data.frame(data)
  zipcodes_vec = as.numeric(zipcodes_vec)
  
  # Subset data by zip codes
  data_sub = subset(x = data, subset = data[,zipcode_col_name] %in% zipcodes_vec)
  
  return(data_sub)
}

################################ 

#' @title Join cities and survey data
#' 
#' @description
#' This function extract cities coordinates from a given dataset from given zip codes.
#' 
#' @param data Dataset containing cities informations.
#' @param zipcode_col_name The name of the column containing zip codes.
#' @param zipcodes_vec Vector containing zip codes.
#' 
#' @export
#' 

join_cities_survey = function(cities_data, survey_data, type) {
  # Cities data
  cities_data_sub = subset(x = cities_data, select = c(city_code, zip_code, latitude, longitude))
  cities_data_sub$city_code = stringr::str_replace_all(string = cities_data_sub$city_code, pattern = " 01", replacement = "")
  
  # Data
  town_var = paste0(type, '_town')
  code_var = paste0(type, '_code')
  select_colums = c("name", town_var, code_var)
  data = subset(x = survey_data, select = select_colums)
  
  colnames(data) = c("id", "town", "zipcode")
  data$town = tolower(data$town)
  
  # Joined data
  joined_data = dplyr::inner_join(x = data, y = cities_data_sub,
                                  by = dplyr::join_by(town == city_code, zipcode == zip_code),
                                  relationship = "many-to-many") |>
    unique()
  
  colnames(joined_data) = c("id", paste(colnames(joined_data)[-1], type, sep = "_"))
  
  return(joined_data)
}

################################ 

#' @title Join data on id
#' 
#' @description
#' This function extract cities coordinates from a given dataset from given zip codes.
#' 
#' @param data_list List of datasets to merge on a specific column.
#' @param col_id Name of the key column.
#' 
#' @export
#' 

join_coord_data = function(data_list, col_id) {
  len = length(data_list)
  joined_data = data_list[[1]]
  
  for (i in 2:len) {
    joined_data = dplyr::left_join(x = joined_data, y = data_list[[i]], by = col_id)
  }
  
  return(joined_data)
}

################################ 

#' @title Gather data
#' 
#' @description
#' This function extract cities coordinates from a given dataset from given zip codes.
#' 
#' @param data Data
#' 
#' @export
#'

pivot_data = function(data) {
  # Transformation
  data_long = data |> 
    tidyr::pivot_longer(
      cols = -id, # All columns except `id`
      names_to = c(".value", "location"), # Create columns for each type of data
      names_sep = "_" # Separator
    ) |> as.data.frame()
  
  return(data_long)
}

