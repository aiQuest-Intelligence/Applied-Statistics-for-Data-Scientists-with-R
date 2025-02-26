
# Load required library
library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Simple R Shiny Dashboard"),
  
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
)

# Define server logic
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # Generate random data
    data <- faithful$waiting
    
    # Create histogram
    hist(data, breaks = input$bins, col = "blue", border = "white",
         main = "Histogram of Waiting Time",
         xlab = "Waiting time (minutes)")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
