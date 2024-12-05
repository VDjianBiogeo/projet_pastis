# Pastis project


> [!IMPORTANT]  
> This project is the result of the Practice 2 of the training course
> [Reproducible Research in Computational Ecology](https://rdatatoolbox.github.io).



This project aims to download the [PanTHERIA](https://doi.org/10.1890/08-1494.1) 
database (Jones _et al._, 2009) and the 
[WWF WildFinder](https://www.worldwildlife.org/pages/wildfinder-database) 
database (World Wildlife Fund 2006). It is structured as a research compendium 
to be reproducible.



## Content

This project is structured as follow:

```
.
├─ README.md                                  # Presentation of the project
├─ DESCRIPTION                                # Project metadata
├─ LICENSE.md                                 # License of the project
|
├─ data/                                      # Contains raw data
|  ├─ survey/                              # Survey database
|  |  └─ survey_data.csv
|  |
|  └─ wildfinder/                             # WWF WildFinder database
|     ├─ wildfinder-ecoregions_list.csv
|     ├─ wildfinder-ecoregions_species.csv
|     └─ wildfinder-mammals_list.csv
|
├─ R/                                         # Contains R functions (only)
|  ├─ count_ecoregions.R                      # Function to count ecoregions per species
|  ├─ dl_wildfinder_data.R                    # Function to download WildFinder data
|  ├─ dl_pantheria_data.R                     # Function to download PanTHERIA data
|  ├─ join_tables.R                           # Function to merge WildFinder tables
|  ├─ plot_counts.R                           # Function to make the barplot
|  ├─ read_data.R                             # Function to import WildFinder tables
|  └─ select_species.R                        # Function to subset WildFinder species
|
├─ analyses/                                  # Contains R scripts
|  └─ download-data.R                         # Script to download raw data
|
├─ index.qmd                                  # Quarto report
├─ index.html                                 # Quarto result (html page)
|
└─ make.R                                     # Script to setup & run the project
```


> [!NOTE]  
> The folder **data/** is not present in this repository (listed in the `.gitignore`) 
> but we provide the code to locally download raw data.



## Installation

To install this compendium:

- [Fork](https://docs.github.com/en/get-started/quickstart/contributing-to-projects)
  this repository using the GitHub interface.
- Open [RStudio IDE](https://posit.co/products/open-source/rstudio/) and create a 
  **New Project** from **Version Control** to [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
  your fork.



## Usage

Open this project in RStudio IDE and launch analyses by running:

```r
source("make.R")
```

- All packages will be automatically installed and loaded
- Raw data will be saved in the `data/` directory



## License

This project is released under the 
[GPL-2](https://choosealicense.com/licenses/gpl-2.0/) license.



## Citation

> Djian V, Dionet T, Morlot P (2024) Projet pastis. URL: <https://github.com/VDjianBiogeo/projet_pastis.git>



## References

Data gouv : Online database of cities coordinates.

Version Dec-05. URL: <https://www.data.gouv.fr/>

World Wildlife Fund (2006) WildFinder: Online database of species distributions. 
Version Jan-06. URL: <https://www.worldwildlife.org/pages/wildfinder-database>.
