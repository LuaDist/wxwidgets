# Copyright (C) 2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( wxwidgets C CXX ) # Compiler check required
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( configure )

# 2DO: Optional component install, for now only monolithic is supported
# 2DO: Use file globs where apropriate to reduce the ridiculous filelists
# NOTE: We do not follow the recommended wxwidgets naming conventions as it conflicts with our conventions

# Avoid leaking memory issue with gcc/mingw.
# http://wiki.wxwidgets.org/Compiling_wxWidgets_with_MinGW
# http://old.nabble.com/MinGW-GCC-4.6.1-released-p32468533.html
if (HAVE_FNO_KEEP_INLINE_DLLEXPORT)
  set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-keep-inline-dllexport" )
endif ()

configure_file ( include/wx/msw/setup.h ${CMAKE_CURRENT_BINARY_DIR}/include/wx/setup.h )
configure_file ( include/wx/msw/genrcdefs.h ${CMAKE_CURRENT_BINARY_DIR}/include/wx/msw/rcdefs.h )

include_directories ( include ${CMAKE_CURRENT_BINARY_DIR}/include src/tiff src/jpeg src/png src/zlib src/regex src/expat/lib contrib/include contrib/src/stc/scintilla/include contrib/src/stc/scintilla/src )
add_definitions ( -DHAVE_W32API_H -D__WXMSW__ -D__WX__ -DNDEBUG -DwxUSE_GRAPHICS_CONTEXT=1 -DWXBUILDING -DwxUSE_BASE=1 -DSCI_LEXER -DLINK_LEXERS )

# wx_regex
set ( SRC_REGEX src/regex/regcomp.c src/regex/regexec.c src/regex/regerror.c src/regex/regfree.c )
add_library ( wx_regex STATIC ${SRC_REGEX} )

# wx_zlib
set ( SRC_ZLIB src/zlib/adler32.c src/zlib/compress.c src/zlib/crc32.c src/zlib/gzio.c src/zlib/uncompr.c src/zlib/deflate.c src/zlib/trees.c src/zlib/zutil.c src/zlib/inflate.c src/zlib/infback.c src/zlib/inftrees.c src/zlib/inffast.c ) 
add_library ( wx_zlib STATIC ${SRC_ZLIB} )

# wx_png
set ( SRC_PNG src/png/png.c src/png/pngerror.c src/png/pnggccrd.c src/png/pngget.c src/png/pngmem.c src/png/pngpread.c src/png/pngread.c src/png/pngrio.c src/png/pngrtran.c src/png/pngrutil.c src/png/pngset.c src/png/pngtrans.c src/png/pngvcrd.c src/png/pngwio.c src/png/pngwrite.c src/png/pngwtran.c src/png/pngwutil.c )
add_library ( wx_png STATIC ${SRC_PNG} )

# wx_jpeg
set ( SRC_JPEG src/jpeg/jcomapi.c src/jpeg/jutils.c src/jpeg/jerror.c src/jpeg/jmemmgr.c src/jpeg/jmemnobs.c src/jpeg/jcapimin.c src/jpeg/jcapistd.c src/jpeg/jctrans.c src/jpeg/jcparam.c src/jpeg/jdatadst.c src/jpeg/jcinit.c src/jpeg/jcmaster.c src/jpeg/jcmarker.c src/jpeg/jcmainct.c src/jpeg/jcprepct.c src/jpeg/jccoefct.c src/jpeg/jccolor.c src/jpeg/jcsample.c src/jpeg/jchuff.c src/jpeg/jcphuff.c src/jpeg/jcdctmgr.c src/jpeg/jfdctfst.c src/jpeg/jfdctflt.c src/jpeg/jfdctint.c src/jpeg/jdapimin.c src/jpeg/jdapistd.c src/jpeg/jdtrans.c src/jpeg/jdatasrc.c src/jpeg/jdmaster.c src/jpeg/jdinput.c src/jpeg/jdmarker.c src/jpeg/jdhuff.c src/jpeg/jdphuff.c src/jpeg/jdmainct.c src/jpeg/jdcoefct.c src/jpeg/jdpostct.c src/jpeg/jddctmgr.c src/jpeg/jidctfst.c src/jpeg/jidctflt.c src/jpeg/jidctint.c src/jpeg/jidctred.c src/jpeg/jdsample.c src/jpeg/jdcolor.c src/jpeg/jquant1.c src/jpeg/jquant2.c src/jpeg/jdmerge.c )
add_library ( wx_jpeg STATIC ${SRC_JPEG} )

