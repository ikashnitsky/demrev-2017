################################################################################
#
# demrev-2017. 2017-07-07
# Prepare session
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#
################################################################################

# Erase all objects in memory
rm(list = ls(all = TRUE))

# to read cyrillic
Sys.setlocale("LC_CTYPE", "russian")

# load required packages (install missing)
library(tidyverse)
library(ggthemes)
library(viridis)
library(ggrepel)
library(rgdal)
library(maptools)
library(magrittr)
library(RColorBrewer)
library(extrafont)



# create a color pallete to use later
brbg <- RColorBrewer::brewer.pal(11, 'BrBG')

# the figures will be saved in a separate directory
ifelse(!dir.exists("figures"),
       dir.create("figures"),
       paste("Directory already exists"))

# FONTS
library(extrafont)
ttf_import("data/fonts")
myfont <- "PT Sans Narrow"
myfont2 <- "Roboto Condensed"
