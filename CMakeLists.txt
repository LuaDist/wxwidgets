# Copyright (C) 2014 LuaDist.
# Created by Peter Kapec, Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( wxwidgets C CXX ) # Compiler check required
cmake_minimum_required ( VERSION 2.8 )
#~ include ( cmake/dist.cmake )


# Default build type
if( NOT CMAKE_BUILD_TYPE )
#	set( CMAKE_BUILD_TYPE "MinSizeRel" CACHE STRING "" FORCE )
	set( CMAKE_BUILD_TYPE "Debug" CACHE STRING "" FORCE )
endif()

set( CMAKE_MODULE_PATH
	"${CMAKE_CURRENT_SOURCE_DIR}/cmake"
	${CMAKE_MODULE_PATH} )

#set (CMAKE_CXX_FLAGS "-Wl,--no-undefined,--no-allow-shlib-undefined")

include( cotire )
if( COMMAND cotire )
	if( NOT COTIRE_MAXIMUM_NUMBER_OF_UNITY_INCLUDES )
		include( ProcessorCount )
		ProcessorCount( N )

		if( NOT N EQUAL 0 )
			set( COTIRE_MAXIMUM_NUMBER_OF_UNITY_INCLUDES "-j${N}" )
		endif()
	endif()

	set( COTIRE_VERBOSE FALSE )
	set( COTIRE_DEBUG FALSE )
endif()



include ( cmake/configure.cmake )

# needed packages
#~ find_package(JPEG REQUIRED)
#~ find_package(TIFF REQUIRED)
#~ find_package(PNG REQUIRED)
#~ find_package(ZLIB REQUIRED)

#~ find_package(OpenGL)
find_package(GTK2 COMPONENTS gtk)
if(GTK2_FOUND)
	include_directories(SYSTEM ${GTK2_INCLUDE_DIRS} )
	message("GTK dirs: ${GTK2_INCLUDE_DIRS}")
endif()

#~ find_package(X11)
#~ FIND_PACKAGE(Motif)

#~ include_directories(
#~ 	${JPEG_INCLUDE_DIR}
#~ 	${TIFF_INCLUDE_DIR}
#~ 	${PNG_INCLUDE_DIR}
#~ 	${ZLIB_INCLUDE_DIRS}
#~ )
#~ add_definitions(${PNG_DEFINITIONS})


#~ include_directories(
#~ 	${CMAKE_CURRENT_SOURCE_DIR}
#~ 	${CMAKE_CURRENT_SOURCE_DIR}/include
#~ 	${CMAKE_CURRENT_BINARY_DIR}
#~ 	)

#~ IF(X11_FOUND)
#~ 	SET(X11 TRUE)
#~ ENDIF()
#~ IF(GTK_FOUND)
#~ 	SET(GTK TRUE)
#~ ENDIF()


#~ if(WIN32)
#~   add_definitions(-D_WIN32_WINNT=0x0501 -D__WXMSW__)
#~ endif(WIN32)

# add_definitions(
# 	-DSTRICT
# 	-D_UNICODE
# 	-DWXBUILDING
# )


#configure_file(setup.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/wx/setup.h)

include_directories(
	${CMAKE_CURRENT_SOURCE_DIR}/include
	${CMAKE_CURRENT_SOURCE_DIR}/interface
	${CMAKE_CURRENT_SOURCE_DIR}/src/stc/scintilla/include
	${CMAKE_CURRENT_SOURCE_DIR}/src/stc/scintilla/src
	${CMAKE_CURRENT_SOURCE_DIR}/src/stc/scintilla/lexlib
	${CMAKE_CURRENT_BINARY_DIR}
)

#include( cmake/3rd_party/expat.cmake )
#include( cmake/3rd_party/jpeg.cmake )
#include( cmake/3rd_party/regex.cmake )
#include( cmake/3rd_party/tiff.cmake )
#include( cmake/3rd_party/scintilla.cmake )
#include( cmake/3rd_party/zlib.cmake )


add_definitions(
	-D__WXGTK__
	-DWX_PRECOMP
	-DMONOLITHIC
	-DWXBUILDING
	-DWXUSINGDLL
)

set( PLATFORM_UNIX TRUE)
set( TOOLKIT "GTK")
set( TOOLKIT_VERSION "2")
set( USE_GUI TRUE)
set( WXUNIV TRUE )


if( PLATFORM_UNIX )
	message("DOING: PLATFORM_UNIX")
endif()
if( ${TOOLKIT} MATCHES "GTK2" )
	message("DOING: GTK")
endif()

include( cmake/files.cmake )
#include( cmake/monolithic.cmake )
include( cmake/multilib.cmake )
