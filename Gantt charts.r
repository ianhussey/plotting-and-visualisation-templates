# Easy Gantt charts

# author: Ian Hussey (ian.hussey@ugent.be)
# license: GPLv3+


# dependencies ------------------------------------------------------------


library(plan)


# Option 1 ----------------------------------------------------------------


# simply plot a preformulated list of dates 
# This requires less code but more manual labor making and formatting the file.
# NB the txt file must be both comma and tab spaced for some reason. 

setwd("~/Dropbox/Work/Programming/R/3 Visualisation/Gantt charts/")

gantt_chart_1 <- read.gantt("Gantt demo data.txt")
plot(gantt_chart_1)


# Option 2 ----------------------------------------------------------------


# Calculate dates based on a start date plus time required 
# This requires more code but can be adjusted and updated more quickly

## define vectors for each datum to be plotted

# define what we mean by months and years. These don't need to be changed. 
month <- 28 * 86400 # define a month in seconds
year <- 12 * month # define a year in seconds

# set project start date
arrive <- as.POSIXct("2016-04-04") 
# calculate project end date
leave <- arrive + 4 * year 

# define start dates and required time for each of the tasks
# NB these can work backwards from and end date as well as forwards from the start. e.g., T1 vs T7
startT1 <- arrive
endT1 <- startT1 + month * 4

startT2 <- endT1 + 1
endT2 <- startT2 + month * 4

startT3 <- arrive + month * 12
endT3 <- startT3 + month * 4

startT4 <- arrive + month * 9
endT4 <- arrive + month * 12

startT5 <- arrive + month * 15
endT5 <- arrive + month * 20

startT6 <- arrive + month * 2 
endT6 <- leave - month * 4 

startT7 <- leave - month * 4
endT7 <- leave

# convert the above vectors in to Plan's gantt format list
gantt_chart_2 <- as.gantt(key = 1:7, 
                          description=c("Term 1 classes",
                                        "Term 2 classes",
                                        "Qualifying Examination",
                                        "Term 3 classes",
                                        "Proposal Defence",
                                        "Thesis Work",
                                        "Thesis Writing/Defence"),
                          start=c(startT1, 
                                  startT2, 
                                  startT3, 
                                  startT4, 
                                  startT5,
                                  startT6, 
                                  startT7),
                          end=c(endT1,
                                endT2, 
                                endT3, 
                                endT4, 
                                endT5,
                                endT6, 
                                endT7),
                          done = rep(0, 7), # set done % to "0" for all seven rows. Equivalent to c(0,0,0,0,0,0,0)
                          neededBy = c(NA,NA,NA,NA,NA,7,NA)) # draw "needed by" lines between the end the row and what other row

# plot
plot(gantt_chart_2, xlim = c(arrive, leave))

