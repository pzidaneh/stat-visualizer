library(shiny)
library(ggplot2)
library(wordcloud)
library(memoise)
library(tm)
library(epos)
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
  observe({
    updateSelectInput(session=session, 
                      inputId="valueCol", 
                      label="Pilih Kolom Nilai: ",
                      choices = colnames(Var1()))
    updateSelectInput(session=session, 
                      inputId="groupCol", 
                      label="Pilih Kolom Pengelompokan: ",
                      choices = colnames(Var1())[!sapply(Var1(), is.numeric)])
  })
  output$table <- renderTable(Var1())
  
  myCol <- reactive(Var1()[input$valueCol])
  #myTable <- reactive(table(myCol()))
  
  GGPlot <- reactive({
    myGG <- ggplot(mapping = aes(x = unlist(myCol())))
                   
    if(input$graphType=="bar"){
      myGG <- myGG + geom_bar()
    } else if(input$graphType=="density"){
      myGG <- myGG + geom_density()
    }
    return(myGG)
  })
  output$plot<-renderPlot(GGPlot())
  
  #terms <- reactive({
    # Change when the "update" button is pressed...
    #input$update
    # ...but not for anything else
  #  isolate({
  #    withProgress({
  #      setProgress(message = "Processing corpus...")
  #      getTermMatrix(myCol())
  #    })
  #  })
  #})
  
  #wordcloud_rep <- repeatable(wordcloud)
  #myWC <- reactive({
  #  wordcloud_rep(names(myTable()), myTable(), min.freq = 1)
  #})
  
  #output$wordCloud <- renderPlot({
  #  v <- terms()
  #  wordcloud_rep(names(v), v, scale=c(4,0.5),
  #                min.freq = input$freq, max.words=input$max,
  #                colors=brewer.pal(8, "Dark2"))
  #})
  
  

}
