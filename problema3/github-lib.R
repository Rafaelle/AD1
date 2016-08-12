
load_github_wide <- function(){
  d <- read.csv("../dados/emendas_area_parlamentar.csv")
  
  # Somente o que queremos. E usaremos eventos/repo
  # d$events <- d$events / d$active_repos_by_url
  # d <- filter(d, year == 2014, quarter == 1, type != "CreateEvent") %>% 
  #   select(-active_repos_by_url, -year, -quarter)
  # d$type <- droplevels(d$type)
  # 
  # dw <- dcast(d, repository_language ~ type, value.var = "events")
  # dw <- filter(dw, complete.cases(dw))
  # return(dw)
  return(d)
}