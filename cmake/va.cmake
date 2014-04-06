
write_file( "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/a-list-is-array.c"
    "#include <stdarg.h>
    int foo(char *f, ...)
    {
        va_list ap1, ap2;
        va_start(ap1, f);
        ap2 = ap1;
        if ( va_arg(ap1, int) != 17 || va_arg(ap2, int) != 17 )
            return 1;
        va_end(ap2);
        va_end(ap1);
        return 0;
    }
    int main()
    {
    }
    ")

try_compile( VA_LIST_IS_NOT_ARRAY
  ${CMAKE_BINARY_DIR}/
  ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/a-list-is-array.c )

if(VA_LIST_IS_NOT_ARRAY)
  set(VA_LIST_IS_ARRAY 0)
  message(STATUS "va_list is not an array")
else(VA_LIST_IS_NOT_ARRAY)
  set(VA_LIST_IS_ARRAY 1)
  message(STATUS "va_list is an array")
endif(VA_LIST_IS_NOT_ARRAY)
