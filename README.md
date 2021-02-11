
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rwlts - Web Land Trajectory Service R Client

R client for access to data provided in the Brazil Data Cube Web Land
Trajectory Service.

<!-- badges: start -->

[![Software
License](https://img.shields.io/badge/license-MIT-green)](https://github.com/brazil-data-cube/rstac/blob/master/LICENSE)
[![Travis build
status](https://api.travis-ci.com/OldLipe/rwlts.svg?)](https://travis-ci.com/OldLipe/rwlts)
[![Build
status](https://ci.appveyor.com/api/projects/status/qp5ohssj328vynh0?svg=true)](https://ci.appveyor.com/project/OldLipe/rwlts)
[![codecov](https://codecov.io/gh/OldLipe/rwlts/branch/main/graph/badge.svg?)](https://codecov.io/gh/OldLipe/rwlts)
[![Software Life
Cycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Join us at
Discord](https://img.shields.io/discord/689541907621085198?logo=discord&logoColor=ffffff&color=7389D8)](https://discord.com/channels/689541907621085198#)
<!-- badges: end -->

# About

Information on land use and land cover is essential to support
governments in making decisions about the impact of human activities on
the environment, planning the use of natural resources, conserving
biodiversity and monitoring climate change.

Currently, several projects systematically provide information on the
dynamics of land use and cover. Well known projects include PRODES,
DETER and TerraClass. These projects are developed by INPE and they
produce information on land use and coverage used by the Brazilian
Government to make public policy decisions. Besides these projects there
are other initiatives from universities and space agencies devoted to
the creation of national and global maps.

Although these projects follow open data policies and provide a rich
collection of data, there is still a gap in tools that facilitate the
integrated use of these collections. Each project adopts its own land
use and land cover classification system, providing different class
names and meanings for the elements of these collections. The forms of
distribution of project data can be carried out in different ways,
through files or web services. In addition, the data has different
spatial and temporal resolutions and storage systems (raster or vector).

In this context, the **W**eb **L**and **T**rajectory **S**ervice (WLTS)
is a service that aims to facilitate the access to these vaapproach
consists of using a data model that defines a minimum set of temporal
and spatial information to represent different sources and types of
data, but with a focus on land use and land cover.

WLTS can be used in a variety of applications, such as validating land
cover data sets, selecting training samples to support Machine Learning
algorithms used in the generation of new classification maps.

If you want to know more about WLTS service, please, take a look at its
[specification](https://github.com/brazil-data-cube/wlts-spec).

## Installation

To install the development version of `rwlts`, run the following
commands:

``` r
# load necessary libraries
library(devtools)
install_github("brazil-data-cube/rwlts")
```

Importing `rwlts` package:

``` r
library(rwlts)
```

## Usage

`rwlts` implements the following WLTS operations:

| **WLTS** operations     | `rwlts` functions                          |
| :---------------------- | :----------------------------------------- |
| `/list_collections`     | `list_collections(URL,)`                   |
| `/describe_collections` | `describe_collection(URL, collection_id)`  |
| `/trajectory`           | `get_trajectory(URL, latitude, longitude)` |

These functions can be used to retrieve information from a WLTS service.

The code bellow list the available collections of the WLTS of the
[Brazil Data Cube](http://brazildatacube.org/) project of the Brazilian
National Space Research Institute [INPE](http://www.inpe.br/).

``` r
wlts_bdc <- "https://brazildatacube.dpi.inpe.br/wlts/"

list_collections(wlts_bdc)
#>  [1] "terraclass_amazonia"       "deter_amazonia_legal"     
#>  [3] "deter_cerrado"             "prodes_cerrado"           
#>  [5] "prodes_amazonia_legal"     "lapig_cerrado_pasture"    
#>  [7] "ibge_cobertura_uso_terra"  "mapbiomas5_amazonia"      
#>  [9] "mapbiomas5_cerrado"        "mapbiomas5_caatinga"      
#> [11] "mapbiomas5_mata_atlantica" "mapbiomas5_pampa"         
#> [13] "mapbiomas5_pantanal"
```

In the code bellow, we get the metadata of a specific collection:

``` r
describe_collection(wlts_bdc, "deter_amazonia_legal")
#> $classification_system
#> $classification_system$classification_system_id
#> [1] "21"
#> 
#> $classification_system$classification_system_name
#> [1] "DETER Amazônia Legal"
#> 
#> $classification_system$type
#> [1] "Self"
#> 
#> 
#> $collection_type
#> [1] "Feature"
#> 
#> $description
#> [1] "Alertas de Desmatamento da Amazônia Legal."
#> 
#> $detail
#> [1] "O DETER é um levantamento rápido de alertas de evidências de alteração da cobertura florestal na Amazônia, feito pelo INPE. O DETER foi desenvolvido como um sistema de alerta para dar suporte à fiscalização e controle de desmatamento e da degradação florestal realizadas pelo Instituto Brasileiro do Meio Ambiente e dos Recursos Naturais Renováveis (IBAMA) e demais órgãos ligados a esta temática. Mais informações acesse: http://www.obt.inpe.br/OBT/assuntos/programas/amazonia/deter"
#> 
#> $name
#> [1] "deter_amazonia_legal"
#> 
#> $period
#> $period$end_date
#> [1] "2020-06-18"
#> 
#> $period$start_date
#> [1] "2016-08-02"
#> 
#> 
#> $resolution_unit
#> $resolution_unit$unit
#> [1] "DAY"
#> 
#> $resolution_unit$value
#> [1] "1"
#> 
#> 
#> $spatial_extent
#> $spatial_extent$xmax
#> [1] -44.00039
#> 
#> $spatial_extent$xmin
#> [1] -73.54909
#> 
#> $spatial_extent$ymax
#> [1] 4.555376
#> 
#> $spatial_extent$ymin
#> [1] -18.03644
```

This example shows how to retrieve a trajectory:

``` r

get_trajectory(wlts_bdc, latitude = c(-12, -11.01), longitude = c(-54, -54), collections = "mapbiomas5_amazonia")
#> $query
#> NULL
#> 
#> $result
#> # A tibble: 40 x 4
#>    class              collection          date  point_id
#>    <chr>              <chr>               <chr>    <int>
#>  1 Formação Florestal mapbiomas5_amazonia 2000         1
#>  2 Formação Florestal mapbiomas5_amazonia 2001         1
#>  3 Formação Florestal mapbiomas5_amazonia 2002         1
#>  4 Formação Florestal mapbiomas5_amazonia 2003         1
#>  5 Formação Florestal mapbiomas5_amazonia 2004         1
#>  6 Formação Florestal mapbiomas5_amazonia 2005         1
#>  7 Formação Florestal mapbiomas5_amazonia 2006         1
#>  8 Formação Florestal mapbiomas5_amazonia 2007         1
#>  9 Formação Florestal mapbiomas5_amazonia 2008         1
#> 10 Formação Florestal mapbiomas5_amazonia 2009         1
#> # … with 30 more rows
#> 
#> attr(,"class")
#> [1] "wlts"
```

# License

    Copyright (C) 2020 INPE.
    
    R client for WLTS is free software; you can redistribute it and/or modify it
    under the terms of the MIT License; see LICENSE file for more details.
