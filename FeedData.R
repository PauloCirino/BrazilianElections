GetVizOpts <- function() {
  VizOptVet <- c(
    'Presidential Candidate votes by state',
    'Presidential votes by round',
    'Number of votes by office',
    'Coalition relationships among parties',
    'Presidential victory percentage by state',
    'Most voted party by state'
  )
  return(VizOptVet)
}

GetPresidentialCandidatesNames <- function() {
  ### Orendening them by most voted to least voted on 1st turn
  presidentialData %>%
    dplyr::filter(num_turn == 1) %>%
    dplyr::group_by(cat_candidate_name) %>%
    dplyr::summarise(total_votes = sum(num_votes)) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(dplyr::desc(total_votes)) %>%
    dplyr::mutate(
      cat_candidate_name = cat_candidate_name %>% as.character(),
      cat_candidate_name = cat_candidate_name %>% simpleCap()
    ) %>%
    dplyr::select(cat_candidate_name) %>%
    unlist() %>%
    as.character()
}

GetPresidentialCandidatesNameShort <- function() {
  Short = c(
    'Dilma Rousseff',
    'Aécio Neves',
    'Marina Silva',
    'Luciana Genro',
    'Everaldo Dias',
    'Eduardo Jorge',
    'Levy Fidelix',
    'José Maria',
    'Eymael',
    'Mauro Luís',
    'Rui Costa'
  )
  return(Short)
  }
  
GetPresidentialCandidatesNameTable <- function() {
  x <-
    data.frame(
      Long = GetPresidentialCandidatesNames() %>% as.character(),
      Short = GetPresidentialCandidatesNameShort(),
      stringsAsFactors = FALSE
    )
  return(x)
}

GetStatesAbbr <- function() {
  x <- c(
    "AC",
    "AL",
    "AM",
    "AP",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MG",
    "MS",
    "MT",
    "PA",
    "PB",
    "PE",
    "PI",
    "PR",
    "RJ",
    "RN",
    "RO",
    "RR",
    "RS",
    "SC",
    "SE",
    "SP",
    "TO"
  )
  return(x)
}

GetStatesName <- function() {
  x <- c(
    "Acre",
    "Alagoas",
    "Amazonas",
    "Amapá",
    "Bahia",
    "Ceará",
    "Destrito Federa",
    "Espírito Santo",
    "Goiás",
    "Maranhão",
    "Minas Gerais",
    "Mato Grosso do Sul",
    "Mato Grosso",
    "Pará",
    "Paraíba",
    "Pernambuco",
    "Piauí",
    "Paraná",
    "Rio de Janeiro",
    "Rio Grande do Norte",
    "Rondônia",
    "Roraima",
    "Rio Grande do Sul",
    "Santa Catarina",
    "Sergipe",
    "São Paulo",
    "Tocantins"
  )
  return(x)
}

GetStatesNameTable <- function() {
  x <- data.frame(Abbr = GetStatesAbbr(),
                  Name = GetStatesName())
  return(x)
}

StateAbbrToLong <- function(X) {
  names <- GetStatesName()
  X <- as.character(X)
  for (i in 1:length(X)) {
    X[i] <- names[toupper(X[i]) == GetStatesAbbr()]
  }
  return(X)
}


GetPartyNames <- function() {
  x <- c(
    "Partido Socialista dos Trabalhadores Unificado",
    "Partido Renovador Trabalhista Brasileiro",
    "Partido Comunista Brasileiro",
    "Partido Socialismo e Liberdade",
    "Partido Verde",
    "Partido Social Cristão",
    "Democracia Cristã",
    "Partido da Causa Operária",
    "Partido dos Trabalhadores",
    "Partido da Social Democracia Brasileira",
    "Partido Socialista Brasileiro"
  )
  return(x)
}

GetPartyAbbr <- function(x){
  x <- c("PSTU",
         "PRTB",
         "PCB",
         "PSOL",
         "PV",
         "PSC",
         "PSDC",
         "PCO",
         "PT",
         "PSDB",
         "PSB")
  return(x)
}

PartyAbbrToLong <- function(X){
  names <- GetPartyNames()
  abbrs <-  GetPartyAbbr()
  X <- as.character(X)
  for (i in 1:length(X)) {
    X[i] <- names[toupper(X[i]) == abbrs]
  }
  return(X)
}

CandidateLongToShort <- function(X) {
  names <- GetStatesName()
  X <- as.character(X)
  for (i in 1:length(X)) {
    X[i] <- names[toupper(X[i]) == GetStatesAbbr()]
  }
  return(X)
}