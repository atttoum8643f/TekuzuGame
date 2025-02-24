#' Cree une matrice de jeu Takuzu avec des cases vides selon la difficulte
#'
#' Cette fonction genere une matrice de jeu Takuzu en fonction de la difficulte choisie. Elle utilise une matrice de base valide (par exemple, generee par \code{generate_valid_matrix})
#' et remplace certaines cases par des \code{NA} pour rendre le jeu plus difficile selon le niveau specifie. Le taux de cases manquantes varie selon la difficulte.
#'
#' @param matrice_base Une matrice carree generee par \code{generate_valid_matrix}, representant la base valide du jeu.
#' @param difficulte Une chaine de caracteres specifiant le niveau de difficulte. Les options sont :
#'   \itemize{
#'     \item "facile" : ajoute environ 10% de cases manquantes.
#'     \item "avancee" : ajoute environ 25% de cases manquantes.
#'     \item "difficile" : ajoute environ 35% de cases manquantes.
#'   }
#'   Par defaut, la difficulte est "facile".
#'
#' @return Une matrice de meme taille que \code{matrice_base}, avec des cases vides (\code{NA}) reparties selon la difficulte choisie.
#'
#' @importFrom stats runif
#'
#' @examples
#' # Creer une matrice de Takuzu facile
#' base_matrice <- generate_valid_matrix(6)
#' matrice_facile <- creer_matrice_takuzu(base_matrice, difficulte = "facile")
#'
#' # Creer une matrice de Takuzu difficile
#' matrice_difficile <- creer_matrice_takuzu(base_matrice, difficulte = "difficile")
#'
#' @export
creer_matrice_takuzu <- function(matrice_base, difficulte = "facile") {
  grid <- matrice_base
  nrow_grid <- nrow(grid)
  ncol_grid <- ncol(grid)

  # Definition du taux de cases manquantes selon la difficulte
  prob_na <- switch(difficulte,
                    "facile" = 0.10,
                    "avancee" = 0.25,
                    "difficile" = 0.35,
                    stop("Difficulte non reconnue"))

  # Remplir la matrice avec des NA selon la probabilite
  for (i in 1:nrow_grid) {
    for (j in 1:ncol_grid) {
      if (runif(1) < prob_na) {
        grid[i, j] <- NA
      }
    }
  }

  return(grid)
}
