#
#   AC_ADD_SCRIPT
#

MACRO(AC_ADD_SCRIPT path)
    CU_ADD_GLOBAL("AC_SCRIPTS_SOURCES" "${path}")
ENDMACRO()

#
#   AC_ADD_SCRIPT_LOADER
#

MACRO(AC_ADD_SCRIPT_LOADER script_dec include)
    set (lower_prio_scripts ${ARGN})
    list(LENGTH lower_prio_scripts num_lower_prio_scripts)
    if (${num_lower_prio_scripts} GREATER 0)
        CU_GET_GLOBAL("AC_ADD_SCRIPTS_LIST")
        foreach(lower_prio_script ${lower_prio_scripts})
            if ("${AC_ADD_SCRIPTS_LIST}" MATCHES "Add${lower_prio_script}Scripts()")
                message("-- ${script_dec} demands lower priority: ${lower_prio_script} --")
                list(REMOVE_ITEM AC_ADD_SCRIPTS_LIST "Add${lower_prio_script}Scripts()")
                CU_SET_GLOBAL("AC_ADD_SCRIPTS_LIST" "${AC_ADD_SCRIPTS_LIST}")
                list(APPEND removed_lower_prio_scripts ${lower_prio_script})
            endif()
        endforeach()
        CU_ADD_GLOBAL("AC_ADD_SCRIPTS_LIST" "Add${script_dec}Scripts()\;")
        foreach(lower_prio_script ${removed_lower_prio_scripts})
            CU_ADD_GLOBAL("AC_ADD_SCRIPTS_LIST" "Add${lower_prio_script}Scripts()\;")
        endforeach()
    else()
        CU_ADD_GLOBAL("AC_ADD_SCRIPTS_LIST" "Add${script_dec}Scripts()\;")
    endif()


    if (NOT ${include} STREQUAL "")
        CU_GET_GLOBAL("AC_ADD_SCRIPTS_INCLUDE")
        if (NOT ";${AC_ADD_SCRIPTS_INCLUDE};" MATCHES ";${include};")
            CU_ADD_GLOBAL("AC_ADD_SCRIPTS_INCLUDE" "${include}\;")
        endif()
    endif()
ENDMACRO()

#
#   AC_ADD_CONFIG_FILE
#

MACRO(AC_ADD_CONFIG_FILE configFilePath)
    CU_GET_GLOBAL("MODULE_CONFIG_FILE_LIST")
    CU_ADD_GLOBAL("MODULE_CONFIG_FILE_LIST" "${configFilePath}")
ENDMACRO()

#
#   AC_ADD_DEF_SCRIPT_LOADER 
#

macro(AC_ADD_DEF_SCRIPT_LOADER script_dec)
    CU_GET_GLOBAL("AC_DEF_SCRIPTS_LIST")
    CU_ADD_GLOBAL("AC_DEF_SCRIPTS_LIST" "void Add${script_dec}Scripts();")
endmacro()

#
#   AC_ADD_MODULES_SOURCE
#

macro(AC_ADD_MODULES_SOURCE scriptName)
    CU_SUBDIRLIST(sub_DIRS ${CMAKE_CURRENT_LIST_DIR}/src/ TRUE TRUE)
    
    FOREACH(subdir ${sub_DIRS})
    file(GLOB sources "${subdir}/*.cpp" "${subdir}/*.h")
        CU_LIST_ADD_CACHE(scripts_STAT_SRCS "${sources}")
    ENDFOREACH()

    AC_ADD_DEF_SCRIPT_LOADER("${scriptName}")
    AC_ADD_SCRIPT_LOADER("${scriptName}" "")
    message(STATUS "  -> Prepared module script: ${scriptName}")
ENDMACRO()

#
#   
#

macro(AC_ADD_MODULE modulename)
    CU_GET_GLOBAL("AC_MODULE_LIST")
    CU_ADD_GLOBAL("AC_MODULE_LIST" "${modulename}")
endmacro()