# Load required library
library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Simple R Shiny Dashboard"),
  
  # Add tab layout
  tabsetPanel(
    tabPanel("Histogram",
             sidebarLayout(
               sidebarPanel(
                 sliderInput("bins",
                             "Number of bins:",
                             min = 5,
                             max = 30,
                             value = 12)
               ),
               mainPanel(
                 plotOutput("distPlot")
               )
             )
    ),
    
    tabPanel("Summary",
             verbatimTextOutput("dataSummary"))
  )
)

# Define server logic
server <- function(input, output) {
  
  # Render histogram
  output$distPlot <- renderPlot({
    data <- faithful$waiting
    hist(data, breaks = input$bins, col = "blue", border = "white",
         main = "Histogram of Waiting Time",
         xlab = "Waiting time (minutes)")
  })
  
  # Render summary
  output$dataSummary <- renderPrint({
    summary(faithful)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
