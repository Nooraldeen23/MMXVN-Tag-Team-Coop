for (var i = 0; i < 500; i++)
{
    store_respawn[i] = 
    {
        store_x: 0,
        store_y: 0,
        store_depth: 0,
        store_object: -1,
        store_xscale: 0,
        store_yscale: 0,
        store_angle: 0,
        store_type: 0,
        respawn: 0
    };
}
if (current_area != room)
{
    global.checkpointx = obj_player.xstart;
    global.checkpointy = obj_player.ystart;
    current_area = room;
}
with (obj_player)
{
    spr_manager = new sprite_manager(id);
    scr_setup_player_sprites();
}
obj_player.x = global.checkpointx;
obj_player.y = global.checkpointy;
obj_camera.x = obj_player.x;
obj_camera.y = obj_player.y;
scr_get_reploid_amount(room);
global.rescue_max = reploid_amount;
alarm[0] = 60;
if (room != rm_title && room != rm_intro)
{
    autosaving = true;
    save_slot = 0;
    event_user(0);
}
if (room == rm_stage_select)
{
    scr_part_storestock();
    global.game_completion = 100;
    var completion_check = 0;
    var completion_check_amount = 5;
    scr_get_level_completion(rm_yammark);
    completion_check += (completion / 100);
    scr_get_level_completion(rm_turtloid);
    completion_check += (completion / 100);
    scr_get_level_completion(rm_heatnix);
    completion_check += (completion / 100);
    scr_get_level_completion(rm_mijinion);
    completion_check += (completion / 100);
    scr_get_level_completion(rm_template);
    completion_check += (completion / 100);
    sprite_index = spr_partselect_icon;
    completion_check += ((ds_list_size(global.parts_owned) - (tagteam_has_separate_health() ? 1 : 0) - (tagteam_has_separate_energy() ? 1 : 0)) / image_number);
    if (completion_check > 0)
    {
        global.game_completion = floor((global.game_completion * completion_check) / completion_check_amount);
    }
    else
    {
        global.game_completion = 0;
    }
}
result_disable = false;
