cflags{
	'-D HAVE_CONFIG_H',
	'-D GDK_COMPILATION',
	'-D GTK_COMPILATION',
	'-D GTK_PRINT_BACKEND_ENABLE_UNSUPPORTED',
	'-D GDK_WINDOWING_WAYLAND',
	'-D _GNU_SOURCE',
	'-D GETTEXT_PACKAGE="gtk30"',
	'-D GLIB_DISABLE_DEPRECATION_WARNINGS',
	'-I $dir',
	'-I $srcdir',
	'-I $outdir/gdk',
	'-I $outdir/gdk/wayland',
	'-I $srcdir/gdk',
	'-I $outdir/gtk',
	'-I $srcdir/gtk',
	'-I $outdir',
	'-I $outdir/include/gtk-3.0',
	'-I $builddir/pkg/glib/include/glib-2.0',
	'-I $builddir/pkg/glib/include/glib-2.0/glib',
	'-I $builddir/pkg/glib/include/glib-2.0/gobject',
	'-isystem $builddir/pkg/glib/include/glib-2.0/gobject-internal',
	'-I $builddir/pkg/gio/include/glib-2.0',
	'-I $builddir/pkg/gio/include/glib-2.0/gio',
	'-I $builddir/pkg/gmodule/include/glib-2.0',
	'-I $builddir/pkg/pango/include/pango-1.0',
	'-I $builddir/pkg/gdk-pixbuf/include/gdk-pixbuf-2.0',
	'-isystem $builddir/pkg/cairo/include',
	'-isystem $builddir/pkg/freetype/include',
	'-isystem $builddir/pkg/harfbuzz/include',
	'-isystem $builddir/pkg/fribidi/include',
	'-isystem $builddir/pkg/atk/include/atk-1.0',
	'-isystem $builddir/pkg/fontconfig/include',
	'-isystem $builddir/pkg/wayland/include',
	'-isystem $builddir/pkg/libepoxy/include',
	'-isystem $builddir/pkg/libxkbcommon/include',
	'-isystem $builddir/pkg/linux-headers/include',
	'-include $dir/logdomain.h',
	'-include $dir/config.h',
	'-Wno-error=int-conversion',
	'-Wno-error=incompatible-pointer-types',
	'-Wno-error=deprecated-declarations',
	'-Wno-error=implicit-function-declaration',
	'-Wno-error=unused-variable',
	'-Wno-error=unused-function',
}

build('copy', '$outdir/gdk/gdkconfig.h', '$dir/gdkconfig.h')
build('copy', '$outdir/gdk/gdkenumtypes.h', '$dir/gdkenumtypes.h')
build('copy', '$outdir/gdk/gdkenumtypes.c', '$dir/gdkenumtypes.c')
build('copy', '$outdir/gdk/gdkversionmacros.h', '$dir/gdkversionmacros.h')
build('copy', '$outdir/gtk/gtkversion.h', '$dir/gtkversion.h')
build('copy', '$outdir/gtk/gtktypebuiltins.h', '$dir/gtktypebuiltins.h')
build('copy', '$outdir/gtk/gtkprivatetypebuiltins.h', '$dir/gtkprivatetypebuiltins.h')
build('copy', '$outdir/gtk/gtkresources.h', '$dir/gtkresources.h')
build('copy', '$outdir/gdk/gdkresources.h', '$dir/gtkresources.h')
build('copy', '$outdir/gdk/gdkdbusgenerated.h', '$dir/gtkdbusgenerated.h')
build('copy', '$outdir/gtk/gtktypefuncs.inc', '$dir/gtktypefuncs.inc')
build('copy', '$outdir/gtk/gtkdbusgenerated.h', '$dir/gtkdbusgenerated.h')

