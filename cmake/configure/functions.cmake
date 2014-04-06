set ( functions
#poll
#dlopen
gettimeofday
fsync
ftime
#round
localtime
nanosleep
sched_yield
PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP
pthread_cancel
pthread_attr_setstacksize
sigaction
sigemptyset
shl_load

strptime
strtoull
strtoll
timegm
vsnprintf
usleep
wcslen


gethostbynam
getaddrinfo
gethostname
gmtime_r
inet_addr
inet_aton
localtime_r
mktemp
mkstemp
nanosleep
putenv
readdir_r
setenv
shl_load
strtok_r
thr_setconcurrency
uname
unsetenv

fnmatch
wcsrtombs
wputc
wputchar
putws
fputws
wprintf
swprintf
vswprintf
_vsnwprintf
fseeko
ftello
fdopen
sysconf
getpwuid_r
getgrgid_r


pthread_mutexattr_settype
statfs
#statvfs
vsscanf
wcscasecmp
wcsncasecmp
wcsdup
wcsftime
strnlen
wcsnlen

vswscanf
setpriority
)

foreach(function ${functions})
	string(TOUPPER ${function} function_UPPER)
	CHECK_FUNCTION_EXISTS(${function} HAVE_${function_UPPER})
endforeach(function)
