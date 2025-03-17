# Vérifier et installer shiny si nécessaire
if (!require(shiny)) {
  install.packages("shiny")
}

# Importer les fonctions nécessaires avec la directive @source
source("R/generate_valid_row.R")
source("R/rotate_vector.R")
source("R/generate_valid_matrix.R")
source("R/creer_matrice_takuzu.R")
source("R/verifier_grille.R")
source("R/ajuster_indices_takuzu.R")
source("R/server.R")
source("R/ui.R")

# Lancer l'application Shiny
shiny::shinyApp(ui, server)
