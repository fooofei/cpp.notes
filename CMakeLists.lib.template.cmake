
cmake_minimum_required(VERSION 3.1)
project(C_LIBRARY_DEMO)

if(APPLE)
    # no warning
    # https://stackoverflow.com/questions/31561309/cmake-warnings-under-os-x-macosx-rpath-is-not-specified-for-the-following-targe
    set(CMAKE_MACOSX_RPATH 0)
endif()


set(self_library_name extern_test)

set(Source_files 
	${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/common.h
	${CMAKE_CURRENT_SOURCE_DIR}/func.cpp

	)
list(APPEND Source_files ...)

add_library(${self_library_name} STATIC|SHARED  ${Source_files})

# include other directories
target_include_directories(${self_library_name} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

# for others module include
target_include_directories(${self_library_name} INTERFACE|PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

## defines options link-libraries
target_compile_definitions(${self_library_name} PRIVATE "_USE_DATA2")
if (WIN32)
  # visual studio file encoding
  target_compile_options(${self_library_name} PRIVATE /source-charset:utf-8 /execution-charset:utf-8)
#elseif(APPLE)
else()
  # fPIC for other library link
  target_compile_options(${self_library_name} PRIVATE -fPIC)
  target_compile_options(${self_library_name} PRIVATE -fvisibility=hidden)
  target_compile_options(${self_library_name} PRIVATE -fno-common )
  target_link_libraries(${self_library_name} dl) # dlopen  
endif()
if(APPLE)
endif()


# link other libraries
if (NOT TARGET lib1)
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../  build_lib1)
endif ()
target_link_libraries(${self_library_name} lib1)

source_group(files FILES ${Source_files})

