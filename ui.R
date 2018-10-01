# Define UI for application that draws a histogram

### Base files
library(shiny)
library(shinyWidgets) ### For bootstrap widgets
library(shinythemes) ### For bootstrap themes
library(plotly) ### Generate vizualizations
library(tidyverse) ### Generate vizualizations
library(dplyr)

### Auxiliary Files
source('common.R')
source('ReadData.R')
source('FeedData.R')

### Each viz page
source('PresidentialVotesByState.R')
source('HowEachStateVoted.R')
source('WhoWonEachState.R')
source('PartyMostVotedByState.R')

ui <- shiny::navbarPage(
  title = 'Brazilian Election',
  shiny::navbarMenu(
    'Analasys by Party',
    PartyMostVotedByState()
  ),
  shiny::navbarMenu(
    'Analasys by Candidate',
    PresidentialVotesByState(),
    WhoWonEachState()
  ),
  shiny::navbarMenu(
    'Analasys by State',
    HowEachStateVoted()
  ),
  theme = shinythemes::shinytheme(theme = "united")
)
