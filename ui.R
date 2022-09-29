library(shiny)
library(shinydashboard)

ui <- fluidPage(
  titlePanel("Stat Visualizer"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("df", "Upload File", 
                accept = c("text/csv", "text/coma-separated-values,text/plain")),
      checkboxInput("header", "Baris pertama kolom", T),
      radioButtons("separator", "Pemisah",
                   c(comma = ',',
                     semicolon = ';',
                     tab = '\t',
                     space = ' '),
                   selected = ";"),
      selectInput("variable", "Choose a variable",
                  choices=NULL
      ),
      
    ),
    
    mainPanel(
      
      tabsetPanel(
        tabPanel("Data upload", tableOutput("table")),
        tabPanel("Plot", plotOutput("plot")),
        tabPanel("Word Cloud"), plotOutput("wordCloud"))
    )
  )
)