# wx_tiff
set ( SRC_TIFF src/tiff/tif_win32.c src/tiff/tif_aux.c src/tiff/tif_close.c src/tiff/tif_codec.c src/tiff/tif_color.c src/tiff/tif_compress.c src/tiff/tif_dir.c src/tiff/tif_dirinfo.c src/tiff/tif_dirread.c src/tiff/tif_dirwrite.c src/tiff/tif_dumpmode.c src/tiff/tif_error.c src/tiff/tif_extension.c src/tiff/tif_fax3.c src/tiff/tif_fax3sm.c src/tiff/tif_getimage.c src/tiff/tif_jpeg.c src/tiff/tif_flush.c src/tiff/tif_lzw.c src/tiff/tif_luv.c src/tiff/tif_next.c src/tiff/tif_open.c src/tiff/tif_packbits.c src/tiff/tif_pixarlog.c src/tiff/tif_predict.c src/tiff/tif_print.c src/tiff/tif_read.c src/tiff/tif_swab.c src/tiff/tif_strip.c src/tiff/tif_thunder.c src/tiff/tif_tile.c src/tiff/tif_version.c src/tiff/tif_warning.c src/tiff/tif_write.c src/tiff/tif_zip.c )
add_library ( wx_tiff STATIC ${SRC_TIFF} )

# wx_expat
set ( STDC_HEADERS 1 )
set ( XML_CONTEXT_BYTES 1024 )
set ( XML_DTD 1 )
set ( XML_NS 1 )

configure_file( src/expat/expat_config.h.in ${CMAKE_CURRENT_BINARY_DIR}/include/expat_config.h )
set ( SRC_EXPAT src/expat/lib/xmlparse.c src/expat/lib/xmlrole.c src/expat/lib/xmltok.c )
add_library ( wx_expat STATIC ${SRC_EXPAT} )

