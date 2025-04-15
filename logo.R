# logo

library(hexSticker)

library(ggplot2)
library(ggrepel)
library(tidyverse)
library(sf)
library(terra)
library(raster)
library(rnaturalearth)
library(scales)

# aDRAC dataset
a <- read.csv("aDRAC.csv", 
              encoding = "UTF-8") %>%
  st_as_sf(crs = 4326, 
           coords = c("LONG", 
                      "LAT"), 
           remove = FALSE, 
           na.fail = F)

# naturalearth geodata
rivers10 <- ne_download(scale = 10, type = 'rivers_lake_centerlines', category = 'physical', returnclass = "sf")
lakes10 <- ne_download(scale = 10, type = 'lakes', category = 'physical', returnclass = "sf")
coast10 <- ne_download(scale = 10, type = 'coastline', category = 'physical', returnclass = "sf")
land10 <- ne_download(scale = 10, type = 'land', category = 'physical', returnclass = "sf")
boundary_lines_land10 <- ne_download(scale = 10, type = 'boundary_lines_land', category = 'cultural', returnclass = "sf")

# world data:
africa = spData::world %>% 
  dplyr::filter(continent == "Africa") #, !is.na(iso_a2))

# landcover data from "Global Land Cover 2000 Project (GLC 2000)" https://ec.europa.eu/jrc/en/scientific-tool/global-land-cover

temp <- tempfile()
download.file("https://forobs.jrc.ec.europa.eu/data/products/glc2000/Africa_v5_Grid.zip",temp)
unzip(temp)
unlink(temp)
dpath <- "Grid/africa_v5/hdr.adf"
hdr <- terra::rast(dpath)

bands <- foreign::read.dbf("Grid/Africa_v5_legend.dbf")

# extent: xmin,xmax,ymin,ymax
e  <- raster::extent(5, 33, -17, 13) 
rfs <- raster::crop(hdr, e) 

rfs.p <- terra::as.data.frame(rfs, xy = TRUE)

# Make the points a dataframe for ggplot & subset rainforest bands 1-7
rfs.bd1.7 <- dplyr::filter(rfs.p, CLASSNAMES %in% c(
  bands %>% 
    dplyr::filter(VALUE >= 1 & VALUE <= 7) %>%
    dplyr::pull(CLASSNAMES)
))

# Swamp forest
rfs.bd5 <- dplyr::filter(rfs.p, CLASSNAMES == "Swamp forest")

# Swamp bushland and grassland
rfs.bd17 <- dplyr::filter(rfs.p, CLASSNAMES == "Swamp bushland and grassland")

# water
rfs.bd26 <- dplyr::filter(rfs.p, CLASSNAMES == "Waterbodies")

map.plt <- ggplot() + 
  geom_sf(data = land10, fill = "#ffebbe", color = NA) + 
  geom_raster(data = rfs.bd1.7, aes(y = y, x = x), fill = '#00734d') + 
  geom_raster(data = rfs.bd5, aes(y = y, x = x), fill = '#2b916a') + 
  geom_raster(data = subset(rfs.bd17, x < 20), aes(y = y, x = x), fill = '#54eeb7') + 
  geom_raster(data = rfs.bd26, aes(y = y, x = x), fill = '#44afe3') + 
  geom_sf(data = coast10, size = .5, color = '#44afe3') + 
  geom_sf(data = rivers10, size = .5, color = '#44afe3') + 
  geom_sf(data = lakes10, fill = '#44afe3', color = NA) + 
  geom_sf(data = boundary_lines_land10, size = .1, color = 'black') + 
  geom_sf(data = a, fill = "white", shape = 21) + 
  coord_sf(xlim = c(8, 20), 
           ylim = c(-6, 6)) + 
  theme_void() + 
  theme(legend.position = "none",
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_rect(fill = "#dff1f9"),
        plot.background = element_rect(color = NA, 
                                       fill = NA)) +  
  NULL

c14.cal <- a %>%
  dplyr::filter(SITE == "Pikunda") %>%
  dplyr::rename(c14age = C14AGE, c14std = C14STD) %>%
  c14bazAAR::as.c14_date_list() %>%
  c14bazAAR::calibrate(choices = "calprobdistr") %>% # calibration
  tidyr::unnest(cols = c("calprobdistr"))

c14.cal.plt <- c14.cal %>%
  dplyr::arrange(c14age) %>% 
  dplyr::mutate_at(vars(LABNR), dplyr::funs(factor(., levels=unique(.)))) %>%
  #dplyr::mutate(SITE = factor(SITE, levels = sites.filter)) %>%
  ggplot() + 
  ggridges::geom_ridgeline(
    aes(x = -calage + 1950, 
        y = LABNR, 
        height = density),
    scale = 50, 
    fill = "white") + 
  scale_x_continuous("cal CE", expand = c(0, 0)) + 
  scale_y_discrete(position = "right", limits = rev) +
  theme_classic() +
  theme(axis.title.y = element_blank(), 
        axis.line.y = element_blank(), 
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(size = 20),
        axis.title.x = element_blank(),
        plot.background = element_rect(fill = "#ffffff99", color = NA), 
        panel.background = element_rect(fill = NA))

p <- map.plt + 
  patchwork::inset_element(
    c14.cal.plt, 
    left = 0, bottom = 0, right = 1, top = 1)

sticker(p, 
        package = "aDRAC",
        p_color = "green4",
        p_size = 20, 
        p_x = 1.25,
        p_y = 1,
        s_x = 1, 
        s_y = 1, 
        s_width = 2.25, 
        s_height = 2.25,
        filename = "logo.png", 
        white_around_sticker = TRUE)

