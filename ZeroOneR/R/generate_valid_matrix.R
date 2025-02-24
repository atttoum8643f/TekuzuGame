#' Génère une matrice valide pour le jeu Takuzu
#'
#' Cette fonction génère une matrice carrée valide pour le jeu Takuzu. Elle utilise la fonction \code{generate_valid_row} pour 
#' générer une ligne valide, puis crée une matrice en déplaçant cette ligne de manière circulaire pour chaque ligne suivante.
#' Les règles du jeu Takuzu sont respectées : chaque ligne contient autant de 0 que de 1, et les lignes sont des rotations 
#' circulaires de la ligne générée initialement.
#'
#' @param taille Un entier représentant la taille de la matrice carrée à générer (par exemple, 8 pour une matrice de 8x8).
#'
#' @return Une matrice carrée de taille \code{taille}x\code{taille} remplie de 0 et 1, où chaque ligne est une rotation circulaire de la première ligne.
#'
#' @source "generate_valid_row.R"
#' @source "rotate_vector.R"
#'
#' @examples
#' # Générer une matrice valide de taille 6x6
#' generate_valid_matrix(6)
#'
#' @export
generate_valid_matrix <- function(taille) {
  # Initialisation
  q <- taille - 1
  x <- generate_valid_row(taille)
  
  # Création de la matrice avec la première ligne valide
  init_mat <- matrix(c(x, rep(0, taille * q)), nrow = taille, ncol = taille)
  
  # Remplissage des autres lignes par rotation circulaire de la première ligne
  for (i in 1:q) {
    init_mat[, i + 1] <- c(x[(taille - i + 1):taille], x[1:(taille - i)])
  }
  
  return(init_mat)
}
