#' Crée une matrice de jeu Takuzu avec des cases vides selon la difficulté
#'
#' Cette fonction génère une matrice de jeu Takuzu en fonction de la difficulté choisie. Elle utilise une matrice de base valide (par exemple, générée par \code{generate_valid_matrix})
#' et remplace certaines cases par des \code{NA} pour rendre le jeu plus difficile selon le niveau spécifié. Le taux de cases manquantes varie selon la difficulté.
#'
#' @param matrice_base Une matrice carrée générée par \code{generate_valid_matrix}, représentant la base valide du jeu.
#' @param difficulte Une chaîne de caractères spécifiant le niveau de difficulté. Les options sont :
#'   \itemize{
#'     \item "facile" : ajoute environ 10% de cases manquantes.
#'     \item "avancee" : ajoute environ 25% de cases manquantes.
#'     \item "difficile" : ajoute environ 35% de cases manquantes.
#'   }
#'   Par défaut, la difficulté est "facile".
#'
#' @return Une matrice de même taille que \code{matrice_base}, avec des cases vides (\code{NA}) réparties selon la difficulté choisie.
#'
#' @examples
#' # Créer une matrice de Takuzu facile
#' base_matrice <- generate_valid_matrix(6)
#' matrice_facile <- creer_matrice_takuzu(base_matrice, difficulte = "facile")
#' 
#' # Créer une matrice de Takuzu difficile
#' matrice_difficile <- creer_matrice_takuzu(base_matrice, difficulte = "difficile")
#'
#' @export
creer_matrice_takuzu <- function(matrice_base, difficulte = "facile") {
  grid <- matrice_base
  nrow_grid <- nrow(grid)
  ncol_grid <- ncol(grid)
  
  # Définition du taux de cases manquantes selon la difficulté
  prob_na <- switch(difficulte,
                    "facile" = 0.10,
                    "avancee" = 0.25,
                    "difficile" = 0.35,
                    stop("Difficulté non reconnue"))
  
  # Remplir la matrice avec des NA selon la probabilité
  for (i in 1:nrow_grid) {
    for (j in 1:ncol_grid) {
      if (runif(1) < prob_na) {
        grid[i, j] <- NA
      }
    }
  }
  
  return(grid)
}
