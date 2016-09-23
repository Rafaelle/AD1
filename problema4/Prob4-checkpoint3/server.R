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

boot = function(df= filmes.ano){
  experimento = sample_n(df, 1000, replace = TRUE)
  bootstrap.mediana = bootstrap(experimento, median(rating))
  mediana = CI.percentile(bootstrap.mediana, probs = c(.025, .975))
  return(mediana)
}

bootGenero = function(df= generos.filme){
  experimento = sample_n(df, 1000, replace = TRUE)
  bootstrap.mediana = bootstrap(experimento, median(rating))
  mediana = CI.percentile(bootstrap.mediana, probs = c(.025, .975))
  return(mediana)
}


medianas.ano = read.csv("medianas_filme.csv")
generos.filme = read.csv("generos_filme.csv")
medianas.genero = read.csv("medianas_genero.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$medianaAnoPlot <- renderPlot({
       anos.filtrados = medianas.ano %>% 
         filter(findInterval(ano, input$anos_input)==1)
       
       # plot_ly(anos.filtrados, 
       #         x = ano, 
       #         y = c(0,5), 
       #         mode = "markers", 
       #         text = paste("Ano: ", ano,
       #                      "<br> Limite inferior", limite.inferior, 
       #                      "<br> Limite superior:", limite.superior )) %>%
       #   layout(xaxis= list(title = "Quantidade total de bilhetes"),yaxis = list(title = "Gasto médio por bilhete (R$)"), 
       #          title="Quantidade de total de passageiros x Gasto médio por bilhete" )
       
       
       grafico = anos.filtrados %>% 
           ggplot(aes(x = ano, ymin = limite.inferior, ymax = limite.superior)) +
           geom_errorbar(width = 5) +
           scale_x_continuous(breaks = pretty(anos.filtrados$ano, n = 10)) +
           labs(x="Ano do filme", y="Mediana")
       #selecionar qual quer ver é uma boa (ele se destaca da maioria)  
       
       
         print(grafico)
        # 
        # grafico = ggplot(anos.filtrados) + 
        #    geom_errorbar(aes(x= ano, ymin= limite.inferior, ymax=limite.superior))
        # 
        # print(grafico)

  })
  
  
   output$generofilme <- renderPlot({
   
     x <- input$generos_checkbox
     
     generos.filtrados = medianas.genero %>% 
       filter(findInterval(genre, input$input$generos_checkbox)==1)
     # 
     # 
     # # Can use character(0) to remove all choices
     # if (is.null(x))
     #   x <- character(0)
     # 
     # # Can also set the label and select items
     # updateCheckboxGroupInput(session, "inCheckboxGroup2",
     #                          label = paste("Checkboxgroup label", length(x)),
     #                          choices = x,
     #                          selected = x)
   })
  
})