# wx_common
set (SRC_COMMON  src/common/accesscmn.cpp src/common/anidecod.cpp src/common/animatecmn.cpp src/common/appbase.cpp src/common/appcmn.cpp src/common/arcall.cpp src/common/arcfind.cpp src/common/archive.cpp src/common/artprov.cpp src/common/artstd.cpp src/common/bmpbase.cpp src/common/bookctrl.cpp src/common/choiccmn.cpp src/common/clipcmn.cpp src/common/clntdata.cpp src/common/clrpickercmn.cpp src/common/cmdline.cpp src/common/cmdproc.cpp src/common/cmndata.cpp src/common/colourcmn.cpp src/common/combocmn.cpp src/common/config.cpp src/common/containr.cpp src/common/convauto.cpp src/common/cshelp.cpp src/common/ctrlcmn.cpp src/common/ctrlsub.cpp src/common/datacmn.cpp src/common/datavcmn.cpp src/common/datetime.cpp src/common/datstrm.cpp src/common/db.cpp src/common/dbgrid.cpp src/common/dbtable.cpp src/common/dcbase.cpp src/common/dcbufcmn.cpp src/common/dcgraph.cpp src/common/debugrpt.cpp src/common/dircmn.cpp src/common/dlgcmn.cpp src/common/dndcmn.cpp src/common/dobjcmn.cpp src/common/docmdi.cpp src/common/docview.cpp src/common/dpycmn.cpp src/common/dseldlg.cpp src/common/dummy.cpp src/common/dynarray.cpp src/common/dynlib.cpp src/common/dynload.cpp src/common/effects.cpp src/common/encconv.cpp src/common/extended.c src/common/event.cpp src/common/evtloopcmn.cpp src/common/fddlgcmn.cpp src/common/ffile.cpp src/common/file.cpp src/common/fileback.cpp src/common/fileconf.cpp src/common/filefn.cpp src/common/filename.cpp src/common/filepickercmn.cpp src/common/filesys.cpp src/common/filtall.cpp src/common/filtfind.cpp src/common/fldlgcmn.cpp src/common/fmapbase.cpp src/common/fontcmn.cpp src/common/fontenumcmn.cpp src/common/fontmap.cpp src/common/fontpickercmn.cpp src/common/framecmn.cpp src/common/fs_arc.cpp src/common/fs_filter.cpp src/common/fs_inet.cpp src/common/fs_mem.cpp src/common/ftp.cpp src/common/gaugecmn.cpp src/common/gbsizer.cpp src/common/gdicmn.cpp src/common/geometry.cpp src/common/gifdecod.cpp src/common/graphcmn.cpp src/common/hash.cpp src/common/hashmap.cpp src/common/helpbase.cpp src/common/http.cpp src/common/iconbndl.cpp src/common/imagall.cpp src/common/imagbmp.cpp src/common/image.cpp src/common/imagfill.cpp src/common/imaggif.cpp src/common/imagiff.cpp src/common/imagjpeg.cpp src/common/imagpcx.cpp src/common/imagpng.cpp src/common/imagpnm.cpp src/common/imagtga.cpp src/common/imagtiff.cpp src/common/imagxpm.cpp src/common/init.cpp src/common/intl.cpp src/common/ipcbase.cpp src/common/layout.cpp src/common/lboxcmn.cpp src/common/list.cpp src/common/listctrlcmn.cpp src/common/log.cpp src/common/longlong.cpp src/common/matrix.cpp src/common/mediactrlcmn.cpp src/common/memory.cpp src/common/menucmn.cpp src/common/mimecmn.cpp src/common/module.cpp src/common/msgout.cpp src/common/mstream.cpp src/common/nbkbase.cpp src/common/object.cpp src/common/overlaycmn.cpp src/common/paper.cpp src/common/pickerbase.cpp src/common/platinfo.cpp src/common/popupcmn.cpp src/common/powercmn.cpp src/common/prntbase.cpp src/common/process.cpp src/common/protocol.cpp src/common/quantize.cpp src/common/radiocmn.cpp src/common/regex.cpp src/common/rendcmn.cpp src/common/rgncmn.cpp src/common/sckaddr.cpp src/common/sckfile.cpp src/common/sckipc.cpp src/common/sckstrm.cpp src/common/settcmn.cpp src/common/sizer.cpp src/common/socket.cpp src/common/srchcmn.cpp src/common/sstream.cpp src/common/statbar.cpp src/common/stdpbase.cpp src/common/stockitem.cpp src/common/stopwatch.cpp src/common/strconv.cpp src/common/stream.cpp src/common/string.cpp src/common/sysopt.cpp src/common/tarstrm.cpp src/common/taskbarcmn.cpp src/common/tbarbase.cpp src/common/textbuf.cpp src/common/textcmn.cpp src/common/textfile.cpp src/common/timercmn.cpp src/common/tokenzr.cpp src/common/toplvcmn.cpp src/common/treebase.cpp src/common/txtstrm.cpp src/common/uri.cpp src/common/url.cpp src/common/utilscmn.cpp src/common/valgen.cpp src/common/validate.cpp src/common/valtext.cpp src/common/variant.cpp src/common/wfstream.cpp src/common/wincmn.cpp src/common/wxchar.cpp src/common/xpmdecod.cpp src/common/xti.cpp src/common/xtistrm.cpp src/common/xtixml.cpp src/common/zipstrm.cpp src/common/zstream.cpp )

