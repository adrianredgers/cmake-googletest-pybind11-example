
set(TEST_SOURCES
        FactorialTest.cpp)

# For <${MY_LIB}.h> used by tests
include_directories(${CMAKE_SOURCE_DIR}/src/include)

# Build the googletest library from source you have previously cloned into src/test/lib/
set(GTEST_ROOT lib/googletest)
add_subdirectory(${GTEST_ROOT})
# For <gtest/gtest.h>
include_directories(${GTEST_ROOT}/googletest/include)
# Name of the Googletest lib we need
set(GTEST_LIB gtest_main)

# Create new runUnitTests target from test sources and link with ${GTEST}_LIB and ${MY_LIB}
add_executable(runUnitTests ${TEST_SOURCES})
target_link_libraries(runUnitTests ${GTEST_LIB} ${MY_LIB})

# Place the runUnitTests target executable in ${TARGET_DIR}
# Or you can set CMAKE_xxx_OUTPUT_DIRECTORY properties globally in the top level CMakeLists.txt
#  e.g.: set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${TARGET_DIR})
set_target_properties(runUnitTests
        PROPERTIES
        ARCHIVE_OUTPUT_DIRECTORY ${TARGET_DIR}
        LIBRARY_OUTPUT_DIRECTORY ${TARGET_DIR}
        RUNTIME_OUTPUT_DIRECTORY ${TARGET_DIR})


