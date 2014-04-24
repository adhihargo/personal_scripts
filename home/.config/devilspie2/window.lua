-- Left
if(get_window_class() == "Mate-terminal" or
   get_window_class() == "Emacs23" or
   get_window_class() == "Caja") then
   set_window_geometry2(0, 0, 505, 750)
   maximize_vertically()
end

-- Right
if(get_window_class() == "Vlc" or
   get_window_class() == "Gthumb" or
   get_window_class() == "Firefox") then
   set_window_geometry2(506, 0, 775, 750)
   maximize_vertically()
end

-- Workspace Reading
if(get_window_class() == "Atril") then
   set_window_workspace(3)
end

-- Workspace Drawing
if(get_window_class() == "Krita" or
   string.find(get_window_class(), "Gimp")) then
   set_window_workspace(4)
end

if(get_window_class() == "Blender") then
   maximize();
end