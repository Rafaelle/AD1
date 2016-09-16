import_data <- function() {
  if (!exists("filmes") || is.null(filmes)) {
    filmes <<- read.csv("ratings-por-filme.csv")
  }
}
