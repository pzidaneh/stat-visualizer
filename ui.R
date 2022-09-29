library(shiny)
library(shinydashboard)
library(bslib)
library(colourpicker)



ui <- fluidPage(theme = bs_theme(
  bg = "#00203FFF", fg = "White", primary = "#ADEFD1FF",
  base_font = font_google("Alata"),
  code_font = font_google("Alata")),
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
      selectInput("graphType", "Pilih tipe grafik",
                  choices=c("bar", "density")),
      selectInput("valueCol", "Pilih kolom nilai",
                  choices=NULL),
      selectInput("groupCol", "Pilih kolom pengelompokkan",
                  choices=NULL),
      br(),
      colourInput("warna", label = "Masukan warna chart",
                  value = "lightblue", returnName = T,
                  allowTransparent = T),
      br(),
      downloadButton("downloadPlot","Download Plot"),
      br(),
      downloadButton("downloadWC","Download WordCloud"),
    ),
    
    mainPanel(
      tabsetPanel(tabPanel("Data upload", tableOutput("table")),
                  tabPanel("Plot", plotOutput("plot")),
                  tabPanel("Word Cloud", verbatimTextOutput("wctest"), plotOutput("wordCloud"))
      )
    )
  )
)

