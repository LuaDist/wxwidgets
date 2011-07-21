# Copyright (C) 2011 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lua C ) # Compiler check required
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
elseif (MINGW) # On MinGW we use the provided makefile instad of ./configure
	# Build the wxWidgets library
	externalproject_add(
		wxwidgets
		SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
		BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/build/msw
		BUILD_COMMAND ${CMAKE_MAKE_PROGRAM} -f makefile.gcc MONOLITHIC=1 SHARED=1 UNICODE=1 BUILD=release USE_OPENGL=1 VENDOR=LuaDist
		DEPENDEES build
		DEPENDERS install
	)
	
	# Build Scintilla contrib module
	install ( FILES lib/gcc-dll/libwxmsw28u_gcc_LuaDist.dll DESTINATION ${INSTALL_BIN} RENAME libwx.dll )
	install ( FILES lib/gcc-dll/libwxmsw28u_gl_gcc_LuaDist.dll DESTINATION ${INSTALL_BIN} RENAME libwx_gl.dll )
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
