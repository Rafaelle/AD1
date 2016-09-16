#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr, warn.conflicts = F)
install.packages("readr")
library(readr)
library(ggplot2)
#install.packages("plotly")
library(plotly)
library(stringr)
theme_set(theme_bw())

source("import-data.R")
import_data()

# Perguntas
# Os filmes mais populares possuem maiores avaliações?
# Como se comportam as avaliações por gênero de filmes? Quais possuem maior variabilidade?
# Como é a distribuição das avaliações e popularidade ao longo dos anos(de produção dos filmes)?

filmes.ano = filmes %>%
  rowwise() %>%
  mutate(ano = str_sub(title, start= -5, end = -2)) %>%
  filter(movieId != 108548) %>%
  filter( movieId != 108583) %>%
  filter(movieId != 40697)

grupo.ano = function(ano){
  #mytable <- function(x, ...) x %>% group_by_(...) %>% summarise(n = n())
}

boot = function(df= filmes.ano){
  experimento = sample_n(df, 1000, replace = TRUE)
  bootstrap.mediana = bootstrap(experimento, median(rating))
  mediana = CI.percentile(bootstrap.mediana, probs = c(.025, .975))
  return(mediana)
}

#filmes com 1 genêro
df.1.genero = grupo.genero(1)
mediana.1.genero = boot(df.1.genero)

#séries movieId = 108548, 108583, 40697

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
