# 🎲 ZeroOneR - Jeu Takuzu en R

Bienvenue dans **TakuzuGame**, une bibliothèque R accompagnée d'une application **Shiny interactive** dédiée au jeu **Takuzu (Binairo)** ! 🔢✨  

## 📌 Description du projet

Ce projet vise à :  
- Développer une **bibliothèque R** servant de base au jeu Takuzu.  
- Créer une **application Shiny** interactive pour jouer.  
- Héberger le projet sur **GitHub**.  

## 🎯 Présentation du jeu Takuzu (Binairo)

Le **Takuzu** est un jeu de **logique combinatoire**, similaire au **Sudoku**, qui se joue sur une **grille carrée** (généralement **6×6** ou **8×8**).  Pour plus d'informations, veuillez [cliquer ici](https://fr.wikipedia.org/wiki/Takuzu).


### 📝 Règles du jeu
- Chaque case doit contenir un **0** ou un **1**.
- Chaque ligne et colonne doivent avoir **autant de 0 que de 1**.
- **Trois 0 ou trois 1 consécutifs** sont interdits.
- **Deux lignes ou colonnes identiques** sont interdites.

### 🧠 Stratégies pour résoudre un Takuzu
- **Éviter les triples** : Si deux **0** ou deux **1** se suivent, la case suivante doit contenir l’autre chiffre.
- **Équilibrer les chiffres** : Chaque ligne et colonne doivent contenir **autant de 0 que de 1**.
- **Comparer les lignes et colonnes** pour éviter les doublons.

Le **Takuzu** est facile à apprendre mais devient **de plus en plus complexe** avec la taille de la grille. Nous nous concentrerons ici sur des **grilles de taille 8×8**.

## 🚀 Installation et Utilisation

### 🔧 Installation

Vous pouvez cloner le dépôt complet avec la commande ci-dessous :
```{r}
# Cloner le dépôt
system("git clone https://github.com/atttoum8643f/TekuzuGame.git")
```

Si vous préférez installer uniquement l'application du jeu Takuzu (ZeroOneR), utilisez la commande suivante :
```{r}
# Installer l'application ZeroOneR depuis GitHub
devtools::install_github("atttoum8643f/TekuzuGame/ZeroOneR")

```
### Charger la bibliothèque R :

```{r}
library(ZeroOneR)
```
### Lancer l’application Shiny :

```{r}
shiny::runApp("app.R")
```

## 📌 Technologies utilisées
   - R (Langage principal)
   - Shiny (Framework pour applications web interactives en R)
   - GitHub (Versioning & Collaboration)

## 📄 Licence
Ce projet est sous licence MIT – Voir le fichier LICENSE pour plus de détails.
