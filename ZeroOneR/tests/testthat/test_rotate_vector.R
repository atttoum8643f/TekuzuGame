library(testthat)

if (requireNamespace("testthat", quietly = TRUE)) {

  test_that("Test de la fonction rotate_vector", {
    vecteur <- c(1, 2, 3, 4, 5)
    resultat <- rotate_vector(vecteur, 2)
    attendu <- c(4, 5, 1, 2, 3)

    expect_equal(resultat, attendu)
  })

} else {
  message("Le package 'testthat' n'est pas installé. Les tests ne seront pas exécutés.")
}
