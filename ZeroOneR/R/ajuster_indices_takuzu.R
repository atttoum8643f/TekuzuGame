#' Ajuste les cases d'une matrice en fonction des erreurs du joueur
#'
#' Cette fonction permet de comparer une matrice de jeu pre-remplie par le joueur avec une matrice de base valide.
#' Les cases vides (\code{NA}) dans la matrice pre-remplie sont remplacees par les valeurs correspondantes de la matrice de base.
#' Cela permet d'ajuster la grille du jeu en fonction des erreurs du joueur et de completer la grille avec les bonnes valeurs.
#'
#' @param matrice_base Une matrice carree representant la matrice de base valide du jeu Takuzu, generee par une fonction comme \code{generate_valid_matrix}.
#' @param matrice_premplie Une matrice carree representant l'etat actuel du jeu apres que le joueur ait rempli certaines cases, avec des cases vides (\code{NA}).
#'
#' @source "generate_valid_matrix.R"
#'
#' @return Une matrice de meme taille que \code{matrice_premplie}, avec les cases vides (\code{NA}) remplacees par les valeurs correspondantes de \code{matrice_base}.
#'
#' @examples
#' # Generer une matrice valide de Takuzu
#' base_matrice <- generate_valid_matrix(6)
#'
#' # Une matrice pre-remplie par le joueur avec des erreurs (NA)
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

  # Trouver la premiere case vide (NA)
  for (i in 1:nrow_grid) {
    for (j in 1:ncol_grid) {
      if (is.na(grid[i, j])) {
        grid[i, j] <- matrice_base[i, j]  # Remplacement d'un seul element
        return(grid)  # Retourner la grille apres le premier remplacement
      }
    }
  }

  return(grid)
}
