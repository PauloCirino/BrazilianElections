HowEachStateVoted <- function() {
  page <- shiny::tabPanel(
    title = 'Presidential votes by state',
    shiny::sidebarPanel(
      shinyWidgets::pickerInput(
        inputId = "StateChoice",
        label = "Select a State",
        choices = GetStatesName(),
        options = list(`live-search` = TRUE)
      )
    ),
    shiny::mainPanel(
      shiny::br(),
      plotly::plotlyOutput(outputId = 'HowEachStateVotedViz',
                           height = "600px")
    )
  )
  return(page)
}