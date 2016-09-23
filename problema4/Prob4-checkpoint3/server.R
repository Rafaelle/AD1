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
#install.packages("readr")
library(readr)
library(ggplot2)
#install.packages("plotly")
library(plotly)
library(resample)
theme_set(theme_bw())

source("import-data.R")
import_data()

# Perguntas
# Como se comportam as avaliações por gênero de filmes? Quais possuem maior variabilidade?
# Como é a distribuição das avaliações e popularidade ao longo dos anos(de produção dos filmes)? (ESSE)



medianas.ano = read.csv("medianas_filme.csv")
generos.filme = read.csv("generos_filme.csv")
medianas.genero = read.csv("medianas_genero.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$medianaAnoPlot <- renderPlot({
    
       anos.filtrados = medianas.ano %>% 
         filter(findInterval(ano, c(1990, 2013))==1)

       anos.filtrados %>% 
           ggplot(aes(x = ano, ymin = limite.inferior, ymax = limite.superior)) +
           geom_errorbar(width = 3) +
           scale_x_continuous(breaks = pretty(anos.filtrados$ano, n = 15)) +
           labs(x="Ano do filme", y="Mediana")
       #selecionar qual quer ver é uma boa (ele se destaca da maioria)  

  })
  
  
   output$generofilme <- renderPlot({
   
     generos.filtrados = medianas.genero %>% 
       filter(genre %in% input$generos_checkbox)
     
     grafico = generos.filtrados %>% 
       ggplot(aes(x = as.character(genre), ymin = limite.inferior, ymax = limite.superior))+
       geom_errorbar(width = 1) +
       labs(x="Gênero do filme", y="Mediana") +
       theme(axis.text.x=element_text(angle = 45, hjust = 1))
     #selecionar qual quer ver é uma boa (ele se destaca da maioria)  
     
     
     print(grafico)

   })
  
})
