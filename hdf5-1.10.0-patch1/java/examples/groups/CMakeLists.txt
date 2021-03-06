cmake_minimum_required (VERSION 3.1.0)
PROJECT (HDFJAVA_EXAMPLES_GROUPS Java)

set (CMAKE_VERBOSE_MAKEFILE 1)

INCLUDE_DIRECTORIES (
    ${HDF5_JAVA_JNI_BINARY_DIR}
    ${HDF5_JAVA_HDF5_LIB_DIR}
)

set (HDF_JAVA_EXAMPLES
    H5Ex_G_Create
    H5Ex_G_Iterate
    H5Ex_G_Compact
    H5Ex_G_Corder
    H5Ex_G_Intermediate
    H5Ex_G_Phase
    H5Ex_G_Visit
)

if (WIN32)
  set (CMAKE_JAVA_INCLUDE_FLAG_SEP ";")
else (WIN32)
  set (CMAKE_JAVA_INCLUDE_FLAG_SEP ":")
endif (WIN32)

set (CMAKE_JAVA_INCLUDE_PATH "${HDF5_JAVA_JARS}")

set (CMAKE_JAVA_CLASSPATH ".")
foreach (CMAKE_INCLUDE_PATH ${CMAKE_JAVA_INCLUDE_PATH})
  set (CMAKE_JAVA_CLASSPATH "${CMAKE_JAVA_CLASSPATH}${CMAKE_JAVA_INCLUDE_FLAG_SEP}${CMAKE_INCLUDE_PATH}")
endforeach (CMAKE_INCLUDE_PATH)

foreach (example ${HDF_JAVA_EXAMPLES})
  file (WRITE ${PROJECT_BINARY_DIR}/${example}_Manifest.txt
  "Main-Class: examples.groups.${example}
"
  )
  add_jar (${example} MANIFEST ${PROJECT_BINARY_DIR}/${example}_Manifest.txt ${example}.java)
  get_target_property (${example}_JAR_FILE ${example} JAR_FILE)
#  install_jar (${example} ${HJAVA_INSTALL_DATA_DIR}/examples examples)
  get_target_property (${example}_CLASSPATH ${example} CLASSDIR)
  add_dependencies (${example} ${HDF5_JAVA_HDF5_LIB_TARGET})
endforeach (example ${HDF_JAVA_EXAMPLES})

set (CMAKE_JAVA_INCLUDE_PATH "${HDF5_JAVA_JARS};${HDF5_JAVA_LOGGING_JAR};${HDF5_JAVA_LOGGING_NOP_JAR}")

set (CMAKE_JAVA_CLASSPATH ".")
foreach (HDFJAVA_JAR ${CMAKE_JAVA_INCLUDE_PATH})
  set (CMAKE_JAVA_CLASSPATH "${CMAKE_JAVA_CLASSPATH}${CMAKE_JAVA_INCLUDE_FLAG_SEP}${HDFJAVA_JAR}")
endforeach (HDFJAVA_JAR)

set (HDF_JAVA_TEST_FILES
    h5ex_g_iterate.h5
    h5ex_g_visit.h5
)

foreach (h5_file ${HDF_JAVA_TEST_FILES})
  set (dest "${PROJECT_BINARY_DIR}/${h5_file}")
  #message (STATUS " Copying ${h5_file}")
  add_custom_command (
      TARGET     H5Ex_G_Visit
      POST_BUILD
      COMMAND    ${CMAKE_COMMAND}
      ARGS       -E copy_if_different ${PROJECT_SOURCE_DIR}/${h5_file} ${dest}
  )
endforeach (h5_file ${HDF_JAVA_TEST_FILES})

