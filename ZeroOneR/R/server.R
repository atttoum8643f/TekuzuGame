#' Serveur pour l'application Shiny Takuzu
#'
#' Cette fonction gere le serveur de l'application Takuzu, y compris la logique de generation et d'affichage de la grille, l'interaction avec l'utilisateur, la verification de la grille, la gestion des indices et l'affichage du resultat.
#'
#' @param input, output, session Parametres standards de Shiny. Ces objets sont utilises pour reagir aux evenements de l'utilisateur et mettre a jour l'interface.
#' @param output L'objet output pour l'affichage dans l'UI.
#' @param session L'objet session pour la gestion de l'etat de l'application.
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

  # Verification de la grille
  observeEvent(input$check, {
    grid <- takuzu_grid()
    valid <- verifier_grille(grid, size())

    output$status <- renderText({
      if (valid) "\u2705 Grille Valide !" else "\u274C Il y a des erreurs dans la grille."
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

      # Afficher le message d'indication et le faire disparaitre apres 6 secondes
      output$hintMessage <- renderText("Voici un indice!")
      Sys.sleep(6)  # Attendre 6 secondes
      output$hintMessage <- renderText("")  # Effacer le message
    }
  })

  # Afficher le resultat une fois le boutton appuyer
  observeEvent(input$result, {
    if (is.null(start_time()) || difftime(Sys.time(), start_time(), units = "mins") >= 0) {
      resultat_affiche(TRUE)
      output$status <- renderText({ "\u23F1  Voici la solution:" })
      grid_solution <- matrice_base()
      takuzu_grid(grid_solution)  # Affiche la solution
    }

    # Afficher le message de reflexion et le faire disparaitre apres 6 secondes
    output$thinkMessage <- renderText("Reflechissez encore 30 secondes!")
    Sys.sleep(6)  # Attendre 6 secondes
    output$thinkMessage <- renderText("")  # Effacer le message
  })
}
