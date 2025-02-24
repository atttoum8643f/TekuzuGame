#' Génère une ligne valide pour le jeu Takuzu
#'
#' Cette fonction génère une ligne valide pour le jeu Takuzu en respectant les règles de base : 
#' - Chaque ligne doit être remplie de manière équilibrée avec des 0 et des 1,
#' - Il ne doit pas y avoir trois chiffres consécutifs identiques dans la ligne.
#' 
#' @param taille Un entier représentant la taille de la ligne à générer.
#' 
#' @return Un vecteur logique de taille \code{taille} contenant des valeurs 0 et 1.
#' 
#' @examples
#' # Génère une ligne valide de taille 8
#' generate_valid_row(8)
#'
#' @export
generate_valid_row <- function(taille) {
  # Initialisation du vecteur de la ligne
  vec <- rep(0, taille)
  i <- 1
  j <- 0
  
  # Remplissage de la ligne en respectant les contraintes
  while (i < (taille + 1)) {
    j <- j + 1
    
    # Gestion des triplets consécutifs
    if (j == 2) {
      t <- vec[i - 1] + vec[i]
      j <- 0
      if (t == 0) {
        vec[i] <- 1
      } else if (t == 2) {
        vec[i] <- 0
      }
    } else {
      vec[i] <- sample(c(0, 1), 1, prob = c(0.5, 0.5))
    }
    i <- i + 1
  }
  
  # Retourner la ligne générée
  return(vec)
}
