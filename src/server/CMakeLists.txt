#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# Crash logs for windows
if (WIN32)
set(winDebugging
  ${CMAKE_SOURCE_DIR}/src/common/Debugging/WheatyExceptionReport.cpp
  ${CMAKE_SOURCE_DIR}/src/common/Debugging/WheatyExceptionReport.h
  ${CMAKE_SOURCE_DIR}/src/common/Platform/ServiceWin32.cpp
  ${CMAKE_SOURCE_DIR}/src/common/Platform/ServiceWin32.h)
endif()

add_subdirectory(database)
add_subdirectory(shared)
add_subdirectory(game)
add_subdirectory(authserver)
add_subdirectory(scripts)
add_subdirectory(worldserver)
