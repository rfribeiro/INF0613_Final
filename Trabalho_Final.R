########################################################################
# INF-0613 - Mineração de Dados - Trabalho Final
# Nomes: Rafael Fernando Ribeiro
#        Thiago Gomes Marçal Pereira
########################################################################

# Set Working Directory
setwd("/Users/thiagom/Documents/Studies/Unicamp/MDC/INF-613/Tarefas/Final/INF0613_Trabalho_Final")

# Open Data
headlines <- read.csv("dataset/headlines.csv", sep=",", header = T)
features <- read.csv("dataset/features.csv", sep=",", header = T)

# Fix the data from headlines (?)
headlines$publish_date <- strptime(headlines$publish_date, "%Y%m%d")

# Run PCA for features
features.pca <- prcomp(features, scale. = T)

# Change maxPrint, to be able to print PCA
# options(max.print=25000)

# Print PCA to check for Cumulative Proportions
summary(features.pca)
# 85% - PC1654
# 90% - PC1804

# To the following Items use PC1700 - Cumulative Proportion - 0.86584
PC <- 1700
dados <- features.pca$x[1:PC]

# Run k-means and k-medoids for the data
