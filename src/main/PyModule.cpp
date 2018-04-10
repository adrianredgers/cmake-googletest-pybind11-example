
#include <pybind11/pybind11.h>
#include <FactorialLib.h>


namespace py = pybind11;

int add(int a, int b) {
    return a + b;
}

PYBIND11_MODULE(myfactorial, m) {
    m.def("add", &add, "add stuff");
    m.def("fact", &factorial, "calc factorial");
}

