
check_type_size(gid_t GID_T)
if(NOT HAVE_GID_T)
	set(GID_T "int")
endif()

check_type_size(mode_t MODE_T)
if(NOT HAVE_MODE_T)
	set(MODE_T "int")
endif()

check_type_size(off_t OFF_T)
if(NOT HAVE_OFF_T)
	set(GID_T "long")
endif()

check_type_size(pid_t PID_T)
if(NOT HAVE_PID_T)
	set(PID_T "int")
endif()

check_type_size(size_t SIZE_T)
if(NOT HAVE_SIZE_T)
	set(SIZE_T "unsigned")
endif()

check_type_size(uid_t UID_T)
if(NOT HAVE_UID_T)
	set(UID_T "int")
endif()


check_type_size("ssize_t" HAVE_SSIZE_T)

# todo:
#check_cxx_symbol_exists("std::wstring" "string" HAVE_STD_WSTRING)
set( HAVE_STD_WSTRING 1)
set( HAVE_STD_STRING_COMPARE 0)

# cmake najde, ale .configure nenajde...
#check_symbol_exists(poll "poll.h;sys/poll.h" HAVE_POLL)

check_library_exists(dl dlopen "" HAVE_DLOPEN)
check_library_exists(dl dlerror "" HAVE_DLERROR)


# cmake najde, ale .configure nenajde...
check_library_exists(m round "" HAVE_ROUND)

# cmake najde, ale .configure nenajde...
check_symbol_exists(flock "sys/file.h" HAVE_FLOCK)

check_symbol_exists(locale_t "locale.h" HAVE_LOCALE_T)
