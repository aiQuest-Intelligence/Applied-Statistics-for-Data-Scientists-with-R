# Load required libraries
library(shiny)
library(readxl)
library(DT)

# Define UI
ui <- fluidPage(
  titlePanel("Student Survey Data Dashboard"),
  
  # Tab layout
  tabsetPanel(
    tabPanel("Summary",
             verbatimTextOutput("dataSummary")),
    
    tabPanel("Data Table",
             DTOutput("dataTable"))
  )
)

# Define server logic
server <- function(input, output) {
  
  # Reactive function to read the dataset
  student_data <- reactive({
    read_excel("StudentSurveyData.xlsx")
  })
  
  # Render dataset summary
  output$dataSummary <- renderPrint({
    summary(student_data())
  })
  
  # Render dataset as a table
  output$dataTable <- renderDT({
    datatable(student_data(), options = list(pageLength = 10))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
