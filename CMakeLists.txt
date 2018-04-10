cmake_minimum_required(VERSION 3.5)
set(CMAKE_CXX_STANDARD 11)

# Supposed to make it multi-platform - works fine without it in Ubuntu.
include(GNUInstallDirs)

# Directory in which to place our targets: runUnittests, libFactorialLib.so, myfactorial.so
set(TARGET_DIR ${CMAKE_SOURCE_DIR}/build)
#
# I wish we could force an "out-of-source" build from here in CMake, but we cannot, we need to use a
# script (compile.sh) to cd to a build directory and make from there.   :-(
# TODO fix it

project(myFirstClion)
set(MY_LIB FactorialLib)
# python module name - note: same as used in PyModule.cpp
set(MY_PY_MODULE myfactorial)

add_subdirectory(src/main)
add_subdirectory(src/test)
