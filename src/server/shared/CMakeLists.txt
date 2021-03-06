#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
#

CollectSourceFiles(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PRIVATE_SOURCES)

# Group sources
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_definitions(-DACORE_API_EXPORT_SHARED)

add_library(shared
  ${PRIVATE_SOURCES})

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES)

target_include_directories(shared
  PUBLIC
    ${PUBLIC_INCLUDES}
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(shared
  PRIVATE
    acore-core-interface
  PUBLIC
    database)

set_target_properties(shared
  PROPERTIES
    FOLDER
      "server")

if( BUILD_SHARED_LIBS )
  if( UNIX )
    install(TARGETS shared
      LIBRARY
        DESTINATION lib)
  elseif( WIN32 )
    install(TARGETS shared
      RUNTIME
        DESTINATION "${CMAKE_INSTALL_PREFIX}")
  endif()
endif()
