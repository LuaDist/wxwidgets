# Copyright (C) 2011 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( wxwidgets C ) # Compiler check required
cmake_minimum_required ( VERSION 2.8 )
include ( dist.cmake )
include ( ExternalProject )

# 2DO: Provide proper CMake based build, for now rely on the provided build system
# but configure and install modules as required by LuaDist
if (APPLE)
	# On OSX we need to configure with some extra options
	# NOTE: wxWidgets 2.8 is 32bit only as it depends on Carbon
	externalproject_add(
		wxwidgets
		SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
		CONFIGURE_COMMAND ./configure
		BUILD_COMMAND ${CMAKE_MAKE_PROGRAM}
		BUILD_IN_SOURCE 1
	)
elseif (MINGW) # On MinGW we use the provided makefile instad of ./configure, these have been manually modified to luadist requirements
	# Build the wxWidgets library
	externalproject_add(
		wxwidgets
		SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
		BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/build/luadist
		BUILD_COMMAND ${CMAKE_MAKE_PROGRAM} -f wx.mingw
		INSTALL_COMMAND ""
	)
	# Build stc contrib
	externalproject_add(
		wxwidgets_stc
		SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
		BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/build/luadist
		BUILD_COMMAND ${CMAKE_MAKE_PROGRAM} -f wx_stc.mingw
		INSTALL_COMMAND ""
	)
	# Install
	install ( FILES lib/gcc_dll/libwx.dll lib/gcc_dll/libwx_gl.dll lib/gcc_dll/libwx_stc.dll DESTINATION ${INSTALL_BIN} )
	install ( FILES include/wx/msw/setup.h DESTINATION ${INSTALL_INC}/wx )
	install ( FILES contrib/include/wx/stc/stc.h DESTINATION ${INSTALL_INC}/wx/stc )
	
elseif ()
	# On Unknown systems just call configure
	externalproject_add(
		wxwidgets
		SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
		CONFIGURE_COMMAND ./configure
		BUILD_COMMAND ${CMAKE_MAKE_PROGRAM}
		BUILD_IN_SOURCE 1
	)
endif ()

# Common files to install
install ( DIRECTORY docs/html/ DESTINATION ${INSTALL_DOC} )
install ( DIRECTORY include/wx DESTINATION ${INSTALL_INC} )
install ( FILES docs/licence.txt docs/readme.txt DESTINATION ${INSTALL_DATA} )
