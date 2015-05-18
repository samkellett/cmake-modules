# CMake command that creates a .syntastic_cpp_config file in the source directory that
# mirrors the include_directories for that project.

function(create_syntastic_config)
  get_directory_property(DIRECTORIES INCLUDE_DIRECTORIES)
  list(REMOVE_DUPLICATES DIRECTORIES)

  set(CONFIG_FILE "${CMAKE_SOURCE_DIR}/.syntastic_cpp_config")
  file(REMOVE "${CONFIG_FILE}")

  foreach(DIRECTORY IN LISTS DIRECTORIES)
    file(APPEND "${CONFIG_FILE}" "-I${DIRECTORY}\n")
  endforeach()
endfunction()
