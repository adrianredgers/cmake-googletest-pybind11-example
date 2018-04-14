

include_directories(${CMAKE_SOURCE_DIR}/src/main ${CMAKE_SOURCE_DIR}/src/include)

# Initialize global ${MY_SOURCES}
set(MY_SOURCES "" CACHE INTERNAL "")

# Add new source directories here, each one should have a CMakeLists.txt
add_subdirectory(numeric)


# Python system dirs
set(PYTHON_INCLUDE_DIR /usr/include/python2.7)
set(PYTHON_DIST_DIR /usr/local/lib/python2.7/dist-packages)

# Create the C++ lib (not the Python module), which is used by the tests
add_library(${MY_LIB} SHARED ${MY_SOURCES})
set_target_properties(${MY_LIB}
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY ${TARGET_DIR}
        LIBRARY_OUTPUT_DIRECTORY ${TARGET_DIR}
        RUNTIME_OUTPUT_DIRECTORY ${TARGET_DIR})
set(TT $<TARGET_FILE:${MY_LIB}> )
add_custom_command(TARGET ${MY_LIB}  POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${MY_LIB}>  ${PYTHON_DIST_DIR})

# Link some-other-lib into the new $MY_LIB
#   (do it now instead of adding link later whenever we use $MY_LIB)
# target_link_libraries($MY_LIB some-other-library)

# Build the pybind11 library from source you have previously cloned into src/main/lib/
set(PYBIND11 lib/pybind11)
include_directories(${PYTHON_INCLUDE_DIR} ${PYBIND11}/include)
# Ghastly hack to prevent this pybind11 build from using python 3.5 :-(
set(PYBIND11_PYTHON_VERSION 2.7 CACHE STRING "")
add_subdirectory(${PYBIND11})

# Create our python module - note: module name, set up in prev CMakeLists, is same as in PyModule.cpp
# TODO - Don't recompile ${MY_SOURCES}
pybind11_add_module(${MY_PY_MODULE} PyModule.cpp)
# pybind11_add_module(${MY_PY_MODULE} PyModule.cpp ${MY_SOURCES})
# Link ${MY_LIB} into new module - note the PRIVATE keyword
target_link_libraries(${MY_PY_MODULE} PRIVATE ${PYTHON_DIST_DIR}/lib${MY_LIB}.so)

# Place the targets in ${TARGET_DIR}
# Or you can set CMAKE_xxx_OUTPUT_DIRECTORY properties globally in the top level CMakeLists.txt
#  e.g.: set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${TARGET_DIR})

set_target_properties(${MY_PY_MODULE}
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY ${TARGET_DIR}
        LIBRARY_OUTPUT_DIRECTORY ${TARGET_DIR}
        RUNTIME_OUTPUT_DIRECTORY ${TARGET_DIR})


# Copy the Python module to the Python distribution dir - you must have permissions to copy to this dir.
add_custom_command(TARGET ${MY_PY_MODULE}  POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${MY_PY_MODULE}> ${PYTHON_DIST_DIR})


