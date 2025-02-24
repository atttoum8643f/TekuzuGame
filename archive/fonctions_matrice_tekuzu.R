# Fonction pour faire une rotation circulaire d'un vecteur
rotate_vector <- function(x, shift) {
  n <- length(x)
  return(c(x[(n - shift + 1):n], x[1:(n - shift)]))
}


generate_valid_matrix <- function(taille){
  q <- taille - 1
  x <- generate_valid_row(taille)
  init_mat <- matrix(c(x, rep(0,taille*q)), nrow = taille, ncol = taille)
  
  for (i in 1:q) {
    init_mat[,i+1] = c(x[(taille - i + 1):taille], x[1:(taille - i)])
  }
  return(init_mat)
}


generate_valid_row <- function(taille){
  vec <- rep(0, taille)
  i <- 1
  j <- 0
  
  # Traitement
  while (i < (taille + 1)) {
    j <- j + 1
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
  
  # Affichage
  return(vec)
  
}


generate_valid_row(10)
df <- data.frame(generate_valid_matrix(10))
