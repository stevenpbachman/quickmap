library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Quick map!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      fileInput("file1", NULL, multiple = FALSE, accept = (".csv"))
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      #plotOutput(outputId = "distPlot")
      leaflet::leafletOutput("mymap", width = "100%", height = 400)

      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
#

  
}
# Run the application 
shinyApp(ui = ui, server = server)
