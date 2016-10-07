#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source("import-data.R")
import_data()
anos = medianas.ano$ano
range.ano = c(anos[1], anos[length(anos)])

shinyUI(fluidPage(
  # Application title
  titlePanel("Dados de opiniões sobre filmes"),
  p("Os dados ultilizados possuem as avaliações de 250 mil usuários já consolidadas por filme (aqui considerando apenas filmes com mais de cem avaliações)."),
  a(href=" https://drive.google.com/open?id=0B2rlaHwjOlZAdnF1TGpDZ1RPYWM (Links para um site externo)", "Dados"),
  hr(),
  p("Iremos analisar a distribuição das avaliações e popularidade ao longo dos anos(de laçamento), e para isso utilizaremos a mediana como forma de comparação."),
  hr(),
  sidebarLayout(
    sidebarPanel(
      sliderInput("anos_input", "Anos:", 
                  min = anos[1], 
                  max = anos[length(anos)], 
                  value = range.ano,
                  step = 1)),
    
    mainPanel(
      plotOutput("medianaAnoPlot",
                 hover = "plot_hover")
    )
  ),
  
  hr(),
  p(" Agora iremos analisar os genêros, como se comportam as avaliações por gênero de filmes?, Para isso utilizaremos a mediana como forma de comparação."),
  hr(),
  
   sidebarLayout(
     sidebarPanel(
       checkboxGroupInput("generos_checkbox",
                          label = "Gêneros:",
                          choices = levels(as.factor(generos.filme$genre)),
                          inline = FALSE)),
     
     # Show a plot of the generated distribution
     mainPanel(
       plotOutput("generofilme")
     )
   )
   
  
  
))


