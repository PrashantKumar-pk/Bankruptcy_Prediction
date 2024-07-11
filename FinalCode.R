pacman::p_load(pacman,tidyr,ggthemes,ggplot2,plotly,GGally,rio,
               stringr,shiny,rmarkdown,lubridate,psych,ipred,caret,ROCR,pROC,
               DT,rpart,rpart.plot,httr,randomForest,readr)


df<-read.csv("data.csv")

head(df)

sum(is.na(df))

df$Bankrupt.[df$Bankrupt.==1]<-"Yes"
df$Bankrupt.[df$Bankrupt.==0]<-"No"
barplot(table(df$Bankrupt.),col=rainbow(2),
        main="Frequency of Bankrutcy",
        xlab="Bankruptcy Tag",
        ylab="Number of Companies")
box()

df$Bankrupt.<-as.factor(df$Bankrupt.)
summary(df$Bankrupt.)

# 6599 Companies did not go into Bankruptcy while 220 did from the 6819 Companies we have in our data
#that is a Bankruptcy rate of about 3.23% and a survival rate of about 96.77%

#Plot the 95 independent variables
par(mfrow = c(4,5))
i <- 2
for (i in 2:21) 
{
  hist((df[,i]), main = paste("Distibution of ", colnames(df[i])), xlab = colnames(df[i]))
}
#Next 20
par(mfrow = c(4,5))
i <- 22
for (i in 22:41) 
{
  hist((df[,i]), main = paste("Distibution of ", colnames(df[i])), xlab = colnames(df[i]))
}
#Next 20
par(mfrow = c(4,5))
i <- 42
for (i in 42:61) 
{
  hist((df[,i]), main = paste("Distibution of ", colnames(df[i])), xlab = colnames(df[i]))
}
#Next 20
par(mfrow = c(4,5))
i <- 61
for (i in 61:80) 
{
  hist((df[,i]), main = paste("Distibution of ", colnames(df[i])), xlab = colnames(df[i]))
}
#last remaining varialbes
par(mfrow = c(4,5))
i <- 81
for (i in 81:94) 
{
  hist((df[,i]), main = paste("Distibution of ", colnames(df[i])), xlab = colnames(df[i]))
}
#correlation matrix
correlation_matrix <- cor(df[, -1]) 

# Reshape correlation matrix into long format
correlation_long <- as.data.frame(as.table(correlation_matrix))
names(correlation_long) <- c("Var1", "Var2", "Correlation")

# Ploting heatmap
library(ggplot2)
ggplot(correlation_long, aes(Var1, Var2, fill = Correlation)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1, 1),
                       name = "Correlation") +
  theme_minimal() +
  labs(title = "Correlation Matrix Heatmap")

df$Bankrupt. <- as.factor(df$Bankrupt.)
library(tidyr)
df_long <- gather(df[, -1], key = "variable", value = "value")  

# Ploting density for each independent variable by bankruptcy status
library(ggplot2)
ggplot(df_long, aes(x = value, fill = df$Bankrupt..)) +
  geom_density(alpha = 0.5) +
  facet_wrap(~variable, scales = "free") +
  labs(title = "Density Plot of Independent Variables by Bankruptcy Status")



#test and train datasets
par(mfrow=c(1,1))
set.seed(1992)

#Training - 70 % and Testing - 30%
intrain<-createDataPartition(y=df$Bankrupt.,p=0.7,list=F,times=1)
training <-df[intrain,]
testing <-df[-intrain,]

set.seed(1992)

#RANDOM FOREST MODELLING-RPART
#1a with 2 repeats and 3 folds
#1a
rf_ctr_specs1 <-trainControl(method = "repeatedcv",
                             repeats = 2,
                             number=3,
                             search = "random")
Model1a <-train(Bankrupt.~.,data=training,
                 method="rf",
                 trControl=rf_ctr_specs1)
plot(varImp(Model1a,scale=F),main="Model 1a RandomForest-3 FOLDS-2-REPEATED CV")
plot(varImp(Model1a,scale=F),top=20,main="Model 1a RandomForest-3 FOLDS-2-REPEATED CV")
#Forming confusion matrix
predictions_rf1<-predict(Model1a,newdata=testing)
cm_1a<-confusionMatrix(predictions_rf1,testing$Bankrupt.)
cm_1a
varImp(Model1a)

#1b with 3 repeats and 5 folds
#Model 1b
set.seed(1992)
#1b
rf_ctr_specs <-trainControl(method = "repeatedcv",
                            repeats = 3,
                            number=5,
                            search = "random")
Model1b <-train(Bankrupt.~.,data=training,
                 method="rf",
                 trControl=rf_ctr_specs)
plot(varImp(Model1b,scale=F),main="Model 1b RandomForest-5 FOLDS-3-REAPEATED CV")
plot(varImp(Model1b,scale=F), top=20 ,main="Model 1b RandomForest-5 FOLDS-3-REAPEATED CV")
#Forming confusion matrix
predictions_rf<-predict(Model1b,newdata=testing)
cm_1b<-confusionMatrix(predictions_rf,testing$Bankrupt.)
cm_1b
varImp(Model1b)


predictions_model1a <- predict(Model3.a, newdata = testing)
predictions_model1a
predictions_model1b <- predict(Model3.b, newdata = testing)
predictions_model1b