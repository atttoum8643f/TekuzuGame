#' Vérifie si la grille de Takuzu est valide
#'
#' Cette fonction permet de vérifier si la grille de Takuzu remplie par le joueur respecte les règles de base du jeu.
#' Elle s'assure que chaque ligne et chaque colonne contiennent le même nombre de 1 et de 0, et que les cases non vides sont correctement équilibrées.
#'
#' @param grid Une matrice carrée représentant la grille de jeu de Takuzu. Chaque case peut contenir des valeurs \code{0}, \code{1}, ou \code{NA}.
#' @param size Taille de la grille (généralement une valeur pair, comme 6 ou 8).
#'
#' @return Un booléen (\code{TRUE} ou \code{FALSE}) indiquant si la grille est valide ou non, selon les règles du jeu Takuzu.
#'
#' @details
#' La grille est valide si chaque ligne et chaque colonne contiennent exactement la moitié de 0 et de 1 (sans compter les cases vides).
#' Si une ligne ou une colonne ne respecte pas cette règle, la grille est considérée comme invalide.
#'
#' @examples
#' # Générer une grille valide de Takuzu
#' valid_grid <- generate_valid_matrix(6)
#'
#' # Vérifier si la grille est valide
#' is_valid <- verifier_grille(valid_grid, 6)
#' print(is_valid)  # Devrait renvoyer TRUE
#'
#' @export
verifier_grille <- function(grid, size) {
  valid <- all(rowSums(!is.na(grid) & grid == 1, na.rm = TRUE) == size / 2) && 
    all(colSums(!is.na(grid) & grid == 1, na.rm = TRUE) == size / 2)
  return(valid)
}
