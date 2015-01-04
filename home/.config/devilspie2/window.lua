-- Left
if (	string.match(get_window_class(), "-terminal$") or
	string.match(get_window_class(), "^Emacs") or
	get_window_class() == "Gedit" or
	get_window_class() == "Pluma" or
	get_window_class() == "Nemo" or
	get_window_class() == "Caja") then
   set_window_geometry2(0, 0, 682, 722)
   maximize_vertically()

-- Right
elseif (get_window_class() == "Vlc" or
	get_window_class() == "Gthumb" or
	get_window_class() == "Chromium-browser" or
	get_window_class() == "Firefox") then
   set_window_geometry2(694, 0, 682, 722)
   maximize_vertically()

-- Workspace Reading
elseif (get_window_class() == "Atril" or
        get_window_class() == "Evince") then
   set_window_workspace(3)
   maximize()

-- Workspace Drawing
elseif (get_window_class() == "Krita" or
	string.find(get_window_class(), "Gimp")) then
   set_window_workspace(4)

elseif (get_window_class() == "Blender") then
   if (string.find(get_window_name(), "Blender User Preferences")) then
      set_window_geometry2(694, 0, 682, 722)
   else
      maximize();
   end
   set_window_workspace(2)
end
