install.packages("lubridate")             # Install lubridate package
library("lubridate")                      # Load lubridate package
library(openxlsx)
library(dplyr)
rm(list=ls())
data_clin <- read.csv("OSU_Clinical_Data.csv")
#data_clin$Date.of.Craniotomy <- sub("/", "-", data_clin$Date.of.Craniotomy)
#data_clin$Date.of.Death <- sub("/", "-", data_clin$Date.of.Death)
names(data_clin)

diagnostic <- data_clin$Date.of.Craniotomy
death<- data_clin$Last.update
OS = rep(NA, times=length(1:66))
i=1
j=1
for (i in 1:length(diagnostic)){
    date_1<- as.Date(diagnostic[i])
    date_2<- as.Date(death[i])
    OS1 <- interval(date_1, date_2) %/% months(1) 
    OS[i]<- paste(OS1) %>% as.numeric()
    print(paste(i, OS1))}
}
m<- 25


#interval(diagnostic[2], death[2]) %/% months(1)
OS<- OS[-c(2:nrow(OS)),]
OS<-t(OS)
OS<- as.data.frame(OS, rowNames=FALSE)
OS<- OS[-67,]
data_clin$OS <- OS
data_clin$Overall.survival<- NULL
row.names(data_clin) <- data_clin$REDCAP.ID
median(data_clin$OS)
write.csv(data_clin, "clinical_data_OSU.csv")

hist(OS)
abline(v=25, col="purple")
