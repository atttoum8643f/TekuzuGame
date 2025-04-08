library(testthat)

if (requireNamespace("testthat", quietly = TRUE)) {

  test_that("Test de la fonction generate_valid_matrix", {
    taille <- 6
    mat <- generate_valid_matrix(taille)

    # 1. Vérifie les dimensions
    expect_equal(dim(mat), c(taille, taille))

    # 2. Vérifie que tous les éléments sont des 0 ou des 1
    expect_true(all(mat %in% c(0, 1)))

    # 3. Vérifie que chaque ligne est une rotation circulaire de la première
    premiere_ligne <- mat[1, ]

    for (i in 2:taille) {
      ligne_courante <- mat[i, ]
      est_rotation <- any(sapply(1:(taille - 1), function(shift) {
        all(ligne_courante == c(premiere_ligne[(taille - shift + 1):taille], premiere_ligne[1:(taille - shift)]))
      }))
      expect_true(est_rotation, info = paste("Ligne", i, "n'est pas une rotation de la première."))
    }
  })

} else {
  message("Le package 'testthat' n'est pas installé. Les tests ne seront pas exécutés.")
}
