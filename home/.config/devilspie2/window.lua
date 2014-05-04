-- Left
if (	get_window_class() == "Mate-terminal" or
	get_window_class() == "Emacs23" or
	get_window_class() == "Pluma" or
	get_window_class() == "Caja") then
   set_window_geometry2(0, 0, 505, 750)
   maximize_vertically()

-- Right
elseif (get_window_class() == "Vlc" or
	get_window_class() == "Gthumb" or
	get_window_class() == "Chromium-browser" or
	get_window_class() == "Firefox") then
   set_window_geometry2(516, 0, 765, 750)
   maximize_vertically()

-- Workspace Reading
elseif (get_window_class() == "Atril") then
   set_window_workspace(3)
   maximize()

-- Workspace Drawing
elseif (get_window_class() == "Krita" or
	string.find(get_window_class(), "Gimp")) then
   set_window_workspace(4)

elseif (get_window_class() == "Blender") then
   if (get_window_name() == "Blender User Preferences") then
      set_window_geometry2(516, 0, 765, 721)
   else
      maximize();
   end
end
