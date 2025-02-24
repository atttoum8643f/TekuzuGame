#include <Rcpp.h>
#include <vector>

// [[Rcpp::export]]
std::vector<int> rotate_vector(std::vector<int> x, int shift) {
  int n = x.size();
  shift = shift % n;  // S'assurer que le décalage reste dans les limites du vecteur
  
  // Construire le vecteur retourné
  std::vector<int> rotated(n);
  
  // Effectuer la rotation
  for (int i = 0; i < n; i++) {
    rotated[i] = x[(i + n - shift) % n];
  }
  
  return rotated;
}
