
cmake_minimum_required(VERSION 3.1)
project(C_MAKE_DEMO)

if(APPLE)
    # no warning
    # https://stackoverflow.com/questions/31561309/cmake-warnings-under-os-x-macosx-rpath-is-not-specified-for-the-following-targe
    set(CMAKE_MACOSX_RPATH 0)
endif()


set(self_binary_name extern_test)

set(Source_files 
	${CMAKE_CURRENT_SOURCE_DcodeIR}/main.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/common.h
	${CMAKE_CURRENT_SOURCE_DIR}/func.cpp
	)

# more files, you can use if()
list(APPED Source_files )

add_executable(${self_binary_name} ${Source_files})

# include other directories
target_include_directories(${self_binary_name} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

## defines options link-libraries
target_compile_definitions(${self_binary_name} PRIVATE "_USE_DATA2")
if (WIN32)
  # visual sutdio file encoding
  target_compile_options(${self_binary_name} PRIVATE /source-charset:utf-8 /execution-charset:utf-8)
#elseif(APPLE)
else()
  # fPIC for other library link
  target_compile_options(${self_binary_name} PRIVATE -fPIC)
  target_compile_options(${self_binary_name} PRIVATE -fvisibility=hidden)
  target_compile_options(${self_binary_name} PRIVATE -fno-common )
  target_link_libraries(${self_binary_name} dl) # dlopen  
endif()
if(APPLE)
endif()



# link other libraries
if (NOT TARGET lib1)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../  build_lib1)
endif ()
target_link_libraries(${self_binary_name} lib1)


add_custom_command(
        TARGET ${self_binary_name} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_FILE:${self_binary_name}> ${CMAKE_CURRENT_SOURCE_DIR}/$<TARGET_FILE_NAME:${self_binary_name}>
)

# visual studio project tree
source_group(files FILES ${Source_files})