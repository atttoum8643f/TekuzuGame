#' Effectue une rotation circulaire d'un vecteur
#'
#' Cette fonction effectue une rotation circulaire d'un vecteur en déplaçant ses éléments vers la droite ou la gauche,
#' selon le nombre de positions spécifié par l'argument \code{shift}.
#' Les éléments sont déplacés et réintégrés à l'extrémité opposée de la séquence.
#'
#' @param x Un vecteur de valeurs (par exemple, numériques, logiques, ou de caractères) à faire tourner.
#' @param shift Un entier représentant le nombre de positions à décaler. \code{shift} est toujours positif, et la rotation se fait vers la droite.
#'
#' @return Un vecteur de même type et longueur que \code{x}, avec les éléments tournés.
#'
#' @examples
#' # Effectuer une rotation à droite de 2 positions
#' rotate_vector(c(1, 2, 3, 4, 5), 2)
#'
#' @export
rotate_vector <- function(x, shift) {
  # Calcul de la longueur du vecteur
  n <- length(x)
  
  # Effectuer la rotation circulaire
  return(c(x[(n - shift + 1):n], x[1:(n - shift)]))
}
