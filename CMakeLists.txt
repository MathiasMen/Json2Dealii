cmake_minimum_required(VERSION 3.0)

project(Json2Dealii)

find_library(DEALII_LIBRARY deal_II HINTS ${CMAKE_SOURCE_DIR}/dealii/lib)

if(NOT DEALII_LIBRARY)
  message(FATAL_ERROR "deal.II lib not found!")
endif()
  
include_directories(Json2Dealii ${CMAKE_SOURCE_DIR}/dealii/include)
include_directories(Json2Dealii ${CMAKE_SOURCE_DIR}/dealii/bundled/boost-1.70.0/include)
include_directories(Json2Dealii ${CMAKE_SOURCE_DIR}/dealii/bundled/tbb-2018_U2/include)

add_executable(Json2Dealii Json2Dealii.cpp)

target_link_libraries(Json2Dealii PUBLIC ${DEALII_LIBRARY})