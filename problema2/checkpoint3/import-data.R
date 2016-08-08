import_data <- function() {
  if (!exists("gastos") || is.null(gastos)) {
    gastos <<- read.csv("ano-atual.csv")
  }
}