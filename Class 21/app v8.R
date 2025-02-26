# Load required libraries
library(shiny)
library(readxl)
library(DT)
library(ggplot2)
library(plotly)

# List of built-in datasets
built_in_datasets <- c("mtcars", "iris", "faithful")

# Define UI
ui <- fluidPage(
  
  # Application Title
  titlePanel("Student Survey Data Dashboard"),
  
  # Sidebar layout
  sidebarLayout(
    
    # Sidebar Panel
    sidebarPanel(
      width = 3,  # Adjust width to keep more space for the main panel
      
      # Dataset selection (built-in or upload)
      radioButtons("data_source", "Choose Data Source:",
                   choices = c("Built-in Dataset", "Upload Excel File"),
                   selected = "Built-in Dataset"),
      
      # Built-in dataset selection
      conditionalPanel(
        condition = "input.data_source == 'Built-in Dataset'",
        selectInput("built_in", "Select Built-in Dataset", choices = built_in_datasets)
      ),
      
      # File upload for custom dataset
      conditionalPanel(
        condition = "input.data_source == 'Upload Excel File'",
        fileInput("file", "Upload Excel File", accept = c(".xlsx")),
        uiOutput("sheet_ui")  # Sheet selection UI
      ),
      
      actionButton("submit", "Load Data", class = "btn-primary")  # Submit button
    ),
    
    # Main Panel
    mainPanel(
      width = 9,  # Give more space for visualization and data
      tabsetPanel(
        tabPanel("Summary", verbatimTextOutput("dataSummary")),
        tabPanel("Data Table", DTOutput("dataTable")),
        
        # Visualization Tab
        tabPanel("Visualization",
                 fluidRow(
                   column(4,
                          selectInput("var_x", "Select X Variable", choices = NULL),
                          selectInput("var_y", "Select Y Variable (Optional)", choices = NULL),
                          selectInput("color_by", "Color by (Categorical Variable)", choices = NULL, selected = "None"),
                          selectInput("plot_type", "Select Plot Type",
                                      choices = c("Histogram", "Boxplot", "Scatter Plot")),
                          actionButton("plot_button", "Generate Plot", class = "btn-success")
                   ),
                   column(8,
                          plotlyOutput("plot", height = "500px")  # Larger plot area
                   )
                 )
        )
      )
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # Reactive expression for file path
  file_path <- reactive({
    req(input$file)
    input$file$datapath
  })
  
  # Observe uploaded file and update sheet selection
  observeEvent(input$file, {
    sheets <- excel_sheets(file_path())  # Get sheet names
    updateSelectInput(session, "sheet", "Select Sheet", choices = sheets, selected = sheets[1])
  })
  
  # Generate UI for sheet selection dynamically
  output$sheet_ui <- renderUI({
    req(input$file)
    selectInput("sheet", "Select Sheet", choices = NULL)
  })
  
  # Reactive function to load data based on user selection
  selected_data <- eventReactive(input$submit, {
    if (input$data_source == "Built-in Dataset") {
      get(input$built_in)  # Load built-in dataset
    } else {
      req(input$file, input$sheet)
      read_excel(file_path(), sheet = input$sheet)  # Load uploaded Excel sheet
    }
  })
  
  # Update variable selection dropdowns when data is loaded
  observeEvent(selected_data(), {
    numeric_vars <- names(selected_data())[sapply(selected_data(), is.numeric)]
    categorical_vars <- names(selected_data())[sapply(selected_data(), function(x) is.character(x) | is.factor(x))]
    
    updateSelectInput(session, "var_x", choices = numeric_vars)
    updateSelectInput(session, "var_y", choices = c("None", numeric_vars), selected = "None")
    updateSelectInput(session, "color_by", choices = c("None", categorical_vars), selected = "None")
  })
  
  # Render dataset summary
  output$dataSummary <- renderPrint({
    req(selected_data())
    summary(selected_data())
  })
  
  # Render dataset in a table
  output$dataTable <- renderDT({
    req(selected_data())
    datatable(selected_data(), options = list(pageLength = 10))
  })
  
  # Generate the interactive plot based on user selection
  output$plot <- renderPlotly({
    req(selected_data(), input$var_x, input$plot_type, input$plot_button)
    
    data <- selected_data()
    plot_type <- input$plot_type
    x_var <- input$var_x
    y_var <- input$var_y
    color_var <- if (input$color_by != "None") input$color_by else NULL
    
    # Create ggplot based on selection
    p <- ggplot(data, aes_string(x = x_var, color = color_var, fill = color_var))
    
    if (plot_type == "Histogram") {
      p <- p + geom_histogram(alpha = 0.6, bins = 20, position = "identity") +
        labs(title = paste("Histogram of", x_var))
    } else if (plot_type == "Boxplot") {
      p <- p + geom_boxplot(alpha = 0.7) +
        labs(title = paste("Boxplot of", x_var))
    } else if (plot_type == "Scatter Plot") {
      req(y_var != "None")
      p <- p + aes_string(y = y_var) + geom_point(size = 3, alpha = 0.7) +
        labs(title = paste("Scatter Plot of", x_var, "vs", y_var))
    }
    
    p <- p + theme_minimal()
    
    ggplotly(p)  # Convert ggplot to interactive plotly
  })
}

# Run the application
shinyApp(ui = ui, server = server)
