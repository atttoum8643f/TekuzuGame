#' Serveur pour l'application Shiny Takuzu
#'
#' Cette fonction gère le serveur de l'application Takuzu, y compris la logique de génération et d'affichage de la grille, l'interaction avec l'utilisateur, la vérification de la grille, la gestion des indices et l'affichage du résultat.
#'
#' @param input,output,session Paramètres standards de Shiny. Ces objets sont utilisés pour réagir aux événements de l'utilisateur et mettre à jour l'interface.
#' 
#' @return Une application Shiny fonctionnelle.
#'
#' @import shiny
#' @import shinythemes
#' @importFrom shiny fluidPage titlePanel sidebarLayout sidebarPanel sliderInput mainPanel tabsetPanel tabPanel
#' @importFrom shiny reactive reactiveVal observe observeEvent renderText renderUI fluidRow actionButton updateActionButton
#' @importFrom shinythemes shinytheme
#' 
#' @source "generate_valid_row.R"
#' @source "rotate_vector.R"
#' @source "generate_valid_matrix.R"
#' @source "creer_matrice_takuzu.R"
#' @source "verifier_grille.R"
#' @source "ajuster_indices_takuzu.R"
#' @source "ui.R"
#' 
#' @export
server <- function(input, output, session) {
  
  size <- reactive({ input$gridSize })
  takuzu_grid <- reactiveVal()
  start_time <- reactiveVal(NULL)
  matrice_base <- reactiveVal()  
  resultat_affiche <- reactiveVal(FALSE)  
  
  # Initialisation de la grille
  observe({
    base_grid <- generate_valid_matrix(input$gridSize)
    matrice_base(base_grid)
    takuzu_grid(creer_matrice_takuzu(base_grid, difficulte = input$difficulty))
    start_time(Sys.time())
    resultat_affiche(FALSE)
  })
  
  # Affichage de la grille
  output$gridUI <- renderUI({
    grid <- takuzu_grid()
    current_size <- size()
    buttons <- lapply(1:current_size, function(i) {
      fluidRow(
        lapply(1:current_size, function(j) {
          actionButton(paste0("btn_", i, "_", j), 
                       label = ifelse(is.na(grid[i, j]), "", grid[i, j]), 
                       class = paste("takuzu-btn", 
                                     ifelse(grid[i, j] == 1, "takuzu-btn-1", 
                                            ifelse(grid[i, j] == 0, "takuzu-btn-0", ""))))
        })
      )
    })
    do.call(tagList, buttons)
  })
  
  # Interaction avec les boutons
  observe({
    current_size <- size()
    for (i in 1:current_size) {
      for (j in 1:current_size) {
        local({
          ii <- i; jj <- j
          btn_id <- paste0("btn_", ii, "_", jj)
          
          observeEvent(input[[btn_id]], {
            if (!resultat_affiche()) {
              grid <- takuzu_grid()
              current_value <- grid[ii, jj]
              new_value <- ifelse(is.na(current_value), 0, ifelse(current_value == 0, 1, NA))
              grid[ii, jj] <- new_value
              takuzu_grid(grid)
              updateActionButton(session, btn_id, label = ifelse(is.na(new_value), "", new_value))
            }
          }, ignoreNULL = FALSE)
        })
      }
    }
  })
  
  # Vérification de la grille
  observeEvent(input$check, {
    grid <- takuzu_grid()
    valid <- verifier_grille(grid, size())
    
    output$status <- renderText({
      if (valid) "✅ Grille Valide !" else "❌ Il y a des erreurs dans la grille."
    })
  })
  
  # Nouvelle grille
  observeEvent(input$reset, {
    if (!resultat_affiche()) {
      base_grid <- matrice_base()
      takuzu_grid(creer_matrice_takuzu(base_grid, difficulte = input$difficulty))
    }
  })
  
  # Indices
  observeEvent(input$hint, {
    if (!resultat_affiche()) {
      grid <- takuzu_grid()
      base_grid <- matrice_base()
      
      updated_grid <- ajuster_indices_takuzu(base_grid, grid)
      takuzu_grid(updated_grid)
      
      for (i in 1:nrow(updated_grid)) {
        for (j in 1:ncol(updated_grid)) {
          updateActionButton(session, paste0("btn_", i, "_", j), label = ifelse(is.na(updated_grid[i, j]), "", updated_grid[i, j]))
        }
      }
      
      # Afficher le message d'indication et le faire disparaître après 6 secondes
      output$hintMessage <- renderText("Voici un indice!")
      Sys.sleep(6)  # Attendre 6 secondes
      output$hintMessage <- renderText("")  # Effacer le message
    }
  })
  
  # Afficher le résultat après 3 minutes
  observeEvent(input$result, {
    if (is.null(start_time()) || difftime(Sys.time(), start_time(), units = "mins") >= 3) {
      resultat_affiche(TRUE)
      output$status <- renderText({ "⏱ Temps écoulé! Voici la solution:" })
      grid_solution <- matrice_base() 
      takuzu_grid(grid_solution)  # Affiche la solution
    }
    
    # Afficher le message de réflexion et le faire disparaître après 6 secondes
    output$thinkMessage <- renderText("Réfléchissez encore 30 secondes!")
    Sys.sleep(6)  # Attendre 6 secondes
    output$thinkMessage <- renderText("")  # Effacer le message
  })
}

