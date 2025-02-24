#include <Rcpp.h>
#include "generate_valid_row.cpp"
#include "rotate_vector.cpp"

using namespace Rcpp;

// [[Rcpp::export]]
IntegerMatrix generate_valid_matrix(int taille) {
  int q = taille - 1;
  std::vector<int> x = generate_valid_row(taille);
  IntegerMatrix init_mat(taille, taille);  // Utilisation de IntegerMatrix au lieu de std::vector
  
  // Remplissage de la première colonne
  for (int i = 0; i < taille; i++) {
    init_mat(i, 0) = x[i];
  }
  
  // Génération des colonnes suivantes
  for (int i = 1; i <= q; i++) {
    std::vector<int> rotated_x = rotate_vector(x, i);
    for (int j = 0; j < taille; j++) {
      init_mat(j, i) = rotated_x[j];
    }
  }
  
  return init_mat;
}
