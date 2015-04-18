# Append compiler flags, intially based on:
#  From: https://github.com/lubosz/liblub/blob/master/CMakeLists.txt

# Usage:
#   add_compiler_flag(CXX
#     ALL
#       -std=c++11
#       -Wall
#       -Werror
#     CLANG
#       -stdlib=libc++
#   )

include(CMakeParseArguments)

function(add_compiler_flag FLAG)
  cmake_parse_arguments(
    COMPILER_FLAG
    "" # Nullary arguments (flags).
    "" # Unary arguments.
    "CLANG;GCC;INTEL;MSVC;ALL" # n-ary arguments.
    ${ARGN}
  )

  if("${FLAG}" STREQUAL "CXX")
    set(LANG CXX)
  elseif("${FLAG}" STREQUAL "C")
    set(LANG C)
  else()
    message(FATAL_ERROR "Unknown language: ${FLAG}")
  endif()

  set(CMAKE_${LANG}_FLAGS "${CMAKE_${LANG}_FLAGS} ${COMPILER_FLAG_ALL}")

  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    # using Clang
    set(CMAKE_${LANG}_FLAGS "${CMAKE_${LANG}_FLAGS} ${COMPILER_FLAG_CLANG}")
  elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    # using GCC
    message("HELLO")
    set(CMAKE_${LANG}_FLAGS "${CMAKE_${LANG}_FLAGS} ${COMPILER_FLAG_GCC}")
  elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
    # using Intel C++
    set(CMAKE_${LANG}_FLAGS "${CMAKE_${LANG}_FLAGS} ${COMPILER_FLAG_INTEL}")
  elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    # using Visual Studio C++
    set(CMAKE_${LANG}_FLAGS "${CMAKE_${LANG}_FLAGS} ${COMPILER_FLAG_MSVC}")
  endif()

  # Make our flags a space separated list.
  string(REPLACE ";" " " CMAKE_${LANG}_FLAGS "${CMAKE_${LANG}_FLAGS}")

  # Propagate new compiler flags out of function scope.
  set(CMAKE_${LANG}_FLAGS "${CMAKE_${LANG}_FLAGS}" PARENT_SCOPE)
endfunction()
