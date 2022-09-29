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
                                
                    

server <- function(input, output, session){
  
  filecontent <- reactive({
    req(input$file)
    filecontent <- read.csv(input$file$datapath, 
                            input$header1)
    
    if(input$header1 == F){
      main <<- NULL
    } else if(input$header1 == T){
      main <<- colnames(filecontent)
    }
    
    return(filecontent)
  })
  
  table1 <- reactive({
    tab <- table(filecontent())
    xlab <<- "Status Kepemilikan Rumah"
    ylab <<- "Frek."
    return(tab)
  })
  
  output$tablefile <- renderTable({
    return(table1())
  })
  
  output$plot <- renderPlot({
    return(barplot(table1(), xlab = xlab, 
                   ylab = ylab, main = main))
  })
  
  data1 <- reactive({
    req(input$file1)
    data1 <- read.csv(input$file1$datapath, header = input$header, sep = input$separator)
    if(input$header == F){
      main <<- NULL
    } else if(input$header == T){
      main <<- colnames(data1)
    }
    return(data1)
  })
  
  observe({
    updateSelectInput(session=session, 
                      inputId="variable", 
                      label="Choose a Variable: ",
                      choices = colnames(data1())[sapply(data1(), is.numeric)]
    )
  })
  
  output$image <- renderImage({
    return(list(
      src = "task2_logo.png",
      contentType = "image/png",
      width="30%", 
      alt = "Logo"))
  },deleteFile = FALSE)
  
  output$tablefile1 <- renderTable(
    return(head(data1()[input$variable]))
  )
  
  output$plotfile1 <- renderPlot(
    hist(as.numeric(data1()[[input$variable]]), 
         main = paste("Histogram of", input$variable),
         col = "bisque",
         xlab = input$variable)
  )
  
  output$plotfile2 <- renderPlot(
    boxplot(as.numeric(data1()[[input$variable]]), 
            horizontal = T,
            col ="bisque",
            xlab = input$variable)
  )
}

shinyApp(ui, server)

