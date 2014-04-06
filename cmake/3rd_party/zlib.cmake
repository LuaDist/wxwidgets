
include_directories(
	src/zlib
)

#~             <define>_CRT_NONSTDC_NO_WARNINGS</define>

 add_library( zlib STATIC
	    src/zlib/adler32.c
            src/zlib/compress.c
            src/zlib/crc32.c
            src/zlib/deflate.c
            src/zlib/gzclose.c
            src/zlib/gzlib.c
            src/zlib/gzread.c
            src/zlib/gzwrite.c
            src/zlib/infback.c
            src/zlib/inffast.c
            src/zlib/inflate.c
            src/zlib/inftrees.c
            src/zlib/trees.c
            src/zlib/uncompr.c
            src/zlib/zutil.c
 )