
<!-- README.md is generated from README.Rmd. Please edit that file -->

# akmarineareas2

<!-- badges: start -->
<!-- badges: end -->

The akmarineareas2 package imports spatial data of Alaska marine
management and ecosystem areas as sf objects. Areas included are large
marine ecosystems and ecosystem subareas used in the ecosystem status
reports (ESR), NMFS areas, ADF&G stat areas, and BSIERP regions.
Basemaps of Alaska, Canada, and Russia are also included. Each layer has
an Alaskan Albers projection and decimal degree version. This package
supersedes the AKmarineareas package.

## Installation

You can install the development version of akmarineareas2 from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("MattCallahan-NOAA/akmarineareas2")
```

## Data

**adfg/adfg_dd** Alaska Department of Fish and Game (ADFG) statistical
areas. Data are courtesy of ADFG.

**nmfs/nmfs_dd** National Marine Fisheries Service (NMFS) reporting
areas. Data courtesy of the Alaska Fisheries Science Center (AFSC)
Ecosystem Monitoring and Assessment (EMA) Program.

**bsierp/bsierp_dd** Bering Sea Integrated Ecosystem Research Project
(BSIERP) regions. Data courtesy of the Alaska Fisheries Science Center
(AFSC) Ecosystem Monitoring and Assessment (EMA) Program.

**lme/lme_dd** Large Marine Ecosystems (Arctic, Bering Sea, Aleutian
Islands, and Gulf of Alaska). Data courtesy of Brett Holycross at
Pacific States Marine Fisheries Commission (PSMFC) according to the
specifications of the ESR authors. Note that the AI and GOA boundary
splits NMFS 610. **esr/esr_dd** Ecosystem subareas. Data courtesy of
Brett Holycross at Pacific States Marine Fisheries Commission (PSMFC)
according to the specifications of the ESR authors. Note that the AI and
GOA boundary splits NMFS 610.

**ak/ak_dd** Alaska basemap. Data courtesy of Brett Holycross at Pacific
States Marine Fisheries Commission (PSMFC).

**canada/canada_dd** Canada taken from the Rnaturalearth package.

**russia/russia_dd** Russia taken from the Rnaturalearth package.

``` r
library(akmarineareas2)
library(tidyverse)
library(sf)
## plot NMFS areas and AK
ggplot()+
  geom_sf(data=nmfs, color="red", fill=NA)+
  geom_sf(data=ak)+
  theme_void()
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

``` r

## plot ADFG areas in Southeast AK
#set extent
ext<-data.frame(x=c(-140,-127), y=c(53, 58))%>%
  st_as_sf(coords=c("x", "y"), crs=4326)%>%
  st_transform(crs=3338)%>%
  st_bbox()
#plot adfg areas with canada and ak basemaps
ggplot()+
  geom_sf(data=ak)+
  geom_sf(data=canada)+
  geom_sf(data=adfg, color="black", fill=NA)+
  coord_sf(xlim=c(ext[1], ext[3]), ylim=c(ext[2], ext[4]))+
  theme_bw()
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

``` r
## plot BSIERP regions in the Bering Sea
#set extent
ext<-data.frame(x=c(178,-160), y=c(49, 67))%>%
  st_as_sf(coords=c("x", "y"), crs=4326)%>%
  st_transform(crs=3338)%>%
  st_bbox()
#plot bsierp regions and AK and Russia 
ggplot()+
  geom_sf(data=ak)+
  geom_sf(data=russia)+
  geom_sf(data=bsierp, color="black", fill="orange")+
  geom_sf_label(data=bsierp, aes(label=BSIERP_ID))+
  coord_sf(xlim=c(ext[1], ext[3]), ylim=c(ext[2], ext[4]))+
  scale_x_continuous(breaks = seq(-180,360, 10))+
  theme_bw()+
  theme(axis.title=element_blank())
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

## Functions

**remove_dateline()** Some polygons have a line through them at the
international dateline that does not reflect an area boundary. This
includes the \_dd versions of these layers. Other data may have this
artifact too (e.g.??Siberia from the rnaturalearth package). This
function removes the dateline from data for mapping.

``` r
## without dateline removed
my_esr<-esr_dd%>%
  st_shift_longitude()

ggplot()+
  geom_sf(data=my_esr, color="red", fill=NA)+
  theme_void()
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

``` r
## remove dateline
my_esr2<-esr_dd%>%
  remove_dateline()%>%
    st_shift_longitude()
#> Spherical geometry (s2) switched off
  
ggplot()+
  geom_sf(data=my_esr2, color="red", fill=NA)+
  theme_void()
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />
