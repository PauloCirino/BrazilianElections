GetPresidentialCandidatesNames <- function(){
  ### Orendening them by most voted to least voted on 1st turn
  presidentialData %>%
    dplyr::filter(num_turn == 1) %>%
    dplyr::group_by(cat_candidate_name) %>%
    dplyr::summarise(total_votes = sum(num_votes)) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(dplyr::desc(total_votes)) %>%
    dplyr::mutate(cat_candidate_name = cat_candidate_name %>% as.character(),
                  cat_candidate_name = cat_candidate_name %>% simpleCap()) %>%
    dplyr::select(cat_candidate_name) %>%
    unlist() %>% 
    as.character() 
}

GetStatesAbbr <- function(){
  x <- c("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES",
         "GO", "MA", "MG", "MS", "MT", "PA", "PB", "PE",
         "PI", "PR", "RJ", "RN", "RO", "RR", "RS", "SC",
         "SE", "SP", "TO")
  return(x)
}

GetStatesName <- function(){
  x <- c("Acre", "Alagoas", "Amazonas", "Amapá", "Bahia", "Ceará",
         "Destrito Federa", "Espírito Santo", "Goiás", "Maranhão",
         "Minas Gerais", "Mato Grosso do Sul", "Mato Grosso",
         "Pará", "Paraíba", "Pernambuco", "Piauí", "Paraná",
         "Rio de Janeiro", "Rio Grande do Norte", "Rondônia",
         "Roraima", "Rio Grande do Sul", "Santa Catarina",
         "Sergipe", "São Paulo", "Tocantins")
  return(x)
}

GetStatesNameTable <- function(){
  x <- data.frame(Abbr = GetStatesAbbr(),
                  Name = GetStatesName())
  return(x)
}

StateAbbrToLong <- function(x){
  names <- GetStatesName()
  x <- names[toupper(x) == toupper(GetStatesAbbr())]
  return(x)
}