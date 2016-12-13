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


# enter data here
# conform to this structure of group, trial type, D scores, errors.
# NB trial types are named further below
data_to_plot <- data.frame(Group = factor(c("Men", "Men", "Men", "Men", "Women", "Women", "Women", "Women")),
                           trialtype = factor(c(1, 2, 3, 4, 1, 2, 3, 4)),
                           mean_D1 = c(0.1, 0.5, 0.3, 0.4, 0.4, 0.3, 0.6, 0.2),
                           errors_D1 = c(0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3))  # could be SE or 95% CI (preferable)

# optionally, view this data so that you can see the required structure
#View(data_to_plot)  

# optionally, write this data to disk so that you can see the required data structure. 
#write.csv(data_to_plot, file = "~/Desktop/demo_data.csv")  # Mac OS
#write.csv(data_to_plot, file = file = "c:/mydocuments/Desktop/demo_data.csv")  # windows

# optionally, read in your own csv file containing conditions, means and errors for plotting.
#data_to_plot <- read.csv("~/Desktop/demo_data.csv")  # Mac OS
#data_to_plot <- read.csv("c:/mydocuments/Desktop/demo_data.csv")  # windows


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
  geom_point(position = dodge) + 
  geom_errorbar(limits, 
                width = 0.3, 
                position = dodge) +
  theme_classic() +  # employs a sans serif font. If you want stict APA format, comment out this line and uncomment apatheme below.
  #apatheme +
  scale_color_grey() +  # greyscale colours
  xlab("Trial type") +
  ylab(expression("Mean " ~ italic("D")[IRAP] ~ "scores")) +  # use some expressions magic to include subscript and italics
  scale_x_discrete(labels=c("1" = "men\nmaculine",  # Name trial types here. NB "\n" creates a new line so that captions are readable
                            "2" = "men\nfeminine",
                            "3" = "women\nmasculine",
                            "4" = "women\nfeminine"))
  
# save plot to disk
ggsave("IRAP trial type plot.pdf",
       path = "~/Desktop/",  # Mac OS
       #path = "c:/mydocuments/Desktop/"  # windows
       device = "pdf",  # saves a PDF that is sized to fit Elsevier's 1.5 column width standard, ready for submission.
       width = 14,  
       height = 8,
       units = "cm")

