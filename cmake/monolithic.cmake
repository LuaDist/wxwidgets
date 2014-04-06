
set( MONOLIB_GUI_SR
    ${CORE_SRC} ${ADVANCED_SRC} ${MEDIA_SRC} ${HTML_SRC} ${WEBVIEW_SRC}
    ${QA_SRC} ${XRC_SRC} ${AUI_SRC} ${PROPGRID_SRC} ${RIBBON_SRC}
    ${RICHTEXT_SRC} ${STC_SRC}
)

set( MONOLIB_SRC
	${BASE_SRC} ${BASE_AND_GUI_SRC} ${NET_SRC} ${MONOLIB_GUI_SRC} ${XML_SRC}
)

# add_library(wx STATIC ${MONOLIB_SRC} ${MONOLIB_GUI_SR})

add_library(wx STATIC ${MONOLIB_SRC} ${MONOLIB_GUI_SR})


#  set( files
#  	#redefinitions:
# 	src/common/datetime.cpp
# 	src/common/datetimefmt.cpp
# 	src/common/fontpickercmn.cpp
# 	src/common/imagjpeg.cpp
# 	src/common/quantize.cpp
# 	src/common/stopwatch.cpp
# 	src/common/strvararg.cpp
# 	src/common/tarstrm.cpp
# 	src/common/time.cpp
# 	src/common/unichar.cpp
# 	src/generic/toolbkg.cpp
# 	src/generic/treebkg.cpp
# 	src/xml/xml.cpp
# 	src/common/unichar.cpp
# 	src/common/ustring.cpp
# 	src/common/wxcrt.cpp

# 	src/unix/stdpaths.cpp
# 	src/unix/utilsunx.cpp
# 	src/common/utilscmn.cpp
# 	src/unix/fontenum.cpp
# 	src/gtk/app.cpp
# 	src/gtk/window.cpp
# 	src/gtk/minifram.cpp
# 	src/gtk/toplevel.cpp
# 	src/generic/fontpickerg.cpp
# )

# foreach(file ${files})
# 	#set_source_files_properties( ${file} PROPERTIES COTIRE_EXCLUDED TRUE )
# 	set_property( SOURCE ${file} PROPERTY COTIRE_EXCLUDED TRUE )
# endforeach()


# cotire(wx)
