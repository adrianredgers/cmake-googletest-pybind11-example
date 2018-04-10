#!/usr/bin/env bash

#
# Create build dir and make the targets
#
BUILD_DIR=build
mkdir -p $BUILD_DIR
pushd $BUILD_DIR
cmake ..
make
popd

#
# Now you can run python and import the module and use its functions,
#  e.g. create and copy across libmyfactorial.so
# then run python:
# $ python
# >>> import myfactorial
# >>> myfactorial.fact(5)
# 120.0
#

#
# If an in-source build happens then you will want to delete the build artifacts now sprinkled thoughut the source tree.
# These are files created in the last 10 minutes:-
# find . -name "*" -mmin -10
#
# Which equates to these files you want to delete, for this project at least:
#  rm -r src/main/CMakeFiles/ src/main/Makefile src/main/cmake_install.cmake src/test/CMakeFiles/  src/test/Makefile src/test/cmake_install.cmake src/test/lib/googletest/CMakeFiles/ src/test/lib/googletest/CTestTestfile.cmake src/test/lib/googletest/Makefile src/test/lib/googletest/cmake_install.cmake src/test/lib/googletest/googlemock/CMakeFiles/ src/test/lib/googletest/googlemock/CTestTestfile.cmake  src/test/lib/googletest/googlemock/Makefile src/test/lib/googletest/googlemock/cmake_install.cmake  src/test/lib/googletest/googlemock/gtest/ *.pc Makefile CMakeFiles cmake_install.cmake CMakeCache.txt ./src/main/lib/pybind11/cmake_install.cmake src/test/lib/googletest/googlemock/libgmock.a 	src/test/lib/googletest/googlemock/libgmock_main.a
#


