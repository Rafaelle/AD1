#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

anos = medianas.ano$ano
range.ano = c(anos[1], anos[length(anos)])



shinyUI(fluidPage(
  
  
  # Application title
  titlePanel("Anos de lançamento dos filmes"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("anos_input", "Anos:", 
                  min = anos[1], 
                  max = anos[length(anos)], 
                  value = range.ano,
                  step = 1)),
    
    mainPanel(
      plotlyOutput("plotlyEstado")
    )
  )
  
  
))


