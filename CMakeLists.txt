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
if (MINGW) # On MinGW we use the provided makefile instad of ./configure, these have been manually modified to luadist requirements
	# Build the wxWidgets library
	externalproject_add(
		wxwidgets_mingw
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
	set ( WX_LIBRARIES 
		lib/gcc_dll/libwxmsw28_gl.dll
		lib/gcc_dll/libwxmsw28_stc.dll
		lib/gcc_dll/libwxmsw28.dll
	)
	install ( FILES ${WX_LIBRARIES} DESTINATION ${INSTALL_BIN} )
	install ( FILES lib/gcc_dll/msw/wx/setup.h DESTINATION ${INSTALL_INC}/wx )
	install ( FILES lib/gcc_dll/msw/wx/msw/rcdefs.h DESTINATION ${INSTALL_INC}/wx/msw )
	install ( FILES contrib/include/wx/stc/stc.h DESTINATION ${INSTALL_INC}/wx/stc )
elseif ()
	# On unknown systems use autotools, it might actually work.
	externalproject_add(
		wxwidgets_autotools
		SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
		BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/wxwidgets
		CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/configure
			--prefix=${CMAKE_CURRENT_BINARY_DIR}
			--disable-debug
			--disable-dependency-tracking
			--enable-monolithic
			--enable-unicode
			--enable-stc
			--enable-threads
		BUILD_COMMAND make -j4 install
		INSTALL_COMMAND ""
	)
endif ()

# Common files to install
install ( DIRECTORY docs/html/ DESTINATION ${INSTALL_DOC} )
install ( DIRECTORY include/wx DESTINATION ${INSTALL_INC} )
install ( FILES docs/licence.txt docs/readme.txt DESTINATION ${INSTALL_DATA} )
