#install.packages("devtools")
library(devtools)
#install_github("easyGgplot2", "kassambara")
library(easyGgplot2)
rm(list = ls())
library(readxl)
library(ggplot2)

#get file from desktop and read with read_excel package. 2 columns numeric
files = file.path("~/Desktop/violins_CABN.xlsx")
agedonationdata <- read_excel(files, sheet=4, col_names=FALSE, col_types =c("numeric"))
APSdonationdata <- read_excel(files, sheet=2, col_names=FALSE, col_types =c("numeric", "numeric"))
biTPJdonationdata <- read_excel(files, sheet=3, col_names=FALSE, col_types =c("numeric", "numeric"))
attach(agedonationdata)
attach(APSdonationdata)
attach(biTPJdonationdata)
df <-agedonationdata
df1 <- APSdonationdata
df2 <- biTPJdonationdata

#rename columns of data frame and turn columns into factors for plotting

colnames(df)[c(1)] <- c("Age (years)")
df$`Age (years)`<-as.factor(df$`Age (years)`)
#df$`Donation Amount ($)`<-as.factor(df$`Donation Amount ($)`)
head(df)

colnames(df1)[c(1,2)] <- c("Donation Amount ($)", "APS Score")
df$`APS Score`<-as.factor(df$`APS Score`)
df$`Donation Amount ($)`<-as.factor(df$`Donation Amount ($)`)
head(df1)

colnames(df2)[c(1,2)] <- c("Donation Amount ($)", "Bilateral TPJ Activation to Prosocial Scenes Conjunction Analysis (beta)")
df$`Bilateral TPJ Activation to Prosocial Scenes Conjunction Analysis (beta)`<-as.factor(df$`Bilateral TPJ Activation to Prosocial Scenes Conjunction Analysis (beta)`)
df$`Donation Amount ($)`<-as.factor(df$`Donation Amount ($)`)
head(df2)

#create plot from dataframe df with donation on x and age on y
p <- ggplot(df, aes(y=`Age (years)`, x=0)) + geom_violin(trim=FALSE)
p1 <- ggplot(df1, aes(y=`Donation Amount ($)`, x=`APS Score`)) + geom_violin(trim=FALSE)
p2 <- ggplot(df2, aes(y=`Donation Amount ($)`, x=`Bilateral TPJ Activation to Prosocial Scenes Conjunction Analysis (beta)`)) + geom_violin(trim=FALSE)


#add mean point to violin plot     
#p + stat_summary(fun.y=mean, geom="point", size=2)  

#dot plot of each value in violin plot
#p + geom_dotplot(binaxis='y', stckdir='center', dotsize =.5)

#remove background gridline
p + geom_dotplot(binaxis='y', dotsize =.5, fill="white") + theme_classic(base_size = 18)   
p1 + geom_dotplot(binaxis='y', stckdir='center', dotsize =.5, fill="white") + theme_classic(base_size = 18)
p2 + geom_dotplot(binaxis='y', stckdir='center', dotsize =.5, fill="white") + theme_classic(base_size = 18)

#add point for mean and lines for SD
#data_summary <-function(x){
 # m<- mean(x)
  #ymin <- m-sd(x)
  #ymax <- m+sd(x)
  #return(c(y=m, ymin=ymin, ymax=ymax))
#}
#p + theme_classic(base_size = 18) + stat_summary(fun.data=data_summary)  

#add boxplot inside violin
#p + theme_classic(base_size = 18) + geom_boxplot(width=0.2)

#website for more customization help
#http://www.sthda.com/english/wiki/ggplot2-violin-plot-quick-start-guide-r-software-and-data-visualization

#other resources for visualization in R
#https://rstudio-pubs-static.s3.amazonaws.com/217696_9b28d8fb031647618ccc0e0b23c7e902.html#/15
            