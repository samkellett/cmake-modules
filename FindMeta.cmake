# From: https://github.com/ericniebler/meta/blob/master/FindMeta.cmake
#
# Find the Meta include directory
# The following variables are set if Meta is found.
#  Meta_FOUND        - True when the Meta include directory is found.
#  Meta_INCLUDE_DIR  - The path to where the meta include files are.
# If Meta is not found, Meta_FOUND is set to false.

find_package(PkgConfig)

if(NOT EXISTS "${Meta_INCLUDE_DIR}")
  find_path(Meta_INCLUDE_DIR
    NAMES meta/meta.hpp
    DOC "Meta library header files"
    )
endif()

if(EXISTS "${Meta_INCLUDE_DIR}")
  mark_as_advanced(Meta_INCLUDE_DIR)
endif()

if(EXISTS "${Meta_INCLUDE_DIR}")
  set(Meta_FOUND 1)
else()
  set(Meta_FOUND 0)
endif()
