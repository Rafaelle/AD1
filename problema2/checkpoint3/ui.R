#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
source("import-data.R")
import_data()

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  
  # Application title
  titlePanel("Emissão de Bilhete Aéreo"),
  p("Os dados ultilizados são referentes aos gastos dos deputados federais brasileiros no ano de 2016."),
  a(href="http://www2.camara.leg.br/transparencia/cota-para-exercicio-da-atividade-parlamentar/dados-abertos-cota-parlamentar", "Dados"),
  hr(),
  p("Escolhemos analisar a categoria de 'Emissão Bilhete Aéreo' e para melhor compreensão dos dados, usaremos apenas os gastos 
com 'valor liquido' positivo, pois os valores negativos significam que o referido bilhete é um bilhete de compensação, 
pois compensa um outro bilhete emitido e não utilizado pelo deputado."),
  hr(),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("checkbox",
                  label = "Estados:",
                  choices = levels(as.factor(gastos$sgUF)),
                  inline = TRUE)),

    # Show a plot of the generated distribution
    mainPanel(
      p("No gráfico abaixo podemos analisar os dados de cada deputado (representado por um ponto) divididos por estado, além disso, 
podemos verificar o total gasto pelo parlamentar em emissão de bilhetes, a média de gasto por bilhete e o tamanho do ponto 
        indica a quantidade de pessoas que viajam utilizando a cota do deputado."),
      hr(),
      #dataTableOutput("view"),
      #plotOutput("plotEstado"),
      plotlyOutput("plotlyEstado")
    )
  )
  
))
