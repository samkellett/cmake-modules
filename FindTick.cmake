# Find the Tick include directory
# The following variables are set if Tick is found.
#  Tick_FOUND        - True when the Tick include directory is found.
#  Tick_INCLUDE_DIR  - The path to where the Tick include files are.
# If Tick is not found, Tick_FOUND is set to false.

find_package(PkgConfig)

if(NOT EXISTS "${Tick_INCLUDE_DIR}")
  find_path(Tick_INCLUDE_DIR
    NAMES tick/traits.h
    DOC "Tick library header files"
    )
endif()

if(EXISTS "${Tick_INCLUDE_DIR}")
  mark_as_advanced(Tick_INCLUDE_DIR)
endif()

if(EXISTS "${Tick_INCLUDE_DIR}")
  set(Tick_FOUND 1)
else()
  set(Tick_FOUND 0)
endif()
