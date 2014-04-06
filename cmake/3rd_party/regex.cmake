
include_directories(
	src/regex
)

#~         <define>__WX$(TOOLKIT)__</define>
#~         <define>$(WXUNIV_DEFINE)</define>
#~         <define>$(UNICODE_DEFINE)</define>


add_library(regex STATIC
            src/regex/regcomp.c
            src/regex/regexec.c
            src/regex/regerror.c
            src/regex/regfree.c
)
