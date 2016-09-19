import_data <- function() {
  if (!exists("filmes") || is.null(filmes)) {
    filmes <<- read.csv("ratings-por-filme.csv")
  }
}


#séries movieId = 108548, 108583, 40697
# ESCREVI EM ARQUIVO, RODAR SÓ SE NECESSÁRIO
# filmes.ano = filmes %>%
#    rowwise() %>%
#    mutate(ano = str_sub(title, start= -5, end = -2)) %>%
#    filter(movieId != 108548) %>%
#    filter( movieId != 108583) %>%
#    filter(movieId != 40697) %>%
#    ungroup()
#  
# medianas.filmes.por.ano = data.frame()
# 
# medianas.filmes.por.ano = filmes.ano %>%
#   group_by(ano) %>%
#   summarise("limite.inferior" = boot()[1], "limite.superior" = boot()[2])
#  
#write_csv(medianas.filmes.por.ano, "medianas_filme.csv")

# l2w_genres = function(line){
#   resposta = rep(line, times = 1)
#   g = data.frame(genre = unlist(strsplit(as.character(line$genres), '[|]')))
#   g$title = line$title
#   return(full_join(as.data.frame(line), g))
# }
# 
# genero.filme = filmes %>%
#   #select(title, genres) %>%
#   rowwise() %>%
#   do(l2w_genres(.))
# write_csv(genero.filme, "generos_filme.csv")

