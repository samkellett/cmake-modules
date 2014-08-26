# Downloads the glcorearb.h header into the local build directory if it doesn't
#  exist on the user's system.
#  From: https://github.com/lubosz/liblub/blob/master/CMakeLists.txt

if(WIN32)
  message(ERROR "Does not support Windows (yet!)")
else()
  if(EXISTS /usr/include/GL/glcorearb.h)
    message(STATUS "Core Profile API header found in /usr/include")
  else()
    message(STATUS "No Core Profile API header in /usr. Using local one.")
    if(NOT EXISTS ${CMAKE_BUILD_DIR}/include/GL)
      execute_process(COMMAND mkdir -p ${CMAKE_BUILD_DIR}/include/GL)
    endif()

    if(NOT EXISTS ${CMAKE_BUILD_DIR}/include/GL/glcorearb.h)
      execute_process(
        WORKING_DIRECTORY ${CMAKE_BUILD_DIR}/include/GL
        COMMAND wget http://opengl.org/registry/api/glcorearb.h
      )
    endif()

    include_directories(${CMAKE_BUILD_DIR}/include)
  endif()
endif()

