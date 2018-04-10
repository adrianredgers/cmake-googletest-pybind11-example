
# Set sources and create ${MY_LIB} as a SHARED lib from them
set(SOURCES Factorial.cpp Factorial.h)
# Creates it as: build/src/main/lib${MY_LIB}.so
add_library(${MY_LIB} SHARED ${SOURCES})

# Link some-other-lib into the new $MY_LIB
#   (do it now instead of adding link later whenever we use $MY_LIB)
# target_link_libraries($MY_LIB some-other-library)

# Python system dirs
set(PYTHON_INCLUDE_DIR /usr/include/python2.7)
set(PYTHON_DIST_DIR /usr/local/lib/python2.7/dist-packages)

# Build the pybind11 library
# For <Python.h> used by pybind11
include_directories(${PYTHON_INCLUDE_DIR})
# Build the pybind11 library from source you have previously cloned into src/main/lib/
set(PYBIND11 lib/pybind11)
include_directories(${PYBIND11}/include)
# Ghastly hack to prevent this pybind11 build from using python 3.5 :-(
set(PYBIND11_PYTHON_VERSION 2.7 CACHE STRING "")
add_subdirectory(${PYBIND11})

# Create pybind11 module - note: module name, set up in prev CMakeLists, is same as in PyModule.cpp
# For <${MY_LIB}.h> used by PyModule.cpp
include_directories(${CMAKE_SOURCE_DIR}/src/include)
pybind11_add_module(${MY_PY_MODULE} PyModule.cpp)
# Link ${MY_LIB} into new module - note the PRIVATE keyword
target_link_libraries(${MY_PY_MODULE} PRIVATE ${MY_LIB})

# Place the targets in ${TARGET_DIR}
# Or you can set CMAKE_xxx_OUTPUT_DIRECTORY properties globally in the top level CMakeLists.txt
#  e.g.: set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${TARGET_DIR})
set_target_properties(${MY_LIB} ${MY_PY_MODULE}
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY ${TARGET_DIR}
        LIBRARY_OUTPUT_DIRECTORY ${TARGET_DIR}
        RUNTIME_OUTPUT_DIRECTORY ${TARGET_DIR})

# Copy the Python module to the Python distribution dir - you must have permissions to copy to this dir.
add_custom_command(TARGET ${MY_PY_MODULE} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${MY_PY_MODULE}> ${PYTHON_DIST_DIR})



