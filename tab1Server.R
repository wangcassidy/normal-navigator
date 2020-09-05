tab1Server <- function(input,output){
  dn <- eventReactive(input$dgo, {dnorm(input$dx, input$dmean, input$dstdev)}, ignoreNULL = FALSE)
  vline <- eventReactive(input$dgo, {input$dx}, ignoreNULL = FALSE)
  mean <- eventReactive(input$dgo, {input$dmean}, ignoreNULL = FALSE)
  stdev <- eventReactive(input$dgo, {input$dstdev}, ignoreNULL = FALSE)
  
  output$dpdf <- renderPlot({
    x <- seq(mean() - 3 * stdev(), mean() + 3 * stdev(), length=200)
    y <- dnorm(x, mean(), stdev())
    plot(x, y, type="l", xlab="x", ylab="density", main="PDF of Normal Distribution")
    abline(v=vline(), col='gray')
    abline(h=dn(), col='red')
  })
  
  output$dnorm_output <- renderText({
    paste("Density = ", round(dn(), isolate(input$dround)))
  })
}

