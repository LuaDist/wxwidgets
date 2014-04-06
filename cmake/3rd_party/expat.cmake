
include_directories(
	src/expat/lib
)

add_definitions(-DHAVE_BCOPY)

add_library( expat STATIC
    src/expat/lib/xmlparse.c
    src/expat/lib/xmlrole.c
    src/expat/lib/xmltok.c
)



