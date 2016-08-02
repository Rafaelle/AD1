#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  headerPanel("Emissão de Bilhete Aéreo"),
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("checkbox", 
                         label = "Estados:", 
                         choices = levels(as.factor(gastos$sgUF))),
      mainPanel(
        dataTableOutput("view")
      )
    )
    
  )
  
))
