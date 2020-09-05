tab1UI <- tabPanel(
  "Density",
  sidebarLayout(
    sidebarPanel(
      numericInput("dmean", "Mean", 0),
      numericInput("dstdev", "Standard Deviation", 1),
      numericInput("dx", "x", 0),
      numericInput("dround", "Max decimal places", 5),
      actionButton(inputId = "dgo", label = "Calculate"),
      width = 3
    ),
    mainPanel(
      plotOutput("dpdf"),
      textOutput("dnorm_output"),
      tags$head(tags$style("#dnorm_output{color: black;
                             font-size: 20px;}")
      )
    )
  )
)