cmake_minimum_required(VERSION 2.8)

set(PROJECT_NAME Json2DealiiProject)
set(PROJECT_LIB_NAME Json2DealiiLib)

project(${PROJECT_NAME})

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "-g -Wall")

include_directories(${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/ext/dealii/include)
include_directories(${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/ext/dealii/bundled/boost-1.70.0/include)
include_directories(${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/ext/dealii/bundled/tbb-2018_U2/include)
include_directories(${PROJECT_NAME} ${CMAKE_SOURCE_DIR}/include)

file(GLOB SRC_FILES ${CMAKE_SOURCE_DIR}/src/*.cpp)
file(GLOB TEST_SRC_FILES ${CMAKE_SOURCE_DIR}/test/*.cpp)

find_library(DEALII_LIBRARY deal_II HINTS ${CMAKE_SOURCE_DIR}/ext/dealii/lib)
if(NOT DEALII_LIBRARY)
  message(FATAL_ERROR "deal.II lib not found!")
endif()

add_library(${PROJECT_LIB_NAME} ${SRC_FILES})
add_executable(Json2Dealii Json2Dealii.cpp)


target_link_libraries(${PROJECT_LIB_NAME} PUBLIC ${DEALII_LIBRARY})
target_link_libraries(Json2Dealii ${PROJECT_LIB_NAME})

# From the command line one can specify "cmake -DBUILD_TESTS=ON"
# to build the tests.
option(BUILD_TESTS "Build all tests." OFF)

if(BUILD_TESTS)
  add_subdirectory(ext/googletest)
  enable_testing()
  # Include the gtest library. gtest_SOURCE_DIR is available due to
  # 'project(gtest)' above.
  include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})

  add_executable(runUnitTests ${TEST_SRC_FILES})
  target_link_libraries(runUnitTests gtest gtest_main)
  target_link_libraries(runUnitTests ${PROJECT_LIB_NAME})

  # This is so you can do 'make test' to see all your tests run, instead of
  # manually running the executable runUnitTests to see those specific tests.
  add_test(UnitTests runUnitTests)
endif()
