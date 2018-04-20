
# Pick up C++ library interface #include <FactorialLib.h>
include_directories(${CMAKE_SOURCE_DIR}/src/include)

# Initialize global ${MY_SOURCES}, CMakeLists in each subdirectory will append its sources.
# If it gets too big you'll need to create mini-libraries instead and add them using target_link_libraries()
set(MY_SOURCES "" CACHE INTERNAL "dummy comment")

# NOTE: Add new source directories here, each one should have a CMakeLists.txt
add_subdirectory(numeric)

# Create our C++ shared lib, which is used by the tests and our Python module
add_library(${MY_LIB} SHARED ${MY_SOURCES})

# Create our python module
# Build the pybind11 library from source you have previously cloned into src/main/lib/
set(PYBIND11 lib/pybind11)
set(PYTHON_INCLUDE_DIR /usr/include/python2.7)
include_directories(${PYTHON_INCLUDE_DIR} ${PYBIND11}/include)
# Ghastly hack to prevent this pybind11 build from using python 3.5 :-(
set(PYBIND11_PYTHON_VERSION 2.7 CACHE STRING "")
add_subdirectory(${PYBIND11})

# Special pybind11 CMake sauce-ry
pybind11_add_module(${MY_PY_MODULE} PyModule.cpp)
# Link ${MY_LIB} into our Python module - note the PRIVATE keyword
target_link_libraries(${MY_PY_MODULE} PRIVATE ${MY_LIB})

# Copy our Python module to ${PYTHON_DIST_DIR}, which must be in unix env $PYTHONPATH
add_custom_command(TARGET ${MY_PY_MODULE} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${MY_PY_MODULE}> ${PYTHON_DIST_DIR})

# Also copy our C++ shared lib to ${PYTHON_DIST_DIR}, which must be in unix env $LD_LIBRARY_PATH
add_custom_command(TARGET ${MY_LIB}  POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${MY_LIB}>  ${PYTHON_DIST_DIR})

