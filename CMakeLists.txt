cmake_minimum_required(VERSION 3.10.2)

project (m12_localization C)



set(CMAKE_C_FLAGS "-O3")

#add_definitions('-DrtmGetStopRequested(rtm)=((void*) 0)')
#add_compile_definitions( 'rtmGetStopRequested(rtm)=((void*) 0)' )
#add_definitions('-DrtmSetStopRequested(rtm,rtm2)=((void*) 0)')
add_compile_definitions(MODEL=m12_localization)

find_package(RTIConnextDDS REQUIRED
HINTS ${CMAKE_SOURCE_DIR})

find_package(Matlab REQUIRED)

set(SRC_DIR
${CMAKE_SOURCE_DIR}/m12_localization_ert_linux
)


file(GLOB sourcefiles
${SRC_DIR}/*.c
)

#[[

message(
"The DDS_TYPE_OBJECT_DIR is: ${DDS_TYPE_OBJECT_DIR}"
)
message(
"The object files are: ${dds_typeobjs}"
)
]]




add_executable(m12_localization_exe
${sourcefiles}
)
target_compile_definitions(m12_localization_exe PUBLIC
-DRTI_UNIX -DRTI_LINUX -DRTI_64BIT
)


target_include_directories( m12_localization_exe PRIVATE
  ${SRC_DIR}
  ${CONNEXTDDS_INCLUDE_DIRS}
  ${Matlab_ROOT_DIR}/rtw/c/src
  ${Matlab_ROOT_DIR}/simulink/include
)
#[[
message(
  "CONNEXTDDS_C_API_LIBRARIES: ${CONNEXTDDS_C_API_LIBRARIES_RELEASE_STATIC}"
)
]]

target_link_libraries( m12_localization_exe PRIVATE
  ${CONNEXTDDS_C_API_LIBRARIES_RELEASE_STATIC}
  pthread
  dl
  m
)

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)      ((void*) 0)
#endif
#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm,rtm2)      ((void*) 0)
#endif
#define MODEL m12_localization

# sudo setcap cap_sys_nice=ep m12_localization_exe