pkg.hdrs = {
	copy('$outdir/include/gtk-3.0/gdk', '$srcdir/gdk', paths([[
		gdk-autocleanup.h gdk.h gdkapplaunchcontext.h gdkcairo.h
		gdkconstructor.h gdkcursor.h gdkdevice.h gdkdevicemanager.h
		gdkdevicepad.h gdkdevicetool.h gdkdisplay.h gdkdisplaymanager.h
		gdkdnd.h gdkdrawingcontext.h gdkevents.h gdkframeclock.h
		gdkframeclockidle.h gdkframetimings.h gdkglcontext.h gdkinternals.h
		gdkintl.h gdkkeys.h gdkkeysyms-compat.h gdkkeysyms.h
		gdkmain.h gdkmonitor.h gdkpango.h gdkpixbuf.h
		gdkproperty.h gdkrectangle.h gdkrgba.h gdkscreen.h
		gdkseat.h gdkselection.h gdktestutils.h gdkthreads.h
		gdktypes.h gdkvisual.h gdkwindow.h gdkwindowimpl.h
		gdkx.h keyname-table.h
	]])),
	copy('$outdir/include/gtk-3.0/gtk', '$srcdir/gtk', paths([[
		gtk-a11y.h gtk-autocleanups.h gtk.h gtkaboutdialog.h
		gtkaccelgroup.h gtkaccellabel.h gtkaccelmap.h gtkaccessible.h
		gtkactionable.h gtkactionbar.h gtkactionhelper.h gtkactionmuxer.h
		gtkactionobservable.h gtkactionobserver.h gtkadjustment.h gtkappchooser.h
		gtkappchooserbutton.h gtkappchooserdialog.h gtkappchooserwidget.h gtkapplication.h
		gtkapplicationwindow.h gtkaspectframe.h gtkassistant.h gtkbbox.h
		gtkbin.h gtkbindings.h gtkbookmarksmanager.h gtkborder.h
		gtkbox.h gtkbuildable.h gtkbuilder.h gtkbutton.h
		gtkcalendar.h gtkcellarea.h gtkcellareabox.h gtkcellareacontext.h
		gtkcelleditable.h gtkcelllayout.h gtkcellrenderer.h gtkcellrendereraccel.h
		gtkcellrenderercombo.h gtkcellrendererpixbuf.h gtkcellrendererprogress.h gtkcellrendererspin.h
		gtkcellrendererspinner.h gtkcellrenderertext.h gtkcellrenderertoggle.h gtkcellview.h
		gtkcheckbutton.h gtkcheckmenuitem.h gtkclipboard.h gtkcolorbutton.h
		gtkcolorchooser.h gtkcolorchooserdialog.h gtkcolorchooserwidget.h gtkcolorutils.h
		gtkcombobox.h gtkcomboboxtext.h gtkcomposetable.h gtkcontainer.h
		gtkcssprovider.h gtkcsssection.h gtkcustompaperunixdialog.h gtkdebug.h
		gtkdialog.h gtkdnd.h gtkdragdest.h gtkdragsource.h
		gtkdrawingarea.h gtkeditable.h gtkemojichooser.h gtkemojicompletion.h
		gtkentry.h gtkentrybuffer.h gtkentrycompletion.h gtkenums.h
		gtkeventbox.h gtkeventcontroller.h gtkeventcontrollerkey.h gtkeventcontrollermotion.h
		gtkeventcontrollerscroll.h gtkexpander.h gtkfilechooser.h gtkfilechooserbutton.h
		gtkfilechooserdialog.h gtkfilechooserembed.h gtkfilechooserentry.h gtkfilechoosernative.h
		gtkfilechooserutils.h gtkfilechooserwidget.h gtkfilefilter.h gtkfilesystem.h
		gtkfilesystemmodel.h gtkfixed.h gtkflowbox.h gtkfontbutton.h
		gtkfontchooser.h gtkfontchooserdialog.h gtkfontchooserutils.h gtkfontchooserwidget.h
		gtkframe.h gtkgesture.h gtkgesturedrag.h gtkgesturelongpress.h
		gtkgesturemultipress.h gtkgesturepan.h gtkgesturerotate.h gtkgesturesingle.h
		gtkgesturestylus.h gtkgestureswipe.h gtkgesturezoom.h gtkglarea.h
		gtkgrid.h gtkheaderbar.h gtkiconcache.h gtkiconcachevalidator.h
		gtkicontheme.h gtkiconview.h gtkimage.h gtkimcontext.h
		gtkimcontextinfo.h gtkimcontextsimple.h gtkimcontextsimpleseqs.h gtkimmodule.h
		gtkimmulticontext.h gtkinfobar.h gtkintl.h gtkinvisible.h
		gtkkeyhash.h gtkkineticscrolling.h gtklabel.h gtklayout.h
		gtklevelbar.h gtklinkbutton.h gtklistbox.h gtkliststore.h
		gtklockbutton.h gtkmain.h gtkmenu.h gtkmenubar.h
		gtkmenubutton.h gtkmenuitem.h gtkmenusectionbox.h gtkmenushell.h
		gtkmenutoolbutton.h gtkmenutracker.h gtkmenutrackeritem.h gtkmessagedialog.h
		gtkmnemonichash.h gtkmodelbutton.h gtkmodelmenuitem.h gtkmodifierstyle.h
		gtkmodules.h gtkmountoperation.h gtknativedialog.h gtknotebook.h
		gtkoffscreenwindow.h gtkorientable.h gtkoverlay.h gtkpadcontroller.h
		gtkpagesetup.h gtkpagesetupunixdialog.h gtkpaned.h gtkpango.h
		gtkpapersize.h gtkpathbar.h gtkplacessidebar.h gtkplug.h
		gtkpopover.h gtkpopovermenu.h gtkprint-win32.h gtkprintbackend.h
		gtkprintcontext.h gtkprinter.h gtkprinteroption.h gtkprinteroptionset.h
		gtkprinteroptionwidget.h gtkprintjob.h gtkprintoperation-portal.h gtkprintoperation.h
		gtkprintoperationpreview.h gtkprintsettings.h gtkprintunixdialog.h gtkprintutils.h
		gtkprogressbar.h gtkquartz.h gtkquery.h gtkradiobutton.h
		gtkradiomenuitem.h gtkradiotoolbutton.h gtkrange.h gtkrbtree.h
		gtkrecentchooser.h gtkrecentchooserdefault.h gtkrecentchooserdialog.h gtkrecentchoosermenu.h
		gtkrecentchooserutils.h gtkrecentchooserwidget.h gtkrecentfilter.h gtkrecentmanager.h
		gtkrender.h gtkrevealer.h gtkscale.h gtkscalebutton.h
		gtkscrollable.h gtkscrollbar.h gtkscrolledwindow.h gtksearchbar.h
		gtksearchengine.h gtksearchenginemodel.h gtksearchenginequartz.h gtksearchenginesimple.h
		gtksearchenginetracker.h gtksearchenginetracker3.h gtksearchentry.h gtkselection.h
		gtkseparator.h gtkseparatormenuitem.h gtkseparatortoolitem.h gtksettings.h
		gtkshortcutlabel.h gtkshortcutsgroup.h gtkshortcutssection.h gtkshortcutsshortcut.h
		gtkshortcutswindow.h gtkshow.h gtksizegroup.h gtksizerequest.h
		gtksocket.h gtkspinbutton.h gtkspinner.h gtkstack.h
		gtkstacksidebar.h gtkstackswitcher.h gtkstatusbar.h gtkstylecontext.h
		gtkstyleprovider.h gtkswitch.h gtktestutils.h gtktextattributes.h
		gtktextbtree.h gtktextbuffer.h gtktextbufferrichtext.h gtktextbufferserialize.h
		gtktextchild.h gtktextdisplay.h gtktextiter.h gtktextlayout.h
		gtktextmark.h gtktextsegment.h gtktexttag.h gtktexttagtable.h
		gtktexttypes.h gtktextutil.h gtktextview.h gtktogglebutton.h
		gtktoggletoolbutton.h gtktoolbar.h gtktoolbutton.h gtktoolitem.h
		gtktoolitemgroup.h gtktoolpalette.h gtktoolshell.h gtktooltip.h
		gtktrashmonitor.h gtktreedatalist.h gtktreednd.h gtktreemenu.h
		gtktreemodel.h gtktreemodelfilter.h gtktreemodelsort.h gtktreeselection.h
		gtktreesortable.h gtktreestore.h gtktreeview.h gtktreeviewcolumn.h
		gtktypes.h gtkunixprint-autocleanups.h gtkunixprint.h gtkviewport.h
		gtkvolumebutton.h gtkwidget.h gtkwidgetpath.h gtkwin32embed.h
		gtkwin32embedwidget.h gtkwindow.h gtkwindowgroup.h gtkx-autocleanups.h
		gtkx.h gtkxembed.h language-names.h open-type-layout.h
		script-names.h xembed.h
	]])),
	copy('$outdir/include/gtk-3.0/gdk', '$dir', {'gdkenumtypes.h'}),
	copy('$outdir/include/gtk-3.0/gdk/deprecated', '$srcdir/gdk/deprecated', {'gdkcolor.h'}),
	copy('$outdir/include/gtk-3.0/gtk', '$dir', {'gtkversion.h'}),
	copy('$outdir/include/gtk-3.0/gtk/deprecated', '$srcdir/gtk/deprecated', paths([[
		gtkactivatable.h gtkaction.h gtkactiongroup.h gtkalignment.h gtkarrow.h gtkcolorsel.h
		gtkcolorseldialog.h gtkfontsel.h gtkgradient.h gtkhandlebox.h gtkhbbox.h gtkhbox.h
		gtkhpaned.h gtkhscale.h gtkhscrollbar.h gtkhseparator.h gtkhsv.h gtkiconfactory.h
		gtkimagemenuitem.h gtkmisc.h gtknumerableicon.h gtkradioaction.h gtkrc.h gtkrecentaction.h
		gtkstatusicon.h gtkstock.h gtkstyle.h gtkstyleproperties.h gtksymboliccolor.h gtktable.h
		gtktearoffmenuitem.h gtkthemingengine.h gtktoggleaction.h gtkuimanager.h gtkvbbox.h gtkvbox.h
		gtkvscale.h gtkvscrollbar.h gtkvseparator.h gtkvpaned.h
	]])),
	copy('$outdir/include/gtk-3.0/gtk/a11y', '$srcdir/gtk/a11y', paths([[
		gtk-a11y-autocleanups.h gtkarrowaccessible.h gtkbooleancellaccessible.h gtkbuttonaccessible.h gtkcellaccessible.h gtkcellaccessibleparent.h
		gtkcheckmenuitemaccessible.h gtkcomboboxaccessible.h gtkcontaineraccessible.h gtkcontainercellaccessible.h gtkentryaccessible.h gtkexpanderaccessible.h
		gtkfilechooserwidgetaccessible.h gtkflowboxaccessible.h gtkflowboxchildaccessible.h gtkframeaccessible.h gtkheaderbaraccessible.h gtkiconviewaccessible.h
		gtkimageaccessible.h gtkimagecellaccessible.h gtklabelaccessible.h gtklevelbaraccessible.h gtklinkbuttonaccessible.h gtklistboxaccessible.h
		gtklistboxrowaccessible.h gtklockbuttonaccessible.h gtkmenuaccessible.h gtkmenubuttonaccessible.h gtkmenuitemaccessible.h gtkmenushellaccessible.h
		gtknotebookaccessible.h gtknotebookpageaccessible.h gtkpanedaccessible.h gtkplugaccessible.h gtkpopoveraccessible.h gtkprogressbaraccessible.h
		gtkradiobuttonaccessible.h gtkradiomenuitemaccessible.h gtkrangeaccessible.h gtkrenderercellaccessible.h gtkscaleaccessible.h gtkscalebuttonaccessible.h
		gtkscrolledwindowaccessible.h gtksocketaccessible.h gtkspinbuttonaccessible.h gtkspinneraccessible.h gtkstatusbaraccessible.h gtkstackaccessible.h
		gtkswitchaccessible.h gtktextcellaccessible.h gtktextviewaccessible.h gtktogglebuttonaccessible.h gtktoplevelaccessible.h gtktreeviewaccessible.h
		gtkwidgetaccessible.h gtkwindowaccessible.h
	]])),
	install=true,
}
pkg.deps = {
	'$gendir/headers',
	'$outdir/gdk/gdkconfig.h',
	'$outdir/gdk/gdkenumtypes.h',
	'$outdir/gtk/gtkversion.h',
	'$outdir/gtk/gtktypebuiltins.h',
	'$outdir/gtk/gtkprivatetypebuiltins.h',
	'$outdir/gtk/gtkresources.h',
	'$outdir/gdk/gdkresources.h',
	'$outdir/gdk/gdkdbusgenerated.h',
	'$outdir/gtk/gtkdbusgenerated.h',
	'$outdir/gtk/gtktypefuncs.inc',
	'$dir/gtkmarshalers.h',
	'pkg/glib/headers',
	'pkg/gio/headers',
	'pkg/gmodule/headers',
	'pkg/pango/headers',
	'pkg/gdk-pixbuf/headers',
	'pkg/cairo/headers',
	'pkg/fribidi/headers',
	'pkg/harfbuzz/headers',
	'pkg/atk/headers',
	'pkg/wayland/headers',
	'pkg/wayland-protocols/headers',
	'pkg/libepoxy/headers',
	'pkg/libxkbcommon/headers',
	'$outdir/gdk/gdkversionmacros.h',
	'$dir/gtkmarshalers.h',
	'pkg/linux-headers/headers',
}

