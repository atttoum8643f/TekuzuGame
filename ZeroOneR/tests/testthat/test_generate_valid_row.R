library(testthat)

if (requireNamespace("testthat", quietly = TRUE)) {

  test_that("Test de la fonction generate_valid_row", {
    taille <- 8
    ligne <- generate_valid_row(taille)

    # 1. Vérifie la taille
    expect_equal(length(ligne), taille)

    # 2. Vérifie que les éléments sont uniquement des 0 ou 1
    expect_true(all(ligne %in% c(0, 1)))

    # 3. Vérifie l'absence de trois chiffres identiques consécutifs
    for (i in 1:(taille - 2)) {
      triplet <- ligne[i:(i + 2)]
      expect_false(all(triplet == 0) || all(triplet == 1),
                   info = paste("Triplet identique détecté :", paste(triplet, collapse = "")))
    }
  })

} else {
  message("Le package 'testthat' n'est pas installé. Les tests ne seront pas exécutés.")
}
