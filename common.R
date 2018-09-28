GetVizOpts <- function(){
  VizOptVet <- c('Presidential Candidate votes by state',
                 'Presidential votes by round',
                 'Number of votes by office',
                 'Coalition relationships among parties',
                 'Presidential victory percentage by state',
                 'Most voted party by state')
  return(VizOptVet)
}

simpleCap <- function(X) {
  for(i in 1:length(X)){
    x <- X[i] %>% as.character()
    s <- strsplit(x, " ")[[1]]
    X[i] <- paste(substring(s, 1,1) %>% toupper(),
                  substring(s, 2) %>% tolower(), 
                  sep="", 
                  collapse=" ")
  }
  return(X)
}