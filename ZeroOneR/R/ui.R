#' UI de l'application Takuzu
#'
#' Cette interface utilisateur (UI) est utilisée pour afficher et interagir avec le jeu Takuzu, une variante du Binairo. 
#' L'application est construite avec Shiny et permet aux utilisateurs de jouer au jeu Takuzu sur une grille de taille variable. 
#' Les utilisateurs peuvent choisir la difficulté du jeu et jouer avec une grille générée aléatoirement.
#'
#' @import shiny
#' @import shinythemes
#' @import gtools
#' @import Rcpp
#'
#' @return Un objet `shiny::fluidPage` représentant l'interface utilisateur du jeu Takuzu.
#' 
#' @examples
#' # Lancer l'UI du jeu
#' ui
#'
#' @export
library(shiny)
library(shinythemes)
library(gtools)
library(Rcpp)

# UI de l'application Takuzu
ui <- fluidPage(
  theme = shinytheme("superhero"),
  tags$head(
    tags$style(HTML("
      /* Conteneur principal centré pour grille + boutons */
      .grid-and-buttons {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        margin-top: 20px;
      }

      /* Capsule rouge autour de la grille */
      .red-capsule {
        border: 5px solid red;
        background-color: #FFCDD2;  /* Rouge clair */
        padding: 20px;
        display: inline-block;
        border-radius: 20px;  /* Coins arrondis */
        box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.3);
        margin-bottom: 10px;
      }

      /* Capsule externe autour de la grille et des boutons */
      .outer-capsule-container {
        border: 5px solid #FFD700;  /* Jaune */
        background-color: #F5F5DC;
        padding: 30px;
        display: inline-block;
        border-radius: 30px;
        box-shadow: 0px 12px 20px rgba(0, 0, 0, 0.3);
        margin-bottom: 20px;
      }

      /* Capsule jaune avec effet 3D sans perspective */
      .outer-capsule-container {
        border: 5px solid #FFD700;
        background-color: #F5F5DC;
        padding: 30px;
        display: inline-block;
        border-radius: 30px;
        box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.4);  /* Ombre plus marquée */
        transform: translateY(5px);  /* Simule l'élévation de la capsule */
        transition: all 0.3s ease;
      }

      .outer-capsule-container:hover {
        box-shadow: 0px 15px 30px rgba(0, 0, 0, 0.5);  /* Ombre plus marquée au survol */
        transform: translateY(10px);  /* Effet d'élévation encore plus accentué */
      }

      /* Conteneur de la grille */
      .grid-container {
        margin-bottom: 20px;
      }

      /* Conteneur des boutons */
      .button-container {
        display: flex;
        justify-content: center;
        gap: 15px;
        padding: 10px;
        background-color: #546E7A;
        border-radius: 10px;
        box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
      }

      /* Style des boutons Takuzu */
      .takuzu-btn { 
        background-color: #37474F;
        border-radius: 50%; 
        border: 1px solid white; 
        width: 50px; 
        height: 50px; 
        color: white; 
        font-size: 20px; 
        text-align: center; 
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); 
        transition: all 0.2s ease-in-out;
      }
      .takuzu-btn-1 { background-color: #FFA500; }  /* Orange pour 1 */
      .takuzu-btn-0 { background-color: #4CAF50; }  /* Vert pour 0 */
      .takuzu-btn:hover { 
        background-color: #FFA000;
        box-shadow: 0px 6px 10px rgba(0, 0, 0, 0.2);
        transform: translateY(-3px); 
      }

      /* Boutons d'action */
      .new-grid-btn, .check-grid-btn, .hint-btn {
        background-color: #0288D1;
        border-color: #01579B;
        color: white;
        font-size: 16px;
        padding: 10px 20px;
        border-radius: 10px;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
        transition: all 0.2s ease-in-out;
      }

      .new-grid-btn:hover { background-color: #01579B; transform: translateY(-3px); }
      .check-grid-btn:hover { background-color: #C62828; transform: translateY(-3px); }
      .hint-btn:hover { background-color: #FFD700; transform: translateY(-3px); color: black; }

      /* Animation du message de statut clignotant */
      .status-message {
        font-weight: bold;
        font-size: 18px;
        text-align: center;
        color: white;
        animation: pulse 1.5s infinite;
      }
      @keyframes pulse {
        0% { color: white; }
        50% { color: #FFD700; }
        100% { color: white; }
      }

      /* Message de Réfléchissez encore 30 secondes */
      .think-message {
        color: red;
        font-size: 24px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 20px;
      }

      /* Style des émojis dans la capsule à fond blanc */
      .emoji-container {
        font-size: 30px;
        text-align: center;
        margin-bottom: 20px;
      }
    "))
  ),
  titlePanel("Jeu Takuzu"),
  tabsetPanel(
    tabPanel("Jeu",
             sidebarLayout(
               sidebarPanel(
                 sliderInput("gridSize", "Taille de la grille :", 
                             min = 8, max = 12, value = 8, step = 2,
                             animate = TRUE),
                 selectInput("difficulty", "Choisir la difficulté :", 
                             choices = c("Facile" = "facile", 
                                         "Avancée" = "avancee", 
                                         "Difficile" = "difficile"), 
                             selected = "facile"),
                 verbatimTextOutput("status")
               ),
               mainPanel(
                 div(class = "outer-capsule-container",  # Capsule externe autour de grille et boutons
                     div(class = "grid-and-buttons",
                         div(class = "think-message", textOutput("thinkMessage")),  
                         
                         # Capsule à fond blanc contenant les emojis
                         div(class = "emoji-container", "😊 😀 😁"),  # Émojis jaunes
                         
                         div(class = "red-capsule",  
                             div(class = "grid-container", uiOutput("gridUI"))
                         ),
                         
                         div(class = "button-container",
                             actionButton("reset", "Nouvelle Grille", class = "new-grid-btn"),
                             actionButton("check", "Vérifier la Grille", class = "check-grid-btn"),
                             actionButton("hint", "Obtenir un Indice", class = "hint-btn"),
                             actionButton("result", "Résultat", class = "new-grid-btn")  
                         )
                     )
                 )
               )
             )
    ),
    tabPanel("Règles du Jeu",
             h3("Règles du Jeu Takuzu"),
             p("Le but du jeu Takuzu est de remplir la grille avec des 0 et des 1 de manière à respecter les règles suivantes :"),
             tags$ul(
               tags$li("Chaque ligne et chaque colonne doit contenir un nombre égal de 0 et de 1."),
               tags$li("Aucune ligne ni colonne ne peut contenir plus de deux 0 ou plus de deux 1 consécutifs."),
               tags$li("La grille ne doit pas contenir deux lignes ou deux colonnes identiques.")
             )
    )
  )
)
