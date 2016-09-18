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
library(stringr)
library(resample)

theme_set(theme_bw())

source("import-data.R")
import_data()

# Perguntas
# Os filmes mais populares possuem maiores avaliações?
# Como se comportam as avaliações por gênero de filmes? Quais possuem maior variabilidade?
# Como é a distribuição das avaliações e popularidade ao longo dos anos(de produção dos filmes)?

boot = function(df= filmes.ano){
  experimento = sample_n(df, 1000, replace = TRUE)
  bootstrap.mediana = bootstrap(experimento, median(rating))
  mediana = CI.percentile(bootstrap.mediana, probs = c(.025, .975))
  return(mediana)
}

#séries movieId = 108548, 108583, 40697

filmes.ano = filmes %>%
   rowwise() %>%
   mutate(ano = str_sub(title, start= -5, end = -2)) %>%
   filter(movieId != 108548) %>%
   filter( movieId != 108583) %>%
   filter(movieId != 40697) %>%
   ungroup()
 
medianas.filmes.por.ano = data.frame()

medianas.filmes.por.ano = filmes.ano %>%
  group_by(ano) %>%
  summarise("2.5%" = boot()[1], "97.5%" = boot()[2])
 
con<-file('medianas_filmes',encoding="UTF-8")

#write_csv(medianas.filmes.por.ano, "medianas_filme.csv")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
   
  # output$plotlyEstado <- renderPlotly({
  #   
  #   deputados.filtrados = bilhete.aereo.por.deputado %>% 
  #     filter(sgUF %in% input$checkbox)
  #   
  #   plot_ly(deputados.filtrados, 
  #           x = quantidade.bilhetes, 
  #           y = gasto.medio.bilhete, 
  #           mode = "markers", 
  #           group = sgUF , 
  #           marker=list( size=total.passageiros*4 , opacity=0.9),
  #           text = paste("Parlamentar: ", txNomeParlamentar,
  #                        "<br> Valor médio: R$", gasto.medio.bilhete, 
  #                        "<br> Bilhetes:", quantidade.bilhetes,
  #                        "<br> Total de passageiros:",total.passageiros )) %>%
  #     layout(xaxis= list(title = "Quantidade total de bilhetes"),yaxis = list(title = "Gasto médio por bilhete (R$)"), 
  #            title="Quantidade de total de passageiros x Gasto médio por bilhete" )
     
     
  
  
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
