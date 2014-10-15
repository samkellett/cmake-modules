# From: https://github.com/swift-nav/libswiftnav/blob/master/cmake/FindCheck.cmake
#
# - Try to find the CHECK libraries
#  Once done this will define
#
#  CHECK_FOUND - system has check
#  CHECK_INCLUDE_DIRS - the check include directory
#  CHECK_LIBRARIES - check library
#
#  Copyright (c) 2007 Daniel Gollub <gollub@b1-systems.de>
#  Copyright (c) 2007-2009 Bjoern Ricks  <bjoern.ricks@gmail.com>
#
#  Redistribution and use is allowed according to the terms of the New
#  BSD license.
#  For details see the accompanying COPYING-CMAKE-SCRIPTS file.

include(FindPkgConfig)

if(Check_FIND_REQUIRED)
  set(_pkgconfig_REQUIRED "REQUIRED")
else(Check_FIND_REQUIRED)
  set(_pkgconfig_REQUIRED "")
endif()

if(CHECK_MIN_VERSION)
  pkg_search_module(CHECK ${_pkgconfig_REQUIRED} check >= ${CHECK_MIN_VERSION})
else(CHECK_MIN_VERSION)
  pkg_search_module(CHECK ${_pkgconfig_REQUIRED} check)
endif()

# Look for CHECK include dir and libraries
if(NOT CHECK_FOUND AND NOT PKG_CONFIG_FOUND)
  find_path(CHECK_INCLUDE_DIRS check.h)
  find_library(CHECK_LIBRARIES NAMES check)

  if(CHECK_INCLUDE_DIRS AND CHECK_LIBRARIES)
    set(CHECK_FOUND 1)
    if(NOT Check_FIND_QUIETLY)
      message(STATUS "Found CHECK: ${CHECK_LIBRARIES}")
    endif()
  else(CHECK_INCLUDE_DIRS AND CHECK_LIBRARIES)
    if(Check_FIND_REQUIRED)
      message(FATAL_ERROR "Could NOT find CHECK")
    else(Check_FIND_REQUIRED)
      if(NOT Check_FIND_QUIETLY)
        message(STATUS "Could NOT find CHECK")
      endif()
    endif()
  endif()
endif()

# Hide advanced variables from CMake GUIs
mark_as_advanced(CHECK_INCLUDE_DIRS CHECK_LIBRARIES)
