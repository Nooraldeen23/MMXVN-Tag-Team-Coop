function map_real(arg0, arg1, arg2)
{
    if (ds_map_exists(arg0, arg1))
    {
        var _v = ds_map_find_value(arg0, arg1);
        if (!is_undefined(_v))
        {
            return real(_v);
        }
    }
    return arg2;
}

if (file_exists("autosave_export.txt"))
{
    if (defaults == true)
    {
        autosave_import = import_json("defaultsave_export.txt");
    }
    else
    {
        autosave_import = import_json("autosave_export.txt");
    }
    defaults = false;
    if (ds_map_exists(autosave_import, "language"))
    {
        global.locale = ds_map_find_value(autosave_import, "language");
        InitTranslations();
    }
    global.indicators = ds_map_find_value(autosave_import, "indicators");
    global.cutscene_skip = ds_map_find_value(autosave_import, "cutscene_skip");
    if (ds_map_exists(autosave_import, "lives_toggle"))
    {
        global.lives_toggle = ds_map_find_value(autosave_import, "lives_toggle");
    }
    if (ds_map_exists(autosave_import, "result_display"))
    {
        global.result_display = ds_map_find_value(autosave_import, "result_display");
    }
    if (ds_map_exists(autosave_import, "gaichuuin_visability"))
    {
        global.gaichuuin_visability = ds_map_find_value(autosave_import, "gaichuuin_visability");
    }
    if (ds_map_exists(autosave_import, "music_custom"))
    {
        global.music_custom = ds_map_find_value(autosave_import, "music_custom");
    }
    if (ds_map_exists(autosave_import, "x4_charge_shot"))
    {
        global.x4_charge_shot = ds_map_find_value(autosave_import, "x4_charge_shot");
    }
    global.fps_display = ds_map_find_value(autosave_import, "fps_display");
    global.ui_scale = ds_map_find_value(autosave_import, "ui_scale");
    if (ds_map_exists(autosave_import, "window_mode"))
    {
        window_mode = map_real(autosave_import, "window_mode", 0);
        window_size = map_real(autosave_import, "window_size", 0);
        if (ds_map_exists(autosave_import, "window_resolution"))
        {
            window_resolution = ds_map_find_value(autosave_import, "window_resolution");
        }
        global.vsync = ds_map_find_value(autosave_import, "vsync");
        display_reset(0, global.vsync);
    }
    global.volume_master = ds_map_find_value(autosave_import, "volume_master");
    global.volume_effect = ds_map_find_value(autosave_import, "volume_effect");
    global.volume_music = ds_map_find_value(autosave_import, "volume_music");
    global.controller = ds_map_find_value(autosave_import, "controller");
    controller_toggle = ds_map_find_value(autosave_import, "controller_toggle");
    for (var i = 0; i < 19; i++)
    {
        keyboard[i] = ds_list_find_value(ds_map_find_value(autosave_import, "keyboard_list"), i);
        controller[i] = ds_list_find_value(ds_map_find_value(autosave_import, "controller_list"), i);
    }
    if (ds_map_exists(autosave_import, "rapidfire"))
    {
        global.rapidfire = ds_map_find_value(autosave_import, "rapidfire");
        global.autocharge = ds_map_find_value(autosave_import, "autocharge");
    }
    global.tag_swap_key = clamp(floor(map_real(autosave_import, "tag_swap_key", 70)), 1, 255);
    global.tag_swap_pad = clamp(floor(map_real(autosave_import, "tag_swap_pad", 32780)), 32769, 32784);
    ds_map_destroy(autosave_import);
    apply_video_settings();
}
