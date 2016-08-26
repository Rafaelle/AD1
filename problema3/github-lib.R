
load_github_wide <- function(){
  emendas_area_parlamentar <- read.csv("emendas_area_parlamentar.csv")
  emendas_area_parlamentar <- emendas_area_parlamentar %>%
    filter(!is.na(NOME_PARLAMENTAR)) %>%
    mutate(total.gasto = colSums())
  
  return(emendas_area_parlamentar)
}



load_github_wide_detalhes <- function(){
  emendas_detalhes_parlamentar <- read.csv("emendas_detalhes_parlamentar.csv")
  emendas_detalhes_parlamentar <- emendas_detalhes_parlamentar %>%
    group_by(DESC_ORGAO_SUP, UF_PROPONENTE, funcao.imputada) %>%
    summarise(total.gasto = funcao.imputada)
    
    cast(DESC_ORGAO_SUP~funcao.imputada)
    summarise()
    
    
    
    filter(!is.na(NOME_PARLAMENTAR)) %>%
    mutate(total.gasto = colSums())
  
  return(emendas_area_parlamentar)
}



