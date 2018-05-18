# see
# - [x] https://stackoverflow.com/a/48781819
# - [ ] https://stackoverflow.com/questions/43679843/r-shiny-how-to-select-a-datatable-page-based-on-a-selected-row-when-the-row-ord/43680607

##############################################################################
# Libraries
##############################################################################

library(DT)
library(shiny)
library(leaflet)
library(RCurl)

##############################################################################
# Data
##############################################################################

myfile <- getURL('https://raw.githubusercontent.com/dirkseidensticker/aDRAC/master/data/aDRAC.csv', ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)
data <- read.csv(textConnection(myfile), header=T, sep=",")
data$id <- seq.int(nrow(data))
str(data)

##############################################################################
# UI Side
##############################################################################

ui <- shinyUI(
  fluidPage(
    titlePanel("aDRAC (Archives des datations radiocarbone d'Afrique centrale)"),
    fluidRow(column(12,
                    fluidRow(
                leafletOutput("map")),
             # fluidRow(
             #   column(3,
             #          selectInput("SITE",
             #                      "Site:",
             #                      c("All",
             #                        unique(as.character(data$SITE))))
             #   ),
             #   column(3,
             #          selectInput("FEATURE_DESC",
             #                      "Feature type:",
             #                      c("All",
             #                        unique(as.character(data$FEATURE_DESC))))
             #   ),
             #   column(3,
             #          selectInput("POTTERY",
             #                      "Associated Pottery Styles:",
             #                      c("All",
             #                        unique(as.character(data$POTTERY))))
             #   ),
             #   column(3,
             #          selectInput("MATERIAL",
             #                      "Dated material:",
             #                      c("All",
             #                        unique(as.character(data$MATERIAL))))
             #   )
             # ),
             # Create a new row for the table.
             fluidRow(
               DT::dataTableOutput("table")
             )
           )
        )
    )
  )

##############################################################################
# Server Side
##############################################################################

server <- shinyServer(function(input, output) {
  
  qSub <-  reactive({
    data
  })
  
  # table
  output$table <- DT::renderDataTable({
    DT::datatable(qSub(), 
                  selection = "single",
                  options=list(stateSave = TRUE))
  })
  
  # to keep track of previously selected row
  prev_row <- reactiveVal()
  
  # new icon style
  my_icon = makeAwesomeIcon(icon = 'flag', markerColor = 'red', iconColor = 'white')
  
  observeEvent(input$table_rows_selected, {
    row_selected = qSub()[input$table_rows_selected,]
    proxy <- leafletProxy('map')
    print(row_selected)
    proxy %>%
      addAwesomeMarkers(popup = as.character(row_selected$LABNR),
                        layerId = as.character(row_selected$id),
                        lng = row_selected$LONG, 
                        lat = row_selected$LAT,
                        icon = my_icon)
    
    # Reset previously selected marker
    if(!is.null(prev_row()))
    {
      proxy %>%
        addMarkers(popup = as.character(prev_row()$LABNR), 
                   layerId = as.character(prev_row()$id),
                   lng = prev_row()$LONG, 
                   lat = prev_row()$LAT)
    }
    # set new value to reactiveVal 
    prev_row(row_selected)
  })
  
  # map
  output$map <- renderLeaflet({
    qMap <- leaflet(data = qSub()) %>% 
      addTiles() %>%
      addMarkers(popup = ~as.character(LABNR), 
                 clusterOptions = markerClusterOptions())
    qMap
  })
  
  observeEvent(input$map_marker_click, {
    clickId <- input$map_marker_click$id
    dataTableProxy("table") %>%
      selectRows(which(data$id == clickId)) %>%
      selectPage(which(input$table_rows_all == clickId) %/% 
                   input$table_state$length + 1)
  })
  
  
})

# Run the application 
shinyApp(ui = ui, server = server)

