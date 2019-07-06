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
    fluidRow(column(3,
                    fluidRow(
                leafletOutput("map")
                )),
             column(9, 
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
  
  # map
  output$map <- renderLeaflet({
    qMap <- leaflet(data = qSub()) %>% 
      addTiles() %>%
      addCircles(label = ~as.character(SITE), 
                 popup = ~as.character(SITE), 
                 color = ~C14AGE)
    qMap
  })

})

# Run the application 
shinyApp(ui = ui, server = server)

