# CubeHelix colour palette R implementation 

# author: Ian Hussey (ian.hussey@ugent.be)
# license: GPLv3+
# notes: the CubeHelix palette has the advantage of being equally visable when
# viewed in black and white or in colour. It is also color blind friendly, and
# aesthetically pleasing relative to most default colour palettes.


# dependencies ------------------------------------------------------------


library(rje) #implementation of cubehelix


# generate hex colour codes -----------------------------------------------

# generically:
# cubeHelix(n, start = 0, r = .1, hue = 1, gamma = 1) #where n is number of colors desired


# 4 color palettes based on variation in start and r
#1
colors <- cubeHelix(7, start = 0, r = 1, hue = 1, gamma = 1) 
colors
# "#451A3C" "#834339" "#848941" "#80C48E" "#B8E0E6"

#2
colors <- cubeHelix(7, start = 0, r = -1, hue = 1, gamma = 1)
# "#0E363C" "#2B6F39" "#848941" "#D8988E" "#EFC4E6"

#3
colors <- cubeHelix(7, start = -.5, r = -1, hue = 1, gamma = 1) 
colors
# "#103B19" "#595D1D" "#B36B60" "#D490C6" "#D2CFF7"

#4
colors <- cubeHelix(7, start = .5, r = 1, hue = 1, gamma = 1)
colors
# "#471F19" "#595D1D" "#519D60" "#7CBCC6" "#D2CFF7"

#5
colors <- cubeHelix(5, start = .5, r = 1, hue = 1, gamma = 1)
colors
# "#000000" "#583B17" "#519D60" "#A7C4E8" "#FFFFFF"
