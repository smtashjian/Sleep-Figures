install.packages("devtools")
library(devtools)
install_github("easyGgplot2", "kassambara")
library(easyGgplot2)
rm(list = ls())
library(readxl)
library(ggplot2)

#get file from desktop and read with read_excel package. 2 columns numeric
files = file.path("~/Desktop/age_sleepduration.xlsx")
data <- read_excel(files, sheet=1, col_names=FALSE, col_types =c("numeric", "numeric"))
attach(data)
df <-data

#rename columns of data frame and turn columns into factors for plotting

colnames(df)[c(1,2)] <- c("Age (years)", "Sleep Duration (mins)")
df$`Age (years)`<-as.factor(df$`Age (years)`)
#df$`Sleep Duration (mins)`<-as.factor(df$`Sleep Duration (mins)`)
head(df)

#create plot from dataframe df with age on x and sleep on y
p <- ggplot(df, aes(x=`Age (years)`, y=`Sleep Duration (mins)`)) + geom_violin(trim=FALSE)

#add mean point to violin plot     
p + stat_summary(fun.y=mean, geom="point", size=2)  

#dot plot of each value in violin plot
p + geom_dotplot(binaxis='y', stckdir='center', dotsize =.5)

#remove background gridline
p + geom_dotplot(binaxis='y', stckdir='center', dotsize =.5, fill="white") + theme_classic(base_size = 18)   

#add point for mean and lines for SD
data_summary <-function(x){
  m<- mean(x)
  ymin <- m-sd(x)
  ymax <- m+sd(x)
  return(c(y=m, ymin=ymin, ymax=ymax))
}
p + theme_classic(base_size = 18) + stat_summary(fun.data=data_summary)  

#add boxplot inside violin
p + theme_classic(base_size = 18) + geom_boxplot(width=0.2)

#website for more customization help
#http://www.sthda.com/english/wiki/ggplot2-violin-plot-quick-start-guide-r-software-and-data-visualization

#other resources for visualization in R
#https://rstudio-pubs-static.s3.amazonaws.com/217696_9b28d8fb031647618ccc0e0b23c7e902.html#/15
            