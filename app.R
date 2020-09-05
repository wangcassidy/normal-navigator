library(shiny)
source('tab1UI.R', local = TRUE)
source('tab1Server.R', local = TRUE)
source('tab2UI.R', local = TRUE)
source('tab2Server.R', local = TRUE)

ui <- navbarPage("Normal Navigator",
  tab1UI,
  tab2UI
)

server <- function(input, output) {
  tab1Server(input,output)
  tab2Server(input,output)
}

shinyApp(ui=ui, server=server)