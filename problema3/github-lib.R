
load_github_wide <- function(){
  emendas_area_parlamentar <- read.csv("../dados/emendas_area_parlamentar.csv")
  emendas_area_parlamentar <- emendas_area_parlamentar %>%
    filter(!is.na(NOME_PARLAMENTAR)) %>%
    mutate(total.gasto = colSums())
  
  return(emendas_area_parlamentar)
}