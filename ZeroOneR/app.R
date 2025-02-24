# Vérifier et installer shiny si nécessaire
if (!require(shiny)) {
  install.packages("shiny")
}

# Importer les fonctions nécessaires avec la directive @source
#' @source "generate_valid_row.R"
#' @source "rotate_vector.R"
#' @source "generate_valid_matrix.R"
#' @source "creer_matrice_takuzu.R"
#' @source "verifier_grille.R"
#' @source "ajuster_indices_takuzu.R"
#' @source "ui.R"

# Lancer l'application Shiny
shiny::runApp("app.R")
