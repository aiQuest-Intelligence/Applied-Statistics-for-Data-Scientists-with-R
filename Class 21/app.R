library(shiny)
library(readxl)
library(DT)

built_in_datasets <- c("mtcars", "iris", "faithful")

ui <- fluidPage(
  titlePanel("Simple R Shiny App"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("data_source", 
                   "Choose Data Source:",
                   choices = c("Built-in Dataset","Upload Excel File"),
                   selected = "Built-in Dataset"),
      
      conditionalPanel(
        condition = "input.data_source == 'Built-in Dataset'",
        selectInput("built_in", "Select Built-in Dataset", choices = built_in_datasets)
      ),
      
      conditionalPanel(
        condition = "input.data_source == 'Upload Excel File'",
        fileInput("file", "Upload Excel File", accept = c("xlsx","xls")),
        uiOutput("sheet_ui")
      ),
      actionButton("submit", "Load Data")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Summary",
                 verbatimTextOutput("dataSummary")),
        tabPanel("Data Table",
                 DTOutput("dataTable"))
      )
    )
  )
)

server <- function(input, output, session) {
  
  output$sheet_ui <- renderUI({
    req(input$file)
    selectInput("sheet", "Select Sheet", choices = NULL)
  })
  
  observeEvent(input$file,{
    sheets <- excel_sheets(input$file$datapath)
    updateSelectInput(session, 
                      "sheet", 
                      "Select Sheet",
                      choices = sheets,
                      selected = sheets[1])
  })
  
  selected_data <- eventReactive(input$submit, {
    
    if(input$data_source == "Built-in Dataset"){
      get(input$built_in)
    }else{
      req(input$file, input$sheet)
      read_excel(input$file$datapath, sheet = input$sheet)
    }

  })
  
  output$dataTable <- renderDT({
    req(selected_data())
    datatable(selected_data())
  })

  output$dataSummary <- renderPrint({
    req(selected_data())
    summary(selected_data())
  })
  
}

shinyApp(ui, server)