cmake_minimum_required(VERSION 3.5)
set(CMAKE_CXX_STANDARD 11)

# Directory in which to place our targets: runUnittests, libFactorialLib.so, myfactorial.so
set(TARGET_DIR ${CMAKE_SOURCE_DIR}/build)
#
# I wish we could force and "out-of-source" build from here in CMake, but we cannot, we need a script (compile.sh)   :-(
#
# Also need to set up an out-of-source build in CLion, else it can create artifacts within the source tree:
# Menu: File>Settings>Build,Execution,Deployment>CMake
# set "Generation path" to the directory name "build" (no quotes)
#

project(myFirstClion)
set(MY_LIB FactorialLib)
# python module name - note: same as used in PyModule.cpp
set(MY_PY_MODULE myfactorial)

add_subdirectory(src/main)
add_subdirectory(src/test)
