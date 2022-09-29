library(shiny)
library(shinydashboard)
library(bslib)



ui <- fluidPage(theme = bs_theme(
          bg = "#B0E0E6", fg = "black", primary = "#87CEEB",
          base_font = font_google("Space Mono"),
          code_font = font_google("Space Mono")),
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
                                                  choices=NULL)
                                  
                                    ),
                                    
                                    mainPanel(
                                      
                                      tabsetPanel(
                                        tabPanel("Data upload", tableOutput("table")),
                                        tabPanel("Plot", plotOutput("plot")),
                                        tabPanel("Word Cloud"), plotOutput("wordCloud"))
                                      )
                                    )
                                  )


