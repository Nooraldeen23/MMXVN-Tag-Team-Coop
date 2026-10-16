autosave_data = ds_map_create();
ds_map_set(autosave_data, "language", global.locale);
ds_map_set(autosave_data, "indicators", global.indicators);
ds_map_set(autosave_data, "cutscene_skip", global.cutscene_skip);
ds_map_set(autosave_data, "lives_toggle", global.lives_toggle);
ds_map_set(autosave_data, "result_display", global.result_display);
ds_map_set(autosave_data, "gaichuuin_visability", global.gaichuuin_visability);
ds_map_set(autosave_data, "music_custom", global.music_custom);
ds_map_set(autosave_data, "x4_charge_shot", global.x4_charge_shot);
ds_map_set(autosave_data, "fps_display", global.fps_display);
ds_map_set(autosave_data, "ui_scale", global.ui_scale);
ds_map_set(autosave_data, "window_mode", window_mode);
ds_map_set(autosave_data, "window_size", window_size);
ds_map_set(autosave_data, "window_resolution", window_resolution);
ds_map_set(autosave_data, "vsync", global.vsync);
ds_map_set(autosave_data, "volume_master", global.volume_master);
ds_map_set(autosave_data, "volume_effect", global.volume_effect);
ds_map_set(autosave_data, "volume_music", global.volume_music);
ds_map_set(autosave_data, "rapidfire", global.rapidfire);
ds_map_set(autosave_data, "autocharge", global.autocharge);
ds_map_set(autosave_data, "controller_toggle", controller_toggle);
ds_map_set(autosave_data, "controller", global.controller);
var keyboard_list = ds_list_create();
var controller_list = ds_list_create();
for (var i = 0; i < 19; i++)
{
    ds_list_add(keyboard_list, keyboard[i]);
    ds_list_add(controller_list, controller[i]);
}
ds_map_add_list(autosave_data, "keyboard_list", keyboard_list);
ds_map_add_list(autosave_data, "controller_list", controller_list);
ds_map_set(autosave_data, "tag_swap_key", global.tag_swap_key);
ds_map_set(autosave_data, "tag_swap_pad", global.tag_swap_pad);
export_json("autosave_export.txt", autosave_data);
if (!file_exists("defaultsave_export.txt"))
{
    export_json("defaultsave_export.txt", autosave_data);
}
ds_map_destroy(autosave_data);
