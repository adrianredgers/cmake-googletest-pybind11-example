
#include <pybind11/stl.h>
#include <FactorialLib.h>


using namespace std;
using namespace myfactorial;

namespace py = pybind11;

int add(int a, int b) {
    return a + b;
}

void hello(string a) {
    cout << "Hello " << a << endl;
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
    m.def("hello", (void (*)(string)) &hello, "Hello XX", py::arg("str"));
    m.def("add", (int (*)(int, int)) &add, "add stuff", py::arg("aa"), py::arg("bb"));
    m.def("max", (double (*)(vector<double> &, double)) &maxi, "max", py::arg("list"), py::arg("initMax"));
    m.def("fact", (double (*)(int)) &factorial, "calc factorial of n", py::arg("n"));
}




