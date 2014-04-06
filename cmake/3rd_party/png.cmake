
include_directories(
	src/png
)

 add_library(png STATIC
	src/png/png.c
            src/png/pngerror.c
            src/png/pngget.c
            src/png/pngmem.c
            src/png/pngpread.c
            src/png/pngread.c
            src/png/pngrio.c
            src/png/pngrtran.c
            src/png/pngrutil.c
            src/png/pngset.c
            src/png/pngtrans.c
            src/png/pngwio.c
            src/png/pngwrite.c
            src/png/pngwtran.c
            src/png/pngwutil.c
)
