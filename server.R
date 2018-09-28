# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$PresidentialVotesByStateViz <- plotly::renderPlotly({
    presidentialData %>%
      dplyr::filter(num_turn == 1,
                    cat_state != 'ZZ',
                    cat_candidate_name %>% as.character() %>% toupper() == input$PresidentialChoice %>% as.character() %>% toupper()) %>%
      dplyr::mutate(cat_state = factor(x = cat_state %>% as.character(),
                                       levels = cat_state[num_votes %>% order()]),
                    toolTipText = paste('Number of Votes = ', 
                                        num_votes %>% format(big.mark=",") , '\n', 
                                        'State = ', cat_state %>% StateAbbrToLong(),
                                        sep = '')) %>%
      plotly::plot_ly(x = ~num_votes,
                      y = ~cat_state,
                      text = ~toolTipText,
                      hoverinfo = 'text',
                      type = 'bar',
                      orientation = 'h') %>%
      plotly::layout(xaxis = list(title = "Number of Votes",
                                  titlefont = list(size = 18),
                                  nticks = 8),
                     yaxis = list(title = "State of Origin",
                                  titlefont = list(size = 18),
                                  tickfont = list(size = 12)),
                     title = paste(input$PresidentialChoice, 'votes by state')
                    )
      
  })
  
  
}