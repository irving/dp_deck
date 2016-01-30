library(ggplot2)
csv <- read.csv("CrimeTotal.csv", header=FALSE, skip=6)
c2 <- csv[1:53,c(1, 4)]
colnames(c2) <- c("year", "murders")
c2$year <- as.factor(c2$year)
years <- seq(1960, 2012, 5)
g <- ggplot(data=c2, aes(x=year, y=murders, group=1)) +
    geom_line() + geom_smooth() +
    scale_x_discrete(name="year", breaks = years, labels=as.character(years))
#q <- qplot(year, murders, data=c2, geom=c("line", "smooth"), group=1)
    