#include <Rcpp.h>
#include <vector>
#include <random>

// [[Rcpp::export]]
std::vector<int> generate_valid_row(int taille) {
  if (taille <= 0) return {};  // Vérification pour éviter une taille invalide
  
  std::vector<int> vec(taille, 0);
  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_int_distribution<> dis(0, 1);
  
  int i = 1;
  int j = 0;
  
  while (i < taille) {
    j++;
    if (j == 2) {  
      int t = vec[i - 1] + vec[i];  // Somme des éléments
      j = 0;
      
      if (t == 0) {
        vec[i] = 1;
      } else if (t == 2) {
        vec[i] = 0;
      }
    } else {
      vec[i] = dis(gen);  // Tirage aléatoire entre 0 et 1
    }
    i++;
  }
  
  return vec;
}
