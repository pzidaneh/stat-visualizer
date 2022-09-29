library(shiny)
function(input, output, session) {
  
  Var1 <- reactive({
    req(input$df)
    Var1 <- read.csv(input$df$datapath,
                     header = input$header,
                     sep = input$separator)
    
    if (input$header == F) {
      main <<- NULL
      
    } else if (input$header == T) {
      main <<- colnames(Var1)
      
    }
    
    return(Var1)
  })
  output$table <- renderTable(Var1())
  
  GGPlot <- reactive({
    myGG <- ggplot(mapping = aes(x = Var1()[input$valueCol]))
                   
    if(input$graphType=="bar"){
      myGG <- myGG + geom_bar()
    } else if(input$graphType=="density"){
      myGG <- myGG + geom_density()
    }
    return(myGG)
  })
  output$plot<-renderPlot(GGPlot())
  
  
  
  
  

}