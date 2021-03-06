#
#
#

# Группировка сорцов
GroupSources(${CMAKE_CURRENT_SOURCE_DIR})

add_library(modules-interface INTERFACE)

CollectIncludeDirectories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  PUBLIC_INCLUDES)

target_include_directories(modules-interface
  INTERFACE
    ${PUBLIC_INCLUDES})

target_link_libraries(modules-interface
  INTERFACE
    game-interface)

if (NOT DISABLED_ALL_MODULES AND MODULES_EXIST)
# Collect source files not disable modules
CU_SUBDIRLIST(sub_DIRS  "${CMAKE_SOURCE_DIR}/modules" FALSE FALSE)
FOREACH(subdir ${sub_DIRS})
  get_filename_component(MODULENAME ${subdir} NAME)
    
  if (";${DISABLED_AC_MODULES};" MATCHES ";${MODULENAME};")
    continue()
  endif()

  STRING(REGEX REPLACE "^${CMAKE_SOURCE_DIR}/" "" subdir_rel ${subdir}) 
  CollectSourceFiles(
    ${CMAKE_SOURCE_DIR}/${subdir_rel}/
    PRIVATE_SOURCES)

  set(MODULES_STAT_SRCS
    ${MODULES_STAT_SRCS}
    ${PRIVATE_SOURCES})
ENDFOREACH()

add_library(modules STATIC
  ${MODULES_STAT_SRCS})

target_include_directories(modules
  PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries(modules
  PRIVATE
    modules-interface
  PUBLIC
    scripts)

add_dependencies(modules revision.h)

set_target_properties(modules
  PROPERTIES
    FOLDER
      "modules")
endif()