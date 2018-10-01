WhoWonEachState <- function() {
  page <- shiny::tabPanel(title = 'Who won each State',
                          shiny::mainPanel(
                            shiny::br(),
                            plotly::plotlyOutput(outputId = 'WhoWonEachStateViz',
                                                 height = "600px")
                          ))
  return(page)
}