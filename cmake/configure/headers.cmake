set ( headers
X11/XKBlib.h
X11/extensions/xf86vmode.h
fnmatch.h
iostream
linux/joystick.h
sched.h
unistd.h
fcntl.h
wchar.h
wcstr.h
wctype.h
langinfo.h
esd.h
sys/soundcard.h
sys/select.h
tr1/type_traits
type_traits

)

foreach(file ${headers})
	string(TOUPPER ${file} A )
	string(REPLACE "/" "_" B  ${A} )
	string(REPLACE "." "_" C  ${B} )
	CHECK_INCLUDE_FILE(${file} HAVE_${C})
endforeach(file)
