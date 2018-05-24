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
set.seed(123)
features.kmeans <- kmeans(dados, 5)

# Calculatte Silhouette Coeficient 
features.silhouette <- silhouette(features.kmeans$cluster, d)

# Calculate the bi-grams using NLP's ngrams method
bigramas <- list()
for (cl in c(1:5)) {
  words <- colnames(features)[features.kmeans$cluster == cl]
  bigramas[[cl]] <- ngrams(words, 2)
}
