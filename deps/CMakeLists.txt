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
#

if(CMAKE_SYSTEM_NAME MATCHES "Windows")
  if(USE_MYSQL_SOURCES)
      add_subdirectory(mysqllite)
  endif()
endif()

add_subdirectory(threads)
add_subdirectory(acelite)
add_subdirectory(fmt)
add_subdirectory(poco)
add_subdirectory(boost)
add_subdirectory(process)

if(SERVERS OR TOOLS)
  add_subdirectory(zlib)
  add_subdirectory(g3dlite)
  add_subdirectory(recastnavigation)
  add_subdirectory(SFMT)
  add_subdirectory(utf8cpp)
  add_subdirectory(openssl)
endif()

if(SERVERS)
  add_subdirectory(mysql)
  add_subdirectory(readline)
  add_subdirectory(jemalloc)
  add_subdirectory(gsoap)
endif()

if(TOOLS)
  add_subdirectory(bzip2)
  add_subdirectory(libmpq)
endif()
