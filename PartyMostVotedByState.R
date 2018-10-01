PartyMostVotedByState <- function() {
  page <- shiny::tabPanel(
    title = 'Party most voted by state',
    shiny::mainPanel(
      shiny::br(),
      plotly::plotlyOutput(outputId = 'PartyMostVotedByStateViz',
                           height = "600px")
    )
  )
  return(page)
}