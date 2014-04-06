
include(CheckIncludeFile)
include(CheckIncludeFiles)
include(TestBigEndian)
include(CheckCSourceCompiles)
include(CheckSymbolExists)
include(CheckTypeSize)
include(CheckFunctionExists)
include(CheckCXXSymbolExists)
include(CheckIncludeFileCXX)
include(CheckStructHasMember)
include(CheckLibraryExists)

include(cmake/configure/functions.cmake)
include(cmake/configure/headers.cmake)
include(cmake/configure/sizes.cmake)
include(cmake/configure/symbols.cmake)

include(cmake/configure/defines.cmake)

if(UNIX)
	execute_process( COMMAND uname -m COMMAND tr -d '\n' OUTPUT_VARIABLE ARCHITECTURE )
endif()

set( WXWIN_OS_DESCRIPTION "\"${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_VERSION} ${ARCHITECTURE}\"")
set( wxINSTALL_PREFIX "\"/usr/local\"")

check_include_files("stdlib.h;stdarg.h;string.h;float.h" STDC_HEADERS)

test_big_endian(WORDS_BIGENDIAN)

find_package(GTK)
if(GTK_FOUND)
	set(__WXGTK127__ 1)
endif()

find_package(GTK2)
if(GTK2_FOUND)
	if(GTK2_VERSION VERSION_GREATER "2.0")
		set(__WXGTK20__ 1)
	elseif(GTK2_VERSION VERSION_GREATER "2.6")
		set(__WXGTK26__ 1)
	elseif(GTK2_VERSION VERSION_GREATER "2.10")
		set(__WXGTK210__ 1)
	elseif(GTK2_VERSION VERSION_GREATER "2.18")
		set(__WXGTK218__ 1)
	endif()
endif()

find_package(GTK3 3.0)
if(GTK3_FOUND)
	set(__WXGTK3__ 1)
endif()

# GPE

find_package(Motif)
if(MOTIF_FOUND)
	#set( __WXMOTIF20__ 1)
	#set( __WXLESSTIF__ 1)
endif()

# __POWERPC__
# __Point__
# __DOS__
# __OS2__

set( WXWIN_COMPATIBILITY_2_6 0)
set( WXWIN_COMPATIBILITY_2_8 1)
set( wxDIALOG_UNIT_COMPATIBILITY 0)

set( HAVE_EXPLICIT 1)

INCLUDE(VA_COPY)
VA_COPY()


check_include_files(stdarg.h HAVE_STDARG_PROTOTYPES)
if(HAVE_STDARG_PROTOTYPES)
   set(vaargsHeader "stdarg.h")
else(HAVE_STDARG_PROTOTYPES)
   set(vaargsHeader "varargs.h")
endif(HAVE_STDARG_PROTOTYPES)
check_c_source_compiles("#include <${vaargsHeader}>\n int main() {va_list list1, list2; list1 = list2;}" NOT_VA_LIST_IS_ARRAY)
if(NOT_VA_LIST_IS_ARRAY)
  set(VA_LIST_IS_ARRAY 1) # prehodene z 0 na 1
else(NOT_VA_LIST_IS_ARRAY)
  set(VA_LIST_IS_ARRAY 0) # prehodene z 1 na 0
endif(NOT_VA_LIST_IS_ARRAY)


set( HAVE_VARIADIC_MACROS 1)
set( wxNO_VARIADIC_MACROS 0)



include(CheckCxxHashmap)
check_hashmap()
    if(HAVE_GNU_EXT_HASH_MAP)
      set(HAVE_GNU_CXX_HASH_MAP 1)
    elseif(HAVE_STD_EXT_HASH_MAP)
      set(HAVE_EXT_HASH_MAP 1)
    elseif(HAVE_GLOBAL_HASH_MAP)
      set(HAVE_HASH_MAP 1)
    else()
      set(HAVE_HASH_MAP 0)
    endif()

CHECK_INCLUDE_FILE_CXX("unordered_map" HAVE_STD_UNORDERED_MAP)
CHECK_INCLUDE_FILE_CXX("unordered_set" HAVE_STD_UNORDERED_SET)
#CHECK_INCLUDE_FILE_CXX("tr1/unordered_map" HAVE_TR1_UNORDERED_MAP)
#CHECK_INCLUDE_FILE_CXX("tr1/unordered_set" HAVE_TR1_UNORDERED_SET)


CHECK_CXX_SOURCE_COMPILES("
  int main()
  {
    int foo= -10; int bar= 10;
    long long int foo64= -10; long long int bar64= 10;
    if (!__sync_fetch_and_add(&foo, bar) || foo)
      return -1;
    bar= __sync_lock_test_and_set(&foo, bar);
    if (bar || foo != 10)
      return -1;
    bar= __sync_val_compare_and_swap(&bar, foo, 15);
    if (bar)
      return -1;
    if (!__sync_fetch_and_add(&foo64, bar64) || foo64)
      return -1;
    bar64= __sync_lock_test_and_set(&foo64, bar64);
    if (bar64 || foo64 != 10)
      return -1;
    bar64= __sync_val_compare_and_swap(&bar64, foo, 15);
    if (bar64)
      return -1;
    return 0;
  }"
  HAVE_GCC_ATOMIC_BUILTINS)

