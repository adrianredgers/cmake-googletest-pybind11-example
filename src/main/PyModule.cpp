
#include <pybind11/stl.h>
#include <FactorialLib.h>


using namespace std;
using namespace myfactorial;

namespace py = pybind11;

int add(int a, int b) {
    return a + b;
}

double maxi(const std::vector<double> &v, double w) {
    double maxVal = w;

    for (double f:v) {
        if (f > maxVal) {
            maxVal = f;
        }
    }
    return maxVal;
}


PYBIND11_MODULE(myfactorial, m) {
    m.def("add", &add, "add stuff");
    m.def("max", &maxi, "max", py::arg("list"), py::arg("initMax"));
    m.def("fact", &factorial, "calc factorial of n", py::arg("n"));
}

