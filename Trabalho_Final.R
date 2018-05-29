########################################################################
# INF-0613 - Mineração de Dados - Trabalho Final
# Nomes: Rafael Fernando Ribeiro
#        Thiago Gomes Marçal Pereira
########################################################################

# Libraries
library(cluster)
library(NLP)

# Set Working Directory
setwd("/Users/thiagom/Documents/Studies/Unicamp/MDC/INF-613/Tarefas/Final/INF0613_Trabalho_Final")

# Open Data
headlines <- read.csv("dataset/headlines.csv", sep=",", header = T)
features <- read.csv("dataset/features.csv", sep=",", header = T)

# Fix the data from headlines (?)
headlines$publish_date <- strptime(headlines$publish_date, "%Y%m%d")

# Run PCA for features
#features.pca <- prcomp(features, scale. = T)

# Change maxPrint, to be able to print PCA
options(max.print=25000)

# Print PCA to check for Cumulative Proportions
summary(features.pca)
# 85% - PC1654
# 90% - PC1804

# To the following Items use PC1654 - ~85%
PC <- 1654
dados <- features.pca$x[,1:PC]

# Calculate distance Matrix for the data
d <- dist(dados)

# Run k-means and k-medoids for the data (5, 10, 15, 20 clusters)
set.seed(1234)
features.kmeansk5 <- kmeans(dados, 5)
set.seed(1234)
features.kmeansk10 <- kmeans(dados, 10)
set.seed(1234)
features.kmeansk15 <- kmeans(dados, 15)
set.seed(1234)
features.kmeansk20 <- kmeans(dados, 20)

# Calculatte Silhouette Coeficient 
features.silhouettek5 <- silhouette(features.kmeansk5$cluster, d)
features.silhouettek10 <- silhouette(features.kmeansk10$cluster, d)
features.silhouettek15 <- silhouette(features.kmeansk15$cluster, d)
features.silhouettek20 <- silhouette(features.kmeansk20$cluster, d)

# Erros Quadraticos
print("Erros Quadráticos")
print("5")
features.kmeansk5$tot.withinss
print("10")
features.kmeansk10$tot.withinss
print("15")
features.kmeansk15$tot.withinss
print("20")
features.kmeansk20$tot.withinss

# Coeficientes de Silhueta
print("Coeficientes de Silhueta")
print("5")
summary(features.silhouettek5)$avg.width
print("10")
summary(features.silhouettek10)$avg.width
print("15")
summary(features.silhouettek15)$avg.width
print("20")
summary(features.silhouettek20)$avg.width

# Calculate the bi-grams using NLP's ngrams method
#bigramas <- list()
#for (cl in c(1:5)) {
#  words <- colnames(features)[features.kmeans$cluster == cl]
#  bigramas[[cl]] <- ngrams(words, 2)
#}

