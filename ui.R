# Define UI for application that draws a histogram
ui <- shiny::navbarPage( title = 'Brazilian Election',
  PresidentialVotesByState(),
  theme = shinythemes::shinytheme("united")
)