# wx_msw
set ( SRC_MSW  src/msw/aboutdlg.cpp src/msw/accel.cpp src/msw/app.cpp src/msw/basemsw.cpp src/msw/bitmap.cpp src/msw/bmpbuttn.cpp src/msw/brush.cpp src/msw/button.cpp src/msw/caret.cpp src/msw/checkbox.cpp src/msw/checklst.cpp src/msw/choice.cpp src/msw/clipbrd.cpp src/msw/colordlg.cpp src/msw/colour.cpp src/msw/combo.cpp src/msw/combobox.cpp src/msw/control.cpp src/msw/crashrpt.cpp src/msw/cursor.cpp src/msw/data.cpp src/msw/datectrl.cpp src/msw/dc.cpp src/msw/dcclient.cpp src/msw/dcmemory.cpp src/msw/dcprint.cpp src/msw/dcscreen.cpp src/msw/dde.cpp src/msw/debughlp.cpp src/msw/dialog.cpp src/msw/dialup.cpp src/msw/dib.cpp src/msw/dir.cpp src/msw/dirdlg.cpp src/msw/display.cpp src/msw/dlmsw.cpp src/msw/dragimag.cpp src/msw/enhmeta.cpp src/msw/evtloop.cpp src/msw/fdrepdlg.cpp src/msw/filedlg.cpp src/msw/font.cpp src/msw/fontdlg.cpp src/msw/fontenum.cpp src/msw/fontutil.cpp src/msw/frame.cpp src/msw/gauge95.cpp src/msw/gdiimage.cpp src/msw/gdiobj.cpp src/msw/graphics.cpp src/msw/gsocket.cpp src/msw/gsockmsw.cpp src/msw/helpbest.cpp src/msw/helpchm.cpp src/msw/helpwin.cpp src/msw/icon.cpp src/msw/imaglist.cpp src/msw/iniconf.cpp src/msw/joystick.cpp src/msw/listbox.cpp src/msw/listctrl.cpp src/msw/main.cpp src/msw/mdi.cpp src/msw/mediactrl_am.cpp src/msw/mediactrl_qt.cpp src/msw/mediactrl_wmp10.cpp src/msw/menu.cpp src/msw/menuitem.cpp src/msw/metafile.cpp src/msw/mimetype.cpp src/msw/minifram.cpp src/msw/msgdlg.cpp src/msw/mslu.cpp src/msw/nativdlg.cpp src/msw/notebook.cpp src/msw/ole/access.cpp src/msw/ole/activex.cpp src/msw/ole/automtn.cpp src/msw/ole/dataobj.cpp src/msw/ole/dropsrc.cpp src/msw/ole/droptgt.cpp src/msw/ole/oleutils.cpp src/msw/ole/uuid.cpp src/msw/ownerdrw.cpp src/msw/palette.cpp src/msw/pen.cpp src/msw/popupwin.cpp src/msw/power.cpp src/msw/printdlg.cpp src/msw/printwin.cpp src/msw/radiobox.cpp src/msw/radiobut.cpp src/msw/regconf.cpp src/msw/region.cpp src/msw/registry.cpp src/msw/renderer.cpp src/msw/scrolbar.cpp src/msw/settings.cpp src/msw/slider95.cpp src/msw/snglinst.cpp src/msw/sound.cpp src/msw/spinbutt.cpp src/msw/spinctrl.cpp src/msw/stackwalk.cpp src/msw/statbmp.cpp src/msw/statbox.cpp src/msw/statbr95.cpp src/msw/statline.cpp src/msw/stattext.cpp src/msw/stdpaths.cpp src/msw/tabctrl.cpp src/msw/taskbar.cpp src/msw/tbar95.cpp src/msw/textctrl.cpp src/msw/tglbtn.cpp src/msw/thread.cpp src/msw/timer.cpp src/msw/tooltip.cpp src/msw/toplevel.cpp src/msw/treectrl.cpp src/msw/urlmsw.cpp src/msw/utils.cpp src/msw/utilsexc.cpp src/msw/utilsgui.cpp src/msw/uxtheme.cpp src/msw/volume.cpp src/msw/window.cpp src/msw/ole/dataobj.cpp src/msw/ole/dropsrc.cpp src/msw/ole/droptgt.cpp src/msw/ole/oleutils.cpp src/msw/ole/automtn.cpp src/msw/ole/uuid.cpp src/msw/ole/access.cpp src/msw/ole/activex.cpp src/msw/ole/activex.cpp src/msw/ole/activex.cpp )

