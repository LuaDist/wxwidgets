
# <!-- ================================================================= -->
# <!--                            wxBase library                         -->
# <!-- ================================================================= -->

add_library(wx_base SHARED ${BASE_SRC} ${BASE_AND_GUI_SRC} )

set( files
    #redefinitions:
    src/common/datetime.cpp
    src/common/datetimefmt.cpp

    src/common/stream.cpp
    src/common/strconv.cpp
    src/common/stopwatch.cpp
    src/common/strvararg.cpp
    src/common/tarstrm.cpp
    src/common/time.cpp
    src/common/unichar.cpp
    src/common/ustring.cpp
)

foreach(file ${files})
  set_property( SOURCE ${file} PROPERTY COTIRE_EXCLUDED TRUE )
endforeach()

set_target_properties( wx_base PROPERTIES
    COMPILE_FLAGS -DWXMAKINGDLL_BASE
    COTIRE_ENABLE_PRECOMPILED_HEADER FALSE)

cotire(wx_base)


# <!-- ================================================================= -->
# <!--                             wxNet library                         -->
# <!-- ================================================================= -->


add_library(wx_net SHARED ${NET_SRC} )
cotire(wx_net)
target_link_libraries(wx_net_unity wx_base_unity)

set_target_properties( wx_net
    PROPERTIES COMPILE_FLAGS -DWXMAKINGDLL_NET )



# <!-- ================================================================= -->
# <!--                           Main GUI library                        -->
# <!-- ================================================================= -->

add_library(wx_core SHARED ${BASE_AND_GUI_SRC} ${CORE_SRC} )

set( files
    #redefinitions:
    src/gtk/window.cpp
    src/gtk/minifram.cpp
    src/generic/clrpickerg.cpp
)

foreach(file ${files})
  set_property( SOURCE ${file} PROPERTY COTIRE_EXCLUDED TRUE )
endforeach()


set_target_properties( wx_core PROPERTIES
    COMPILE_FLAGS "-DWXMAKINGDLL_CORE -DwxUSE_BASE=0"
    COTIRE_ENABLE_PRECOMPILED_HEADER FALSE)

cotire(wx_core)
target_link_libraries(wx_core_unity wx_base_unity)

