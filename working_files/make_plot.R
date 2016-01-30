# This script extracts data from the csv file
# and makes a plot showing trends. This will be displayed
# in the last or next to last slide of the 
# Coursera Developing data Products class final project (part 2: the pitch deck)
library(reshape2)
library(scales)
library(ggplot2)
names <- c("year", "population", "total", "murder", "rape", "robbery", "aggravated assault")

# In: a data frame of crime data 
# Out: a ggplot2 line graph showing amounts of each crime over the years
make_plot <- function(df){
    years <- seq(1960, 2012, 5)
    # maximum was over 1,130,000
    yaxis <- seq(0, 1300000, 100000)
    ggplot(data=df, aes(x=year, y=incidents, group=crime, color=crime)) +
        geom_line(size=0.5) + ggtitle("US Violent Crime, 1960 - 2012") +
        geom_point( size=1, shape=21, fill="blue") +
        theme(plot.title = element_text(lineheight=.8, face="bold")) +
        scale_x_discrete(name="year", breaks = years, labels=as.character(years)) +
        scale_y_discrete(name="incidents", breaks = yaxis, comma)
}

# annoying fact: When skipping rows, if you tell it header=true
# it will still try to treat the first row (which was skipped) as the header.
csv <- read.csv("CrimeTotal.csv", header=FALSE, skip=6)
colnames(csv) <- names
csv$year <- as.factor(csv$year)

# drop columns not needed (but save the frame in case I decide to do rates later)
c2 <- csv[1:53,c(1, 4, 5, 6, 7)]
data <- melt(c2, id.vars="year", value.name="incidents", variable.name="crime")


# NEXT: call make plot and then save the output!
g <- make_plot(data)
ggsave("../assets/img/plot1.png", plot=g)
dev.off