# wx_generic
set ( SRC_GENERIC  src/generic/aboutdlgg.cpp src/generic/animateg.cpp src/generic/bmpcboxg.cpp src/generic/busyinfo.cpp src/generic/buttonbar.cpp src/generic/calctrl.cpp src/generic/choicbkg.cpp src/generic/choicdgg.cpp src/generic/clrpickerg.cpp src/generic/collpaneg.cpp src/generic/combog.cpp src/generic/datavgen.cpp src/generic/datectlg.cpp src/generic/dbgrptg.cpp src/generic/dcpsg.cpp src/generic/dirctrlg.cpp src/generic/dragimgg.cpp src/generic/filepickerg.cpp src/generic/fontpickerg.cpp src/generic/graphicc.cpp src/generic/grid.cpp src/generic/gridctrl.cpp src/generic/gridsel.cpp src/generic/helpext.cpp src/generic/htmllbox.cpp src/generic/hyperlink.cpp src/generic/laywin.cpp src/generic/listbkg.cpp src/generic/logg.cpp src/generic/numdlgg.cpp src/generic/odcombo.cpp src/generic/panelg.cpp src/generic/printps.cpp src/generic/prntdlgg.cpp src/generic/progdlgg.cpp src/generic/propdlg.cpp src/generic/renderg.cpp src/generic/sashwin.cpp src/generic/scrlwing.cpp src/generic/selstore.cpp src/generic/spinctlg.cpp src/generic/splash.cpp src/generic/splitter.cpp src/generic/srchctlg.cpp src/generic/statusbr.cpp src/generic/textdlgg.cpp src/generic/tipdlg.cpp src/generic/tipwin.cpp src/generic/toolbkg.cpp src/generic/treebkg.cpp src/generic/treectlg.cpp src/generic/vlbox.cpp src/generic/vscroll.cpp src/generic/wizard.cpp )

# wx_html
set ( SRC_HTML src/html/helpctrl.cpp src/html/helpdata.cpp src/html/helpdlg.cpp src/html/helpfrm.cpp src/html/helpwnd.cpp src/html/htmlcell.cpp src/html/htmlfilt.cpp src/html/htmlpars.cpp src/html/htmltag.cpp src/html/htmlwin.cpp src/html/htmprint.cpp src/html/m_dflist.cpp src/html/m_fonts.cpp src/html/m_hline.cpp src/html/m_image.cpp src/html/m_layout.cpp src/html/m_links.cpp src/html/m_list.cpp src/html/m_pre.cpp src/html/m_style.cpp src/html/m_tables.cpp src/html/winpars.cpp )

# wx_xrc
set ( SRC_XRC src/xrc/xh_animatctrl.cpp src/xrc/xh_bmp.cpp src/xrc/xh_bmpbt.cpp src/xrc/xh_bmpcbox.cpp src/xrc/xh_bttn.cpp src/xrc/xh_cald.cpp src/xrc/xh_chckb.cpp src/xrc/xh_chckl.cpp src/xrc/xh_choic.cpp src/xrc/xh_choicbk.cpp src/xrc/xh_clrpicker.cpp src/xrc/xh_collpane.cpp src/xrc/xh_combo.cpp src/xrc/xh_datectrl.cpp src/xrc/xh_dirpicker.cpp src/xrc/xh_dlg.cpp src/xrc/xh_filepicker.cpp src/xrc/xh_fontpicker.cpp src/xrc/xh_frame.cpp src/xrc/xh_gauge.cpp src/xrc/xh_gdctl.cpp src/xrc/xh_grid.cpp src/xrc/xh_html.cpp src/xrc/xh_htmllbox.cpp src/xrc/xh_hyperlink.cpp src/xrc/xh_listb.cpp src/xrc/xh_listbk.cpp src/xrc/xh_listc.cpp src/xrc/xh_mdi.cpp src/xrc/xh_menu.cpp src/xrc/xh_notbk.cpp src/xrc/xh_odcombo.cpp src/xrc/xh_panel.cpp src/xrc/xh_propdlg.cpp src/xrc/xh_radbt.cpp src/xrc/xh_radbx.cpp src/xrc/xh_scrol.cpp src/xrc/xh_scwin.cpp src/xrc/xh_sizer.cpp src/xrc/xh_slidr.cpp src/xrc/xh_spin.cpp src/xrc/xh_split.cpp src/xrc/xh_statbar.cpp src/xrc/xh_stbmp.cpp src/xrc/xh_stbox.cpp src/xrc/xh_stlin.cpp src/xrc/xh_sttxt.cpp src/xrc/xh_text.cpp src/xrc/xh_tglbtn.cpp src/xrc/xh_toolb.cpp src/xrc/xh_tree.cpp src/xrc/xh_treebk.cpp src/xrc/xh_unkwn.cpp src/xrc/xh_wizrd.cpp src/xrc/xmlres.cpp src/xrc/xmlrsall.cpp )

# wx_aui
set ( SRC_AUI src/aui/auibar.cpp src/aui/auibook.cpp src/aui/dockart.cpp src/aui/floatpane.cpp src/aui/framemanager.cpp src/aui/tabmdi.cpp )

