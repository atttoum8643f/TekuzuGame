#' Ajuste les cases d'une matrice en fonction des erreurs du joueur
#'
#' Cette fonction permet de comparer une matrice de jeu pré-remplie par le joueur avec une matrice de base valide. 
#' Les cases vides (\code{NA}) dans la matrice pré-remplie sont remplacées par les valeurs correspondantes de la matrice de base.
#' Cela permet d'ajuster la grille du jeu en fonction des erreurs du joueur et de compléter la grille avec les bonnes valeurs.
#'
#' @param matrice_base Une matrice carrée représentant la matrice de base valide du jeu Takuzu, générée par une fonction comme \code{generate_valid_matrix}.
#' @param matrice_premplie Une matrice carrée représentant l'état actuel du jeu après que le joueur ait rempli certaines cases, avec des cases vides (\code{NA}).
#'
#' @source "generate_valid_matrix.R"
#'
#' @return Une matrice de même taille que \code{matrice_premplie}, avec les cases vides (\code{NA}) remplacées par les valeurs correspondantes de \code{matrice_base}.
#'
#' @examples
#' # Générer une matrice valide de Takuzu
#' base_matrice <- generate_valid_matrix(6)
#'
#' # Une matrice pré-remplie par le joueur avec des erreurs (NA)
#' matrice_joueur <- base_matrice
#' matrice_joueur[1,1] <- NA
#' matrice_joueur[2,2] <- NA
#'
#' # Ajuster les erreurs du joueur
#' matrice_corrigee <- ajuster_indices_takuzu(base_matrice, matrice_joueur)
#'
#' @export
ajuster_indices_takuzu <- function(matrice_base, matrice_premplie) {
  grid <- matrice_premplie
  nrow_grid <- nrow(grid)
  ncol_grid <- ncol(grid)
  
  # Remplacer les cases vides (NA) par celles de la matrice de base
  for (i in 1:nrow_grid) {
    for (j in 1:ncol_grid) {
      if (is.na(grid[i, j])) {
        grid[i, j] <- matrice_base[i, j]
      }
    }
  }
  return(grid)
}
