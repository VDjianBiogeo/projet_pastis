#' @title Read data
#' 
#' @description
#' This function read a csv or a txt file.
#' 
#' @param path The path to the dataset. The dataset should be a CSV or a TXT file
#'
#' @return The dataset (`data.frame`).
#' @export
#' 
#' @importFrom readr read_csv
#' 

read_data = function(path, header = FALSE, dec = ".", sep = ",") {
  
  if (stringr::str_detect(string = path, pattern = ".csv")) {
    data = read.csv(file = path, header = header, dec = dec, sep = sep)
  } else if (stringr::str_detect(string = path, pattern = ".txt")) {
    data = read.table(file = path, header = header, dec = dec, sep = sep)
  }

  return(as.data.frame(data))
}

