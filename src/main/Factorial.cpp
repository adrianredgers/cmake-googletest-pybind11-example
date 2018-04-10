
#include "Factorial.h"

double factorial(int n, double acc);

double factorial(int n) {
    return factorial(n, 1.0);
}

double factorial(int n, double acc) {
    if (n <= 1) {
        return acc;
    } else {
        return factorial(n - 1, n * acc);
    }
}


