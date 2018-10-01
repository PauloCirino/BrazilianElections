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