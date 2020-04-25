cmake_minimum_required(VERSION 3.10.2)

project (my_project C)



set(CMAKE_C_FLAGS "-O3")


add_compile_definitions(MODEL=my_model)

find_package(RTIConnextDDS REQUIRED
HINTS ${CMAKE_SOURCE_DIR})

find_package(Matlab REQUIRED)

set(SRC_DIR
${CMAKE_SOURCE_DIR}/my_modelname_ert_linux
)


file(GLOB sourcefiles
${SRC_DIR}/*.c
)

add_executable(my_executable
${sourcefiles}
)
target_compile_definitions(my_executable PUBLIC
-DRTI_UNIX -DRTI_LINUX -DRTI_64BIT
)


target_include_directories( my_executable PRIVATE
  ${SRC_DIR}
  ${CONNEXTDDS_INCLUDE_DIRS}
  ${Matlab_ROOT_DIR}/rtw/c/src
  ${Matlab_ROOT_DIR}/simulink/include
)

target_link_libraries( m12_localization_exe PRIVATE
  ${CONNEXTDDS_C_API_LIBRARIES_RELEASE_STATIC}
  pthread
  dl
  m
)



# sudo setcap cap_sys_nice=ep m12_localization_exe
