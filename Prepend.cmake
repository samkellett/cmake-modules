# Takes a list and a string and prepends the string to each item on the list.
#   Basically robbed from: http://stackoverflow.com/a/27630120/649140

function(prepend VAR PREFIX)
  set(NEWLIST "")

  foreach(ITEM ${ARGN})
    list(APPEND(NEW_LIST "${PREFIX}${ITEM}"))
  endforeach()

  set(${VAR} "${NEW_LIST}" PARENT_SCOPE)
endfunction()
