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
library(readr)
library(ggplot2)
theme_set(theme_bw())

gastos = read_csv("~/ufcg/AD1/dados/ano-atual.csv")

emissao.bilhete.aereo = gastos %>%
  group_by(txtDescricao) %>%
  filter(txtDescricao == "Emissão Bilhete Aéreo" & vlrLiquido >= 0)


bilhete.aereo.por.deputado = emissao.bilhete.aereo %>%
  group_by(sgUF, txNomeParlamentar) %>%
  summarise(total.passageiros = length(unique(txtPassageiro)), 
            total.vlrLiquido = sum(vlrLiquido), 
            gasto.medio.bilhete = mean(total.vlrLiquido/length(unique(txtNumero))), 
            quantidade.bilhetes = length(unique(txtNumero)))  %>%
  arrange(-total.passageiros)

shinyServer(function(input, output) {
  
  
  output$plotEstado = renderPlot({
    deputados.filtrados = bilhete.aereo.por.deputado %>% 
      filter(sgUF %in% input$checkbox)
    
    ggplot( deputados.filtrados,
            aes(quantidade.bilhetes, gasto.medio.bilhete)) + 
      geom_point(position = position_jitter(width = .5), 
                 alpha = .4, 
                 size = deputados.filtrados$total.passageiros/2)
  })
   
  
  output$view = renderDataTable({
    bilhete.aereo.por.deputado[bilhete.aereo.por.deputado$sgUF == input$checkbox, ]
  })
  
})
