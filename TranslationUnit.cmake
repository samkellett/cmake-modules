# translation_unit is a macro to greatly assist the organisation of your project file.
# It's only required argument is FILE which is the path to the cpp file that this
# translation unit is built from. The path is relative to the location of the CMakeLists.txt
# file that calls this macro.

# The file that is passed in will be added to the project's SOURCE's list and that can be
# passed into an add_library or add_executable method.

# If the TEST parameter is set then the file added it used to create a unit test
# that shares the name of the file. TEST_DEPENDS can be set to list files that
# only the unit test depends on and TEST_LIBRARIES libraries to link against.
# The test is automatically added to the CTest suite of tests.

# # An example of how to use this macro is like so:
# project(example)
# translation_unit(
#   FILE
#     galaxy.cpp
# 
#   TEST test/test_galaxy.cpp
#   TEST_DEPENDS
#     test/galaxy_utils.cpp
#   TEST_LIBRARIES
#     gtest_main
# )
# # The variable 'example_SOURCES' now contains "path/to/dir/galaxy.cpp"
# # The unit test test_galaxy is now built alongside and registered with
# # CTest so it is run when `make test` is run.

include(Prepend)

include(CMakeParseArguments)
include(CTest)

macro(translation_unit)
  cmake_parse_arguments(
    TRANSLATION_UNIT
    "" # Nullary arguments (flags).
    "FILE;TEST" # Unary arguments.
    "DEPENDS;TEST_DEPENDS;TEST_LIBRARIES;TEST_INCLUDE_DIRS" # n-ary arguments.
    ${ARGN}
  )

  # Prepend current working directory to all paths.
  set(TRANSLATION_UNIT_FILE "${CMAKE_CURRENT_LIST_DIR}/${TRANSLATION_UNIT_FILE}")
  prepend(TRANSLATION_UNIT_DEPENDS "${CMAKE_CURRENT_LIST_DIR}/" ${TRANSLATION_UNIT_DEPENDS})

  # Add this FILE to the xxx_SOURCES list.
  list(APPEND ${PROJECT_NAME}_SOURCES "${TRANSLATION_UNIT_FILE}")

  # Update the xxx_SOURCES variable in the PARENT_SCOPE.
  set(${PROJECT_NAME}_SOURCES "${${PROJECT_NAME}_SOURCES}" PARENT_SCOPE)

  if(DEFINED TRANSLATION_UNIT_TEST)
    set(TRANSLATION_UNIT_TEST "${CMAKE_CURRENT_LIST_DIR}/${TRANSLATION_UNIT_TEST}")
    prepend(TRANSLATION_UNIT_TEST_DEPENDS "${CMAKE_CURRENT_LIST_DIR}/" ${TRANSLATION_UNIT_TEST_DEPENDS})

    get_filename_component(TEST_NAME "${TRANSLATION_UNIT_TEST}" NAME_WE)
    set(TEST_SOURCES
      "${TRANSLATION_UNIT_TEST}"
      "${TRANSLATION_UNIT_FILE}"
      "${TRANSLATION_UNIT_DEPENDS}"
      "${TRANSLATION_UNIT_TEST_DEPENDS}"
    )

    add_executable("${TEST_NAME}" "${TEST_SOURCES}")
    target_link_libraries("${TEST_NAME}" "${TRANSLATION_UNIT_TEST_LIBRARIES}")

    add_test(NAME "${TEST_NAME}" COMMAND "${TEST_NAME}")

    # Unset all new variables...
    unset(TEST_NAME)
    unset(TEST_SOURCES)
  endif()

  # Unset all our variables as this is a macro and not a function.
  unset(TRANSLATION_UNIT_FILE)
  unset(TRANSLATION_UNIT_DEPENDS)

  unset(TRANSLATION_UNIT_TEST)
  unset(TRANSLATION_UNIT_TEST_DEPENDS)
  unset(TRANSLATION_UNIT_TEST_LIBARIES)
  unset(TRANSLATION_UNIT_TEST_INCLUDE_DIRS)

  unset(TRANSLATION_UNIT_UNPARSED_ARGUMENTS)
endmacro()

