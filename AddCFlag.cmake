# Based on AddCxxFlag

function(add_cflag FLAG)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${FLAG}" PARENT_SCOPE)
endfunction()
