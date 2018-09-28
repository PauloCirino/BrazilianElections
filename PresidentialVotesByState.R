PresidentialVotesByState <- function(){
 page <- shiny::tabPanel(title = 'Presidential votes by state',
                         shiny::sidebarPanel(
                           shinyWidgets::pickerInput(inputId = "PresidentialChoice", 
                                                     label = "Select a Presidential Candidate",
                                                     choices = GetPresidentialCandidatesNames(),
                                                     options = list(`live-search` = TRUE)
                                                     )
                           ),
                         shiny::mainPanel(shiny::br(),
                                          shiny::br(),
                                          plotly::plotlyOutput(outputId = 'PresidentialVotesByStateViz',
                                                               height = "600px"))
                  )
 return(page)
}