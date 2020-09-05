tab2UI <- tabPanel(
  "Cumulative Density",
  tabsetPanel(
    id="tail",
    tabPanel(
      "One tail",
      sidebarLayout(
        sidebarPanel(
          radioButtons("lr", "Tail", c("left", "right")),
          numericInput("mean1", "Mean", 0),
          numericInput("stdev1", "Standard Deviation", 1),
          numericInput("x1", "x", 0),
          numericInput("round1", "Max decimal places", 5),
          actionButton(inputId = "go1", label = "Calculate"),
          width = 3
        ),
        mainPanel(
          fluidRow(
            verticalLayout(
              splitLayout(cellWidths = c("50%", "50%"), plotOutput("one_tail_pdf"), plotOutput("one_tail_cdf")
              )
            )
          ),
          fluidRow(
            textOutput("one_tail_pnorm_output"),
            tags$head(tags$style("#one_tail_pnorm_output{color: black;
                                 font-size: 20px;}")
            )
          )
        )
      )
    ),
    tabPanel(
      "Range",
      sidebarLayout(
        sidebarPanel(
          numericInput("mean2", "Mean", 0),
          numericInput("stdev2", "Standard Deviation", 1),
          numericInput("lower", "Lower", -1),
          numericInput("upper", "Upper", 1),
          numericInput("round2", "Decimal places", 5),
          actionButton(inputId = "go2", label = "Update"),
          width = 3
        ),
        mainPanel(
          fluidRow(
            verticalLayout(
              splitLayout(cellWidths = c("50%", "50%"), plotOutput("two_tail_pdf"), plotOutput("two_tail_cdf")
              )
            )
          ),
          fluidRow(
            textOutput("two_tail_pnorm_output"),
            tags$head(tags$style("#two_tail_pnorm_output{color: black;font-size: 20px;}")
            )
          )      
        )
      )
    )
  )
)