# wx_richtext
set ( SRC_RICHTEXT src/richtext/richtextbuffer.cpp src/richtext/richtextctrl.cpp src/richtext/richtextformatdlg.cpp src/richtext/richtexthtml.cpp src/richtext/richtextprint.cpp src/richtext/richtextstyledlg.cpp src/richtext/richtextstyles.cpp src/richtext/richtextsymboldlg.cpp src/richtext/richtextxml.cpp )

# wx_xml
set ( SRC_XML src/xml/xml.cpp )

# wx (monolithic build)
if ( WIN32 )
	set ( OS_LIBS gdiplus user32 gdi32 comdlg32 winspool winmm shell32 comctl32 ole32 oleaut32 uuid rpcrt4 advapi32 wsock32 odbc32 )
endif ()
set ( SRC_MONOLITHIC ${SRC_COMMON} ${SRC_MSW} ${SRC_GENERIC} ${SRC_HTML} ${SRC_XRC} ${SRC_AUI} ${SRC_RICHTEXT} ${SRC_XML} )
add_library ( wx ${SRC_MONOLITHIC} )
set_target_properties ( wx PROPERTIES COMPILE_DEFINITIONS "WXMAKINGDLL" )
target_link_libraries ( wx wx_tiff wx_jpeg wx_png wx_zlib wx_regex wx_expat ${OS_LIBS} )
if (MSVC)    # avoid LNK1210 "Exceeded internal ILK size limit" (MSVC2012, debug build)
  set_property (TARGET wx APPEND_STRING PROPERTY LINK_FLAGS_DEBUG " /INCREMENTAL:NO")
endif ()

install_library ( wx )

# wx_gl
find_package ( OpenGL )
if ( OPENGL_FOUND )
	include_directories ( ${OPENGL_INCLUDE_DIR} )
	set ( SRC_GL src/common/dummy.cpp src/msw/glcanvas.cpp )
	add_library ( wx_gl ${SRC_GL} )
	set_target_properties ( wx_gl PROPERTIES COMPILE_DEFINITIONS "WXMAKINGDLL_STC;WXUSINGDLL" )
	target_link_libraries ( wx_gl wx ${OPENGL_LIBRARIES} )
	install_library ( wx_gl )
endif ()