for _, p in ipairs({'gtk-shell', 'gtk-primary-selection', 'server-decoration'}) do
	local xml = '$srcdir/gdk/wayland/protocol/' .. p .. '.xml'
	build('wayland-proto', '$outdir/gdk/wayland/' .. p .. '-client-protocol.h', xml, {type='client-header'})
	build('wayland-proto', '$outdir/gdk/wayland/' .. p .. '-protocol.c', xml, {type='private-code'})
	table.insert(pkg.deps, '$outdir/gdk/wayland/' .. p .. '-client-protocol.h')
end

for _, p in ipairs({'xdg-shell', 'xdg-shell-unstable-v6', 'pointer-gestures-unstable-v1', 'xdg-foreign-unstable-v1', 'tablet-unstable-v2', 'keyboard-shortcuts-inhibit-unstable-v1', 'xdg-output-unstable-v1', 'primary-selection-unstable-v1', 'xdg-activation-v1'}) do
	build('copy', '$outdir/gdk/wayland/' .. p .. '-client-protocol.h', '$builddir/pkg/wayland-protocols/include/' .. p .. '-client-protocol.h')
	table.insert(pkg.deps, '$outdir/gdk/wayland/' .. p .. '-client-protocol.h')
end

local gdkcore = {}
for line in iterlines('gdkcore.txt') do
	for s in line:gmatch('%S+') do
		if s == 'gdkmarshalers.c' then
			gdkcore[#gdkcore + 1] = '$dir/gdkmarshalers.c'
		else
			gdkcore[#gdkcore + 1] = 'gdk/' .. s
		end
	end
end
local gdkwl = {}
for line in iterlines('gdkwl.txt') do
	for s in line:gmatch('%S+') do
		gdkwl[#gdkwl + 1] = 'gdk/wayland/' .. s
	end
end
local srcnames = {}
for line in iterlines('srcs.txt') do
	for s in line:gmatch('%S+') do
		if s == 'gtkmarshalers.c' then
			srcnames[#srcnames + 1] = '$dir/gtkmarshalers.c'
		else
			srcnames[#srcnames + 1] = 'gtk/' .. s
		end
	end
end

local gobjs = {}
for _, s in ipairs(gdkcore) do gobjs[#gobjs + 1] = compile('cc', s) end
for _, s in ipairs(gdkwl) do gobjs[#gobjs + 1] = compile('cc', s) end
for _, p in ipairs({'gtk-shell', 'gtk-primary-selection', 'server-decoration'}) do
	gobjs[#gobjs + 1] = compile('cc', '$outdir/gdk/wayland/' .. p .. '-protocol.c')
end
for _, p in ipairs({'xdg-shell', 'xdg-shell-unstable-v6', 'pointer-gestures-unstable-v1', 'xdg-foreign-unstable-v1', 'tablet-unstable-v2', 'keyboard-shortcuts-inhibit-unstable-v1', 'xdg-output-unstable-v1', 'primary-selection-unstable-v1', 'xdg-activation-v1'}) do
	gobjs[#gobjs + 1] = '$builddir/pkg/wayland-protocols/' .. p .. '-protocol.c.o'
end
for _, s in ipairs(srcnames) do gobjs[#gobjs + 1] = compile('cc', s) end
gobjs[#gobjs + 1] = compile('cc', '$dir/gdkenumtypes.c')
gobjs[#gobjs + 1] = compile('cc', '$dir/gtktypebuiltins.c')
gobjs[#gobjs + 1] = compile('cc', '$dir/gtkprivatetypebuiltins.c')
gobjs[#gobjs + 1] = compile('cc', '$dir/gtkresources.c')
gobjs[#gobjs + 1] = compile('cc', '$dir/gdkresources.c')
gobjs[#gobjs + 1] = compile('cc', '$dir/gtkdbusgenerated.c')
gobjs[#gobjs + 1] = '$builddir/pkg/glib/libglib-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/glib/libgobject-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/gio/libgio-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/gmodule/libgmodule-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/pango/libpango-1.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/gdk-pixbuf/libgdk_pixbuf-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/cairo/libcairo.a'
gobjs[#gobjs + 1] = '$builddir/pkg/libpng/libpng.a'
gobjs[#gobjs + 1] = '$builddir/pkg/freetype/libfreetype.a'
gobjs[#gobjs + 1] = '$builddir/pkg/fontconfig/libfontconfig.a'
gobjs[#gobjs + 1] = '$builddir/pkg/harfbuzz/libharfbuzz.a'
gobjs[#gobjs + 1] = '$builddir/pkg/fribidi/libfribidi.a'
gobjs[#gobjs + 1] = '$builddir/pkg/pixman/libpixman.a'
gobjs[#gobjs + 1] = '$builddir/pkg/expat/libexpat.a'
gobjs[#gobjs + 1] = '$builddir/pkg/zlib/libz.a'
gobjs[#gobjs + 1] = '$builddir/pkg/libffi/libffi.a'
gobjs[#gobjs + 1] = '$builddir/pkg/atk/libatk-1.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/wayland/libwayland-client.a'
gobjs[#gobjs + 1] = '$builddir/pkg/wayland/libwayland-cursor.a'
gobjs[#gobjs + 1] = '$builddir/pkg/wayland/libwayland-egl.a'
gobjs[#gobjs + 1] = '$builddir/pkg/libepoxy/libepoxy.a'
gobjs[#gobjs + 1] = '$builddir/pkg/libxkbcommon/libxkbcommon.a'
gobjs[#gobjs + 1] = '$builddir/pkg/util-linux/libuuid.a'
gobjs[#gobjs + 1] = '$builddir/pkg/util-linux/libcommon.a'
gobjs[#gobjs + 1] = '$builddir/pkg/openbsd/libbsd.a'
ar('libgtk-3.a', gobjs)

fetch 'local'
