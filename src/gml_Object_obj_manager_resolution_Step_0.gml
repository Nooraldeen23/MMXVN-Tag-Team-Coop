global.view_width = 1920 / zoom_scale;
global.view_height = 1080 / zoom_scale;
if (instance_exists(obj_menu_paused))
{
    if (obj_menu_paused.window_resolution == 1)
    {
        var max_tex = 16384;
        var w = max(1, min(window_get_width(), max_tex));
        var h = max(1, min(window_get_height(), max_tex));
        surface_resize(application_surface, w, h);
    }
    else
    {
        surface_resize(application_surface, global.view_width * window_scale, global.view_height * window_scale);
    }
}
else
{
    surface_resize(application_surface, global.view_width * window_scale, global.view_height * window_scale);
}
display_set_gui_size(resolution_width, resolution_height);