# wx_stc
set ( SRC_STC_SCINTILLA contrib/src/stc/scintilla/src/AutoComplete.cxx contrib/src/stc/scintilla/src/CallTip.cxx contrib/src/stc/scintilla/src/CellBuffer.cxx contrib/src/stc/scintilla/src/CharClassify.cxx contrib/src/stc/scintilla/src/ContractionState.cxx contrib/src/stc/scintilla/src/Document.cxx contrib/src/stc/scintilla/src/DocumentAccessor.cxx contrib/src/stc/scintilla/src/Editor.cxx contrib/src/stc/scintilla/src/ExternalLexer.cxx contrib/src/stc/scintilla/src/Indicator.cxx contrib/src/stc/scintilla/src/KeyMap.cxx contrib/src/stc/scintilla/src/KeyWords.cxx contrib/src/stc/scintilla/src/LexAda.cxx contrib/src/stc/scintilla/src/LexAPDL.cxx contrib/src/stc/scintilla/src/LexAsm.cxx contrib/src/stc/scintilla/src/LexAsn1.cxx contrib/src/stc/scintilla/src/LexAU3.cxx contrib/src/stc/scintilla/src/LexAVE.cxx contrib/src/stc/scintilla/src/LexBaan.cxx contrib/src/stc/scintilla/src/LexBash.cxx contrib/src/stc/scintilla/src/LexBasic.cxx contrib/src/stc/scintilla/src/LexBullant.cxx contrib/src/stc/scintilla/src/LexCaml.cxx contrib/src/stc/scintilla/src/LexCLW.cxx contrib/src/stc/scintilla/src/LexConf.cxx contrib/src/stc/scintilla/src/LexCPP.cxx contrib/src/stc/scintilla/src/LexCrontab.cxx contrib/src/stc/scintilla/src/LexCsound.cxx contrib/src/stc/scintilla/src/LexCSS.cxx contrib/src/stc/scintilla/src/LexEiffel.cxx contrib/src/stc/scintilla/src/LexErlang.cxx contrib/src/stc/scintilla/src/LexEScript.cxx contrib/src/stc/scintilla/src/LexFlagship.cxx contrib/src/stc/scintilla/src/LexForth.cxx contrib/src/stc/scintilla/src/LexFortran.cxx contrib/src/stc/scintilla/src/LexGui4Cli.cxx contrib/src/stc/scintilla/src/LexHaskell.cxx contrib/src/stc/scintilla/src/LexHTML.cxx contrib/src/stc/scintilla/src/LexInno.cxx contrib/src/stc/scintilla/src/LexKix.cxx contrib/src/stc/scintilla/src/LexLisp.cxx contrib/src/stc/scintilla/src/LexLout.cxx contrib/src/stc/scintilla/src/LexLua.cxx contrib/src/stc/scintilla/src/LexMatlab.cxx contrib/src/stc/scintilla/src/LexMetapost.cxx contrib/src/stc/scintilla/src/LexMMIXAL.cxx contrib/src/stc/scintilla/src/LexMPT.cxx contrib/src/stc/scintilla/src/LexMSSQL.cxx contrib/src/stc/scintilla/src/LexNsis.cxx contrib/src/stc/scintilla/src/LexOpal.cxx contrib/src/stc/scintilla/src/LexOthers.cxx contrib/src/stc/scintilla/src/LexPascal.cxx contrib/src/stc/scintilla/src/LexPB.cxx contrib/src/stc/scintilla/src/LexPerl.cxx contrib/src/stc/scintilla/src/LexPOV.cxx contrib/src/stc/scintilla/src/LexPS.cxx contrib/src/stc/scintilla/src/LexPython.cxx contrib/src/stc/scintilla/src/LexRebol.cxx contrib/src/stc/scintilla/src/LexRuby.cxx contrib/src/stc/scintilla/src/LexScriptol.cxx contrib/src/stc/scintilla/src/LexSmalltalk.cxx contrib/src/stc/scintilla/src/LexSpecman.cxx contrib/src/stc/scintilla/src/LexSpice.cxx contrib/src/stc/scintilla/src/LexSQL.cxx contrib/src/stc/scintilla/src/LexTADS3.cxx contrib/src/stc/scintilla/src/LexTCL.cxx contrib/src/stc/scintilla/src/LexTeX.cxx contrib/src/stc/scintilla/src/LexVB.cxx contrib/src/stc/scintilla/src/LexVerilog.cxx contrib/src/stc/scintilla/src/LexVHDL.cxx contrib/src/stc/scintilla/src/LexYAML.cxx contrib/src/stc/scintilla/src/LineMarker.cxx contrib/src/stc/scintilla/src/PropSet.cxx contrib/src/stc/scintilla/src/RESearch.cxx contrib/src/stc/scintilla/src/ScintillaBase.cxx contrib/src/stc/scintilla/src/Style.cxx contrib/src/stc/scintilla/src/StyleContext.cxx contrib/src/stc/scintilla/src/UniConversion.cxx contrib/src/stc/scintilla/src/ViewStyle.cxx contrib/src/stc/scintilla/src/WindowAccessor.cxx contrib/src/stc/scintilla/src/XPM.cxx )

set ( SRC_STC contrib/src/stc/PlatWX.cpp contrib/src/stc/ScintillaWX.cpp contrib/src/stc/stc.cpp )

add_library ( wx_stc ${SRC_STC} ${SRC_STC_SCINTILLA} )
set_target_properties ( wx_stc PROPERTIES COMPILE_DEFINITIONS "WXMAKINGDLL_STC;WXUSINGDLL" )
target_link_libraries ( wx_stc wx )
install_library ( wx_stc )

# Common files to install
install_doc ( docs/html/ )
install ( DIRECTORY include/wx DESTINATION ${INSTALL_INC} COMPONENT Header )
install_header ( ${CMAKE_CURRENT_BINARY_DIR}/include/wx/setup.h INTO wx )
install_header ( ${CMAKE_CURRENT_BINARY_DIR}/include/wx/msw/rcdefs.h INTO wx/msw )
install_header ( contrib/include/wx/stc/stc.h INTO wx/stc )
install_data ( docs/licence.txt docs/readme.txt )
