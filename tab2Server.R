tab2Server <- function(input,output){
  lpnorm <- eventReactive(input$go1, {pnorm(input$x1, input$mean1, input$stdev1)}, ignoreNULL = FALSE)
  rpnorm <- eventReactive(input$go1, {pnorm(input$x1, input$mean1, input$stdev1, lower.tail = FALSE)}, ignoreNULL = FALSE)
  
  vline <- eventReactive(input$go1, {input$x1}, ignoreNULL = FALSE)
  mean1 <- eventReactive(input$go1, {input$mean1}, ignoreNULL = FALSE)
  mean2 <- eventReactive(input$go2, {input$mean2}, ignoreNULL = FALSE)
  stdev1 <- eventReactive(input$go1, {input$stdev1}, ignoreNULL = FALSE)
  stdev2 <- eventReactive(input$go2, {input$stdev2}, ignoreNULL = FALSE)
  lower <- eventReactive(input$go2, {input$lower}, ignoreNULL = FALSE)
  upper <- eventReactive(input$go2, {input$upper}, ignoreNULL = FALSE)
  
  output$one_tail_pdf <- renderPlot({
    x <- seq(mean1() - 3 * stdev1(), mean1() + 3 * stdev1(), length=500)
    y <- dnorm(x, mean1(), stdev1())
    plot(x, y, type="l", xlab="x", ylab="Density", main="PDF of Normal Distribution")
    
    if (isolate(input$lr) == "left") {
      polygon(c(min(x), x[x<=vline()], vline()), c(0, y[x<=vline()], 0), col="red")
    } else if (isolate(input$lr) == "right") {
      polygon(c(x[x>=vline()], max(x), vline()), c(y[x>=vline()], 0, 0), col="red")
    }
  })
  
  output$one_tail_cdf <- renderPlot({
    x <- seq(mean1() - 3 * stdev1(), mean1() + 3 * stdev1(), length=200)
    y <- pnorm(x, mean1(), stdev1())
    plot(x, y, type="l", xlab="x", ylab="Cumulative Density", main="CDF of Normal Distribution")
    if (isolate(input$lr) == "left") {
      abline(v=vline(), col="gray")
      abline(h=lpnorm(), col="red")
    } else if (isolate(input$lr) == "right") {
      abline(h=lpnorm(), col="red")
      abline(h=1, col="red")
      abline(v=isolate(input$x1), col="gray")
      abline(v=max(x), col="gray")
    }
  })
  
  output$one_tail_pnorm_output <- renderText({
    if (isolate(input$lr) == "left") {
      paste("P(X < x) = ", round(lpnorm(), isolate(input$round1)))
    } else if (isolate(input$lr) == "right") {
      paste("P(X > x) = ", round(rpnorm(), isolate(input$round1)))
    }
  })
  
  output$two_tail_pdf <- renderPlot({
    x <- seq(mean2() - 3 * stdev2(), mean2() + 3 * stdev2(), length=200)
    y <- dnorm(x, mean2(), stdev2())
    plot(x, y, type="l", xlab="x", ylab="Density", main="PDF of Normal Distribution")
    polygon(c(lower(), x[(x>=lower()) & (x<=upper())], upper()), c(0, y[(x>=lower()) & (x<=upper())], 0), col="red")
  })
  
  output$two_tail_cdf <- renderPlot({
    x <- seq(mean2() - 3 * stdev2(), mean2() + 3 * stdev2(), length=200)
    y <- pnorm(x, isolate(mean2()), isolate(stdev2()))
    plot(x, y, type="l", xlab="x", ylab="Cumulative Density", main="CDF of Normal Distribution")
    abline(h=pnorm(lower(), mean2(), stdev2(), lower.tail = TRUE), col="red")
    abline(h=pnorm(upper(), mean2(), stdev2(), lower.tail = TRUE), col="red")
    abline(v=lower(), col="gray")
    abline(v=upper(), col="gray")
  })

  output$two_tail_pnorm_output <- renderText({
      paste("P(lower < X < upper) = ", round(pnorm(upper(), mean2(), stdev2(), lower.tail = TRUE) - pnorm(lower(), isolate(mean2()), isolate(stdev2()), lower.tail = TRUE), isolate(input$round2)))
  })
}

