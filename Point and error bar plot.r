# Simple point and error bar plot of mean D-IRAP scores

# author: Ian Hussey (ian.hussey@ugent.be)
# license: GPLv3+
# notes:
#   No bars as these sublty but falsely imply that deviation from zero is interpretable or meaningful.
#   No lines between groups as these can subtly but falsy imply that the groups are paired.
# instructions:
#   Change your group names, mean D1 scores, and error bar width on lines 38, 40 and 41. 
#   Or, put these in a csv file and load them here using lines 51-52. You can see the required structure on the preceeding lines.
#   Change your trial type names on line 92-95.
#   Depending on whether you're working from mac or pc, comment/comment lines 99/100.


# dependencies ------------------------------------------------------------


# check for all dependencies and install any missing ones
# solution from https://gist.github.com/stevenworthington/3178163
auto_install_dependencies <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
}
packages <- c("tidyverse")
auto_install_dependencies(packages)

# load packages
library(tidyverse)


# data --------------------------------------------------------------------


setwd("~/git/plotting-and-visualisation-templates/")

# there are several ways to pull data in here. 

# 1. generate fake data to demonstrate the required structure of the data frame

# conform to this structure of group, trial type, D scores, errors.
# NB trial types are named further below
data_to_plot <- data.frame(Group = factor(c("Men", "Men", "Men", "Men", "Women", "Women", "Women", "Women")),
                           trialtype = factor(c(1, 2, 3, 4, 1, 2, 3, 4)),
                           mean_D1 = c(0.1, 0.5, 0.3, 0.4, 0.4, 0.3, 0.6, 0.2),
                           errors_D1 = c(0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3))  # could be SE or 95% CI (preferable)

# you can view this data so that you can see the required structure
#View(data_to_plot)  

# or write this data to disk so that you can see the required data structure. 
#write.csv(data_to_plot, file = "~/Desktop/demo_data.csv")  # Mac OS
#write.csv(data_to_plot, file = file = "c:/mydocuments/Desktop/demo_data.csv")  # windows



# 2. assuming you can calculate means and errors (SE or CI widths) from your data, 
# you can put these in csv file that conforms to the above format and read them in here.

#data_to_plot <- read.csv("~/Desktop/demo_data.csv")  # Mac OS
#data_to_plot <- read.csv("c:/mydocuments/Desktop/demo_data.csv")  # windows



# 3. read in your participant level data, and the below will extract the group, means and CI widths 
# and put them in the right format.
# NB you must include a group identifier column (currently "gender" below), D_tt1, D_tt2, D_tt3, D_tt4
# and an outlier column

#input_data <- read.csv("~/Desktop/demo_data.csv")  # Mac OS
#input_data <- read.csv("c:/mydocuments/Desktop/demo_data.csv")  # windows
# 
# data_to_plot_1 <-
#   input_data %>%
#   rename(Group = gender) %>%  # set your grouping variable here
#   filter(!is.na(D_tt1) | !is.na(D_tt2) | !is.na(D_tt3) | !is.na(D_tt1) | !is.na(Group)) %>%  # remove rows with missing data
#   group_by(Group) %>%
#   summarize(mean_D_tt1 = mean(D_tt1),
#             mean_D_tt2 = mean(D_tt2),
#             mean_D_tt3 = mean(D_tt3),
#             mean_D_tt4 = mean(D_tt4)) %>%
#   gather(trialtype, mean_D1, c(mean_D_tt1, mean_D_tt2, mean_D_tt3, mean_D_tt4)) %>%
#   mutate(trialtype = ifelse(trialtype == "mean_D_tt1", 1,
#                             ifelse(trialtype == "mean_D_tt2", 2,
#                                    ifelse(trialtype == "mean_D_tt3", 3,
#                                           ifelse(trialtype == "mean_D_tt4", 4, NA))))) %>%
#   rownames_to_column()
# 
# data_to_plot_2 <-
#   input_data %>%
#   rename(Group = gender) %>%
#   filter(!is.na(D_tt1) | !is.na(D_tt2) | !is.na(D_tt3) | !is.na(D_tt1) | !is.na(Group)) %>%  # remove rows with missing data
#   group_by(Group) %>%
#   summarize(se_D_tt1 = 1.96*sd(D_tt1)/sqrt(length(D_tt1)),  # returns 95% CI interval width. Remove "1.96*" for standard error
#             se_D_tt2 = 1.96*sd(D_tt2)/sqrt(length(D_tt2)),
#             se_D_tt3 = 1.96*sd(D_tt3)/sqrt(length(D_tt3)),
#             se_D_tt4 = 1.96*sd(D_tt4)/sqrt(length(D_tt4))) %>%
#   gather(trialtype, errors_D1, c(se_D_tt1, se_D_tt2, se_D_tt3, se_D_tt4)) %>%
#   select(-trialtype, -Group) %>%
#   rownames_to_column()
# 
# data_to_plot <-
#   left_join(data_to_plot_1, data_to_plot_2, by = "rowname") %>%
#   select(-rowname) %>%
#   mutate(trialtype = as.factor(trialtype))


# optinally define strict apa theme ---------------------------------------


# nb not employed in plot below by default
# apatheme <-
#   theme_bw()+
#   theme(panel.grid.major = element_blank(),
#         panel.grid.minor = element_blank(),
#         panel.border = element_blank(),
#         axis.line = element_line(),
#         text = element_text(family = "Times New Roman"),
#         legend.title = element_blank())


# plot --------------------------------------------------------------------


# define error bar limits
limits <- aes(ymax = mean_D1 + errors_D1, ymin = mean_D1 - errors_D1)

# "dodge" the error bars so they don't overlap
dodge <- position_dodge(width = 0.4)  

# create plot
ggplot(data_to_plot, 
       aes(colour = Group, 
           y = mean_D1, 
           x = trialtype)) + 
  ylim(-.5, 1) +  # set limits of Y axis here
  geom_point(shape = 15,  # squares for points
             position = dodge) + 
  geom_errorbar(limits, 
                width = 0.3, 
                position = dodge) +
  theme_classic() +  # employs a sans serif font. If you want stict APA format, comment out this line and uncomment apatheme below.
  #apatheme +
  scale_color_grey() +  # greyscale colours
  ylab(expression("Mean " ~ italic("D")[IRAP] ~ "scores")) +  # use some expressions magic to include subscript and italics
  scale_x_discrete("Trial type",
                   labels=c("1" = "men are\nmaculine",  # Name trial types here. NB "\n" creates a new line so that captions are readable
                            "2" = "men are\nfeminine",
                            "3" = "women are\nmasculine",
                            "4" = "women are\nfeminine"))
  
# save plot to disk
ggsave("Point and error bar plot.pdf",
       #path = "c:/mydocuments/Desktop/"  # windows
       device = "pdf",  # saves a PDF that is sized to fit Elsevier's 1.5 column width standard, ready for submission.
       width = 14,  
       height = 8,
       units = "cm")

