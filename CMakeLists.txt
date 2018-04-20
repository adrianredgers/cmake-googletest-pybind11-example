cmake_minimum_required(VERSION 3.5)
set(CMAKE_CXX_STANDARD 11)
# This is supposed to make everything multi-platform - but all works ok without it in Ubuntu.
include(GNUInstallDirs)


project(cmake-googletest-pybind11-example)

# Our Python module name - NOTE: same as used in PyModule.cpp and in Python import statement.
set(MY_PY_MODULE myfactorial)
# Our shared library used by our Python module and unit tests.
set(MY_LIB FactorialLib)
# Directory to copy our Python module and shared library so they are available for Python import.
set(PYTHON_DIST_DIR ~)


# Directory in which to place our targets: myUnittests, libFactorialLib.so, myfactorial.so
set(TARGET_DIR ${CMAKE_SOURCE_DIR}/build)
# Set all target dirs globally, or you can do them individually with set_target_properties()
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${TARGET_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${TARGET_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${TARGET_DIR})

#
# I wish we could force an "out-of-source" build from here in CMake, but we cannot, we need to use a
# script (compile.sh) to cd to a build directory and make from there.   :-(
# TODO fix it
#

add_subdirectory(src/main)
add_subdirectory(src/test)


