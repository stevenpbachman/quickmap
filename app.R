library(shiny)
library(leaflet)
#devtools::install_github('rstudio/httpuv@wch-print-req')
#library(rsconnect)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Quick map"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      helpText("the CSV must have 'LONGDEC' and 'LATDEC' fields, and will also accept fields for COLLECTOR,	NUMBER, and	YEAR."),
      fileInput("file1", NULL, multiple = FALSE, accept = (".csv"))
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      #plotOutput(outputId = "distPlot")
      leaflet::leafletOutput("mymap", width = "100%", height = 600)

      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {

# prepare the points
  pointsInput <- eventReactive(input$file1, {
    
    df <- read.csv(input$file1$datapath) #encoding = 'UTF-8')
    
  })
  
  
    
# output map
  output$mymap <- renderLeaflet({
    #df <- mapInput()
    #sptdwg = tdwg.dist = check.tdwg(input$powo)
    #sptdwg = merge(TDWG_polys, tdwg.dist)
    
    data = pointsInput()
    
    leaflet(data = data) %>%
      
      addCircleMarkers(lng = ~LONGDEC,
                       lat = ~LATDEC, 
                       radius = 4, 
                       color = "red",
                       popup = ~paste("Collector:", COLLECTOR, "<br>",
                                      "Number:",NUMBER, "<br>",
                                      "Collection year:", YEAR)) %>%
      
      addProviderTiles(providers$Esri.WorldImagery,
                     options = providerTileOptions(noWrap = TRUE)) 
      

})
}

# Run the application 
shinyApp(ui = ui, server = server)