# HAVE_BROKEN_LIBSTDCXX_VISIBILITY
# HAVE_BROKEN_LIBSTDCXX_VISIBILITY
# WX_NO_REGEX_ADVANCED
# HAVE_RE_SEARCH


check_function_exists( pthread_cleanup_push HAVE_PTHREAD_CLEANUP_PUSH)
check_function_exists( pthread_cleanup_pop HAVE_PTHREAD_CLEANUP_POP)

#if(${HAVE_PTHREAD_CLEANUP_PUSH} AND ${HAVE_PTHREAD_CLEANUP_POP} )
	set( wxHAVE_PTHREAD_CLEANUP 1 )
#endif()

include( CheckLargefile )

set( WX_TIMEZONE timezone )

# provizorne riesenia:
set( WX_SOCKLEN_T socklen_t)
set( SOCKOPTLEN_T socklen_t)
set( WX_STATFS_T "struct statfs")
set( wxTYPE_SA_HANDLER int )

# WX_GETTIMEOFDAY_NO_TZ

check_struct_has_member ("struct tm" tm_gmtoff time.h WX_GMTOFF_IN_TM)


check_struct_has_member ("struct passwd" pw_gecos pwd.h HAVE_PW_GECOS)


find_package(CxaDemangle)

# docasne:
set( HAVE_PTHREAD_MUTEXATTR_T 1 )
set( HAVE_PTHREAD_MUTEXATTR_SETTYPE_DECL 1 )
set( HAVE_PTHREAD_RECURSIVE_MUTEX_INITIALIZER 0 )
set( HAVE_PTHREAD_CANCEL 1)
set( HAVE_PTHREAD_MUTEX_TIMEDLOCK 1)
set( HAVE_PTHREAD_ATTR_SETSTACKSIZE 1)

# HAVE_SHL_LOAD

check_function_exists( snprintf HAVE_SNPRINTF_DECL )
# docasne:
set( HAVE_UNIX98_PRINTF 1)
set( HAVE_STATFS_DECL 1)
set( HAVE_THREAD_PRIORITY_FUNCTIONS 1)
set( HAVE_VSNPRINTF_DECL 1)
set( HAVE_VSSCANF_DECL 1)


check_function_exists( wcstoull HAVE_wcstoull )
check_function_exists( wcstoll HAVE_wcstoll )
if(${HAVE_wcstoull} AND ${HAVE_wcstoll})
	set( HAVE_WCSTOULL 1)
endif()


set( SIZEOF_VOID_P ${CMAKE_SIZEOF_VOID_P} )

CHECK_TYPE_SIZE(size_t SIZEOF_SIZE_T)


CHECK_TYPE_SIZE("unsigned int" uint)
if(${SIZEOF_SIZE_T} STREQUAL ${uint})
	set( wxSIZE_T_IS_UINT 1)
endif()

CHECK_TYPE_SIZE("unsigned long" ulong)
if(${SIZEOF_SIZE_T} STREQUAL ${ulong})
	set( wxSIZE_T_IS_ULONG 1)
endif()


# docasne:
set( wxWCHAR_T_IS_REAL_TYPE 1)


CHECK_INCLUDE_FILE( fcntl.h HAVE_FCNTL)


# docasne
set( HAVE_FUNC_GETHOSTBYNAME_R_5 0)
set( HAVE_FUNC_GETHOSTBYNAME_R_3 0)

set( HAVE_THR_SETCONCURRENCY 0)
set( HAVE_PTHREAD_SET_CONCURRENCY 1)


#######################################################################################

if(UNIX AND NOT APPLE)
	if( CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX)
		set(_GNU_SOURCE 1 )
	endif()

	set( __UNIX__ 1 )
	if( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" )
		set( __LINUX__ 1 )
	endif()

	#check_cxx_compiler_flag(-fvisibility=hidden HAVE_VISIBILITY)
	set( HAVE_VISIBILITY 1 )
	set( HAVE___THREAD_KEYWORD 1 )

	set( HAVE_FUNC_GETHOSTBYNAME_R_6 1)
	set( HAVE_FUNC_GETSERVBYNAME_R_6 1)
	set( HAVE_GETHOSTBYNAME 0)

	set( WX_NO_REGEX_ADVANCED 1)

	find_package(GStreamer)
	if(GSTREAMER_FOUND)
		include_directories( ${GSTREAMER_INCLUDE_DIR} )
	endif()

endif()

if(APPLE)
	set( __BSD__ 1 )
	set( DARWIN 1 )
	set( TARGET_CARBON 1)
	set( HAVE_GETHOSTBYNAME 1)
	set( HAVE_GETSERVBYNAME 1)
endif()

####################################################################################
configure_file(cmake/setup.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/wx/setup.h)
