# Append compiler flags
#  From: https://github.com/lubosz/liblub/blob/master/CMakeLists.txt

function(add_cxxflag FLAG)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FLAG}" PARENT_SCOPE)
endfunction()
