# RDI plots (raw data, distribution and inferential information)

# author: Ian Hussey (ian.hussey@ugent.be)
# license: GPLv3+


# Dependencies ------------------------------------------------------------


library(tidyverse)
library(yarrr)


# Data acquisition and processing -----------------------------------------


setwd("~/Dropbox/Work/Programming/R/3 Visualisation/Pirate plot/")

IAT_data_exp <- 
  read.csv("RDI demo data.csv") %>%
  filter(rt > 0) %>%  # log transformations require rts of 0 to be removed.
  mutate(block = ifelse(block == 1, "congruent", "incongruent"),
         block = as.factor(block),
         condition = as.factor(ifelse(condition == 1, "low", "high")))

IAT_data_exp_outliers_removed <- 
  IAT_data_exp %>%
  schoRsch::outlier(dv = "rt", 
                    todo="elim", 
                    upper.z = 2.5, 
                    lower.z = -2.5)


# plot --------------------------------------------------------------------


RDI_plot <- 
  pirateplot(formula = rt ~ condition * block,
             data = IAT_data_exp_outliers_removed,
             main = "IAT data",
             ylab = "Reaction times",
             theme = 1,
             pal = "#526273",
             bean.b.o = 1,
             point.o = .2,
             bar.o = 1,
             line.o = 1,
             inf.f.o = 1,
             inf = "ci",
             inf.f.col = c("#834339", "#80C48E"),
             bean.f.col = c("#834339", "#80C48E"),
             ylim = c (200, 1200))  


