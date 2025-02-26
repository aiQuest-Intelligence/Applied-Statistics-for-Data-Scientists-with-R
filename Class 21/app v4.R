# Load required libraries
library(shiny)
library(readxl)
library(DT)

# Define UI
ui <- fluidPage(
  titlePanel("Student Survey Data Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload Excel File", accept = c(".xlsx")),
      uiOutput("sheet_ui")  # Dynamically generated UI for sheet selection
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Summary", verbatimTextOutput("dataSummary")),
        tabPanel("Data Table", DTOutput("dataTable"))
      )
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # Reactive expression to store uploaded file path
  file_path <- reactive({
    req(input$file)  # Ensure a file is uploaded
    input$file$datapath
  })
  
  # Observe the uploaded file and update the sheet selection UI
  observeEvent(input$file, {
    sheets <- excel_sheets(file_path())  # Get sheet names
    updateSelectInput(session, "sheet", "Select Sheet", choices = sheets, selected = sheets[1])
  })
  
  # Generate UI for sheet selection
  output$sheet_ui <- renderUI({
    req(input$file)
    selectInput("sheet", "Select Sheet", choices = NULL)
  })
  
  # Reactive function to read the selected sheet
  student_data <- reactive({
    req(input$file, input$sheet)  # Ensure file and sheet are selected
    read_excel(file_path(), sheet = input$sheet)
  })
  
  # Render dataset summary
  output$dataSummary <- renderPrint({
    req(student_data())
    summary(student_data())
  })
  
  # Render dataset as a table
  output$dataTable <- renderDT({
    req(student_data())
    datatable(student_data(), options = list(pageLength = 10))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