MACRO (ADD_H5_TEST resultfile resultcode)
  if (CMAKE_BUILD_TYPE MATCHES Debug)
    set (CMD_ARGS "-Dhdf.hdf5lib.H5.loadLibraryName=hdf5_java_debug;")
  endif(CMAKE_BUILD_TYPE MATCHES Debug)
  add_test (
      NAME JAVA_groups-${resultfile}
      COMMAND "${CMAKE_COMMAND}"
          -D "TEST_TESTER=${CMAKE_Java_RUNTIME};${CMAKE_Java_RUNTIME_FLAGS}"
          -D "TEST_PROGRAM=examples.groups.${resultfile}"
          -D "TEST_ARGS:STRING=${CMD_ARGS}${ARGN}"
          -D "TEST_CLASSPATH:STRING=${CMAKE_JAVA_CLASSPATH}${CMAKE_JAVA_INCLUDE_FLAG_SEP}${${resultfile}_JAR_FILE}"
          -D "TEST_LIBRARY_DIRECTORY=${CMAKE_TEST_OUTPUT_DIRECTORY}"
          -D "TEST_FOLDER=${HDFJAVA_EXAMPLES_BINARY_DIR}"
          -D "TEST_OUTPUT=groups/${resultfile}.out"
          -D "TEST_EXPECT=${resultcode}"
          -D "TEST_REFERENCE=groups/${resultfile}.txt"
          -P "${HDF_RESOURCES_DIR}/jrunTest.cmake"
  )
  if (NOT "${last_test}" STREQUAL "")
    set_tests_properties (JAVA_groups-${resultfile} PROPERTIES DEPENDS ${last_test})
  endif (NOT "${last_test}" STREQUAL "")
  set (last_test "JAVA_groups-${resultfile}")
ENDMACRO (ADD_H5_TEST file)

if (BUILD_TESTING)
  foreach (example ${HDF_JAVA_EXAMPLES})
    add_test (
        NAME JAVA_groups-${example}-clear-objects
        COMMAND    ${CMAKE_COMMAND}
            -E remove
            ${example}.out
            ${example}.out.err
    )
    if (NOT "${last_test}" STREQUAL "")
      set_tests_properties (JAVA_groups-${example}-clear-objects PROPERTIES DEPENDS ${last_test})
    endif (NOT "${last_test}" STREQUAL "")
    set (last_test "JAVA_groups-${example}-clear-objects")
    if (NOT ${example} STREQUAL "H5Ex_G_Iterate" AND NOT ${example} STREQUAL "H5Ex_G_Visit")
      if (${example} STREQUAL "H5Ex_G_Compact")
        add_test (
            NAME JAVA_groups-${example}-clear-h5s
            COMMAND    ${CMAKE_COMMAND}
                -E remove
                ${HDFJAVA_EXAMPLES_BINARY_DIR}/${example}1.h5
                ${HDFJAVA_EXAMPLES_BINARY_DIR}/${example}2.h5
        )
      else (${example} STREQUAL "H5Ex_G_Compact")
        add_test (
            NAME JAVA_groups-${example}-clear-h5s
            COMMAND    ${CMAKE_COMMAND}
                -E remove
                ${HDFJAVA_EXAMPLES_BINARY_DIR}/${example}.h5
        )
      endif (${example} STREQUAL "H5Ex_G_Compact")
      if (NOT "${last_test}" STREQUAL "")
        set_tests_properties (JAVA_groups-${example}-clear-h5s PROPERTIES DEPENDS ${last_test})
      endif (NOT "${last_test}" STREQUAL "")
      set (last_test "JAVA_groups-${example}-clear-h5s")
    endif (NOT ${example} STREQUAL "H5Ex_G_Iterate" AND NOT ${example} STREQUAL "H5Ex_G_Visit")
    add_test (
        NAME JAVA_groups-${example}-copy-objects
        COMMAND    ${CMAKE_COMMAND}
            -E copy_if_different
            ${HDFJAVA_EXAMPLES_SOURCE_DIR}/testfiles/examples.groups.${example}.txt
            ${HDFJAVA_EXAMPLES_GROUPS_BINARY_DIR}/${example}.txt
    )
    if (NOT "${last_test}" STREQUAL "")
      set_tests_properties (JAVA_groups-${example}-copy-objects PROPERTIES DEPENDS ${last_test})
    endif (NOT "${last_test}" STREQUAL "")
    set (last_test "JAVA_groups-${example}-copy-objects")
    ADD_H5_TEST (${example} 0)
  endforeach (example ${HDF_JAVA_EXAMPLES})
endif (BUILD_TESTING)
