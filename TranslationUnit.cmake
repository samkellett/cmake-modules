# translation_unit is a macro to greatly assist the organisation of your project file.
# It's only required argument is FILE which is the path to the cpp file that this
# translation unit is built from. The path is relative to the location of the CMakeLists.txt
# file that calls this macro.

# The file that is passed in will be added to the project's SOURCE's list and that can be
# passed into an add_library or add_executable method.

# Other parameters are currently no-op's.

# An example of how to use this macro is like so:
# project(example)
# translation_unit(
#   FILE
#     galaxy.cpp
# 
#   TEST test/test_galaxy.cpp
#   TEST_LIBRARIES
#     gtest_main
# )
# # The variable 'example_SOURCES' now contains "path/to/dir/galaxy.cpp"

include(CMakeParseArguments)

macro(translation_unit)
  cmake_parse_arguments(
    TRANSLATION_UNIT
    "" # Nullary arguments (flags).
    "FILE;TEST" # Unary arguments.
    "DEPENDS;TEST_DEPENDS;TEST_LIBRARIES;TEST_INCLUDE_DIRS" # n-ary arguments.
    ${ARGN}
  )

  # Add this FILE to the xxx_SOURCES list.
  list(APPEND ${PROJECT_NAME}_SOURCES "${CMAKE_CURRENT_LIST_DIR}/${TRANSLATION_UNIT_FILE}")

  # Update the xxx_SOURCES variable in the PARENT_SCOPE.
  set(${PROJECT_NAME}_SOURCES "${${PROJECT_NAME}_SOURCES}" PARENT_SCOPE)

  # Unset all our variables as this is a macro and not a function.
  unset(TRANSLATION_UNIT_FILE)
  unset(TRANSLATION_UNIT_DEPENDS)

  unset(TRANSLATION_UNIT_TEST)
  unset(TRANSLATION_UNIT_TEST_DEPENDS)
  unset(TRANSLATION_UNIT_TEST_LIBARIES)
  unset(TRANSLATION_UNIT_TEST_INCLUDE_DIRS)

  unset(TRANSLATION_UNIT_UNPARSED_ARGUMENTS)
endmacro()

