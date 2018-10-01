# Define server logic required to draw a histogram
server <- function(input, output) {
  output$PresidentialVotesByStateViz <- plotly::renderPlotly({
    presidentialData %>%
      dplyr::filter(
        num_turn == 1,
        cat_state != 'ZZ',
        cat_candidate_name %>% as.character() %>% toupper() == input$PresidentialChoice %>% as.character() %>% toupper()
      ) %>%
      dplyr::mutate(
        cat_state = factor(x = cat_state %>% as.character(),
                           levels = cat_state[num_votes %>% order()]),
        toolTipText = paste(
          'Number of Votes = ',
          num_votes %>% format(big.mark =
                                 ",") ,
          '\n',
          'State = ',
          cat_state %>% StateAbbrToLong(),
          sep = ''
        )
      ) %>%
      plotly::plot_ly(
        x = ~ num_votes,
        y = ~ cat_state,
        text = ~ toolTipText,
        hoverinfo = 'text',
        type = 'bar',
        orientation = 'h'
      ) %>%
      plotly::layout(
        xaxis = list(
          title = "Number of Votes",
          titlefont = list(size = 18),
          nticks = 8
        ),
        yaxis = list(
          title = "State of Origin",
          titlefont = list(size = 18),
          tickfont = list(size = 12)
        ),
        title = paste(input$PresidentialChoice, 'votes by state on 1st turn')
      )
  })
  
  
  output$HowEachStateVotedViz <- plotly::renderPlotly({
    presidentialData %>%
      dplyr::filter(num_turn == 1,
                    cat_state != 'ZZ') %>%
      dplyr::mutate(cat_state_long = cat_state %>% StateAbbrToLong()) %>%
      dplyr::filter(cat_state_long  == input$StateChoice) %>%
      dplyr::mutate(
        cat_candidate_name = cat_candidate_name %>% as.character() %>% simpleCap(),
        toolTipText = paste(
          'Number of Votes = ',
          num_votes %>% format(big.mark =
                                 ",") ,
          '\n',
          'Candidate = ',
          cat_candidate_name,
          sep = ''
        )
      ) %>%
      dplyr::left_join(y = GetPresidentialCandidatesNameTable(),
                       by = c('cat_candidate_name' = 'Long')) %>%
      dplyr::mutate(Short = factor(x = Short %>% as.character(),
                                   levels = Short[num_votes %>% order()])) %>%
      plotly::plot_ly(
        x = ~ num_votes,
        y = ~ Short,
        text = ~ toolTipText,
        hoverinfo = 'text',
        type = 'bar',
        orientation = 'h',
        color = ~factor(Short, levels = c( GetPresidentialCandidatesNameShort(),
                                                             'Others')),
        colors = "Set1"
      ) %>%
      plotly::layout(
        xaxis = list(
          title = "Number of Votes",
          titlefont = list(size = 18),
          nticks = 8
        ),
        yaxis = list(
          title = "Candidate",
          titlefont = list(size = 18),
          tickfont = list(size = 12)
        ),
        title = paste(input$StateChoice, 'votes by candidate')
      )
  })
  
  
  
  output$WhoWonEachStateViz <- plotly::renderPlotly({
    TopCandidatesByState <- presidentialData %>%
      dplyr::filter(num_turn == 1,
                    cat_state != 'ZZ') %>%
      dplyr::group_by(cat_state) %>%
      dplyr::mutate(
        perc_votes = round(100 * num_votes / sum(num_votes), 2),
        long_state = cat_state %>% StateAbbrToLong(),
        Long = cat_candidate_name %>% as.character() %>% simpleCap()
      ) %>%
      dplyr::top_n(n = 1, wt = num_votes) %>%
      dplyr::ungroup() %>%
      dplyr::select(long_state, perc_votes, Long, cat_state) %>%
      dplyr::left_join(y = GetPresidentialCandidatesNameTable(),
                       by = 'Long')
    
    dplyr::bind_rows(
      TopCandidatesByState,
      TopCandidatesByState %>%
        dplyr::mutate(
          Short = 'Others',
          Long = 'All Other Candidates',
          perc_votes = 100 - perc_votes
        )
    ) %>%
      dplyr::mutate(
        toolTipText = paste(
          'State = ',
          long_state,
          '\nCandidate = ',
          Long,
          '\nPercentage of Votes = ',
          perc_votes,
          '%',
          sep = ''
        ),
        cat_state = factor(x = cat_state,
                            levels = cat_state[order(cat_state %>% as.character(), decreasing = TRUE)] %>%
                              unique())
      ) %>%
      plotly::plot_ly(
        x = ~ perc_votes,
        y = ~ cat_state,
        color = ~factor(Short, levels = c( GetPresidentialCandidatesNameShort(),
                                           'Others')),
        colors = "Set1",
        text = ~ toolTipText,
        hoverinfo = 'text',
        type = 'bar',
        orientation = 'h'
      ) %>%
      plotly::layout(
        barmode = 'stack',
        xaxis = list(
          title = "Percentage of Votes",
          titlefont = list(size = 18),
          nticks = 8
        ),
        yaxis = list(
          title = "State",
          titlefont = list(size = 18),
          tickfont = list(size = 12)
        ),
        title = paste('Winner of the 1st turn presidential election by state')
      )
  })
  
  output$PartyMostVotedByStateViz <- plotly::renderPlotly({
    mostVotedParties <- presidentialData %>%
      dplyr::group_by(cat_party) %>%
      dplyr::summarise(total_votes = sum(num_votes))
      
    presidentialData %>%
      dplyr::filter(num_turn == 1,
                    cat_state != 'ZZ') %>%
      dplyr::group_by(cat_state) %>%
      dplyr::mutate(
        perc_votes = round(100 * num_votes / sum(num_votes), 2),
        long_party = cat_party %>% PartyAbbrToLong(),
        long_state = cat_state %>% StateAbbrToLong(),
        Long = cat_candidate_name %>% as.character() %>% simpleCap()
      ) %>%
      dplyr::ungroup() %>%
      dplyr::select(long_state, perc_votes, Long, cat_state, cat_party, long_party) %>%
      dplyr::mutate(
        toolTipText = paste(
          'Party = ',
          cat_party,
          '\nState = ',
          long_state,
          '\nCandidate = ',
          Long,
          '\nPercentage of Votes = ',
          perc_votes,
          '%',
          sep = ''
        ),
        cat_state = factor(x = cat_state,
                           levels = cat_state[order(cat_state %>% as.character(), decreasing = TRUE)] %>%
                             unique()),
        cat_party = factor(x = cat_party,
                           levels = mostVotedParties$cat_party[mostVotedParties$total_votes %>% order(decreasing = TRUE)] %>% as.character())
      ) %>%
      plotly::plot_ly(
        x = ~ perc_votes,
        y = ~ cat_state,
        color = ~ cat_party,
        colors = "Set1",
        text = ~ toolTipText,
        hoverinfo = 'text',
        type = 'bar',
        orientation = 'h'
      ) %>%
      plotly::layout(
        barmode = 'stack',
        xaxis = list(
          title = "Percentage of Votes",
          titlefont = list(size = 18),
          nticks = 8
        ),
        yaxis = list(
          title = "State",
          titlefont = list(size = 18),
          tickfont = list(size = 12)
        ),
        title = paste('1st turn presidential election by state')
      )
  })
}