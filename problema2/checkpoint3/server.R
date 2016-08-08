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
library(plotly)
theme_set(theme_bw())

source("import-data.R")
import_data()

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
  
  #output$view = renderDataTable({
  #  bilhete.aereo.por.deputado[bilhete.aereo.por.deputado$sgUF == input$checkbox, ]
  #})
  
  
#  output$plotEstado = renderPlot({
#    deputados.filtrados = bilhete.aereo.por.deputado %>% 
#      filter(sgUF %in% input$checkbox)

#    ggplot( deputados.filtrados,
#            aes(quantidade.bilhetes, gasto.medio.bilhete)) + 
#      geom_point(position = position_jitter(width = .5), 
#                 alpha = .4, 
#                 size = deputados.filtrados$total.passageiros) +
#      ylab("Médio gasto por bilhete (R$)") + 
#      xlab("Quantidade de bilhetes emitidos") 
#  })
  
  
  output$plotlyEstado <- renderPlotly({
    
    deputados.filtrados = bilhete.aereo.por.deputado %>% 
      filter(sgUF %in% input$checkbox)
    
    plot_ly(deputados.filtrados, 
            x = quantidade.bilhetes, 
            y = gasto.medio.bilhete, 
            mode = "markers", 
            group = sgUF , 
            marker=list( size=total.passageiros*4 , opacity=0.9),
            text = paste("Parlamentar: ", txNomeParlamentar,
                         "<br> Valor médio: R$", gasto.medio.bilhete, 
                         "<br> Bilhetes:", quantidade.bilhetes,
                         "<br> Total de passageiros:",total.passageiros )) %>%
      layout(xaxis= list(title = "Quantidade total de bilhetes"),yaxis = list(title = "Gasto médio por bilhete (R$)"), 
             title="Quantidade de total de passageiros x Gasto médio por bilhete" )
      
    
    #gg = ggplot( deputados.filtrados,
    #             aes(quantidade.bilhetes, gasto.medio.bilhete)) + 
    #  geom_point(position = position_jitter(width = .5), 
    #             alpha = .4, 
    #             size = deputados.filtrados$total.passageiros) +
    #  ylab("Médio gasto por bilhete (R$)") + 
    #  xlab("Quantidade de bilhetes emitidos") 
    
    
    #p <- ggplotly(gg)
    #p
  })
  
  


  
})
