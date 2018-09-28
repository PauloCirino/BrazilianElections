### Libraries
library(shiny)
library(shinyWidgets) ### For bootstrap widgets
library(shinythemes) ### For bootstrap themes
library(plotly) ### Generate vizualizations
library(tidyverse) ### Generate vizualizations

### Auxiliary Files
source('common.R')
source('ReadData.R')

### Each viz page
source('PresidentialVotesByState.R')

### Base files
source('ui.R')
source('server.R')

# Run the application 
shiny::shinyApp(ui = ui, server = server)

