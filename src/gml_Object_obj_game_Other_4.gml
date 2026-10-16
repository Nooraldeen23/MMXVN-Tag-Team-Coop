if (global.tag_returning && room == rm_turtloid)
{
    global.current_level = room;
}
if (room == rm_weapon_get)
{
    instance_create_depth(0, 0, 0, obj_cutscene_weapon_get);
}
else if (room == rm_training)
{
    instance_create_depth(0, 0, 0, obj_cutscene_training_start);
}
else
{
    if (room == rm_intro && global.playable_character.name == "Zero")
    {
        global.current_level = room;
    }
    if (global.current_level != room)
    {
        global.result_timer = 0;
        global.result_damage = 0;
        ds_list_clear(global.result_kill);
    }
    if (global.current_level != room && global.level_completed == false && global.cutscene_skip == false)
    {
        switch (room)
        {
            case rm_intro:
                instance_create_depth(0, 0, 0, obj_cutscene_intro_intro);
                instance_create_depth(0, 0, 0, obj_comic_opening);
                break;
            case rm_yammark:
                instance_create_depth(0, 0, 0, obj_cutscene_amazon_intro);
                break;
            case rm_turtloid:
                instance_create_depth(0, 0, 0, obj_cutscene_temple_intro);
                break;
            case rm_heatnix:
                if (obj_player.x == 1120)
                {
                    instance_create_depth(0, 0, 0, obj_cutscene_heatnix_intro);
                }
                else
                {
                    instance_create_depth(0, 0, 0, obj_cutscene_level_start);
                }
                break;
            case rm_mijinion:
                instance_create_depth(0, 0, 0, obj_cutscene_mijinion_intro);
                break;
            case rm_stage_select:
                if (global.event[2] == 0)
                {
                    instance_create_depth(0, 0, 0, obj_comic_isocspeech);
                }
                else if (global.event[0] == 0.5)
                {
                    if (global.playable_character.name == "X")
                    {
                        instance_create_depth(0, 0, 0, obj_comic_x_first);
                    }
                    else if (global.playable_character.name == "Zero")
                    {
                        instance_create_depth(0, 0, 0, obj_comic_zero_first);
                    }
                }
                else if (global.event[1] == 0.5)
                {
                    if (global.playable_character.name == "X")
                    {
                        instance_create_depth(0, 0, 0, obj_comic_x_fourth);
                    }
                    else if (global.playable_character.name == "Zero")
                    {
                        instance_create_depth(0, 0, 0, obj_comic_zero_fourth);
                    }
                }
                else if (global.event[5] == 0.5)
                {
                    instance_create_depth(0, 0, 0, obj_comic_briefing_zero);
                }
                break;
            default:
                instance_create_depth(0, 0, 0, obj_cutscene_level_start);
                break;
        }
    }
    else if (obj_player.x == 1120 && room == rm_heatnix && global.level_completed == false)
    {
        instance_create_depth(0, 0, 0, obj_cutscene_level_start_bike);
    }
    else
    {
        if (obj_player.x == 1120 && room == rm_heatnix)
        {
            obj_player.x = 2100;
        }
        instance_create_depth(0, 0, 0, obj_cutscene_level_start);
    }
    if (global.current_level != room && global.lives < global.lives_start)
    {
        global.lives = global.lives_start;
    }
    if (ds_list_find_index(global.parts_equipped, 22) != -1)
    {
        scr_get_part_effect(22, false);
    }
}
global.current_level = room;
if (ds_list_find_index(global.parts_equipped, 6) != -1)
{
    scr_get_part_effect(6, false);
}
if (room != rm_stage_select && room != rm_title)
{
    event_user(0);
    global.life = global.lifemax;
    global.weapon_choice = 0;
    global.weapon_ammo_max = obj_manager.base_weapon_ammo_max;
    if (global.powertank > 0)
    {
        global.weapon_ammo_max = ceil(global.weapon_ammo_max * 1.25);
    }
    for (var i = 0; i < 10; i++)
    {
        global.weapon[i].ammo = global.weapon_ammo_max;
    }
}
if (room == rm_stage_select)
{
    global.seen_boss_cutscene = -1;
    global.current_level = -1;
    if (global.event[2] == 0)
    {
        global.event[2] = 1;
    }
    else if (global.event[0] == 0.5)
    {
        global.event[0] = 1;
    }
    else if (global.event[1] == 0.5)
    {
        global.event[1] = 1;
    }
    else if (global.event[5] == 0.5)
    {
        global.event[5] = 1;
    }
}
tagteam_initialize_pools();
with (obj_player)
{
    tag_pit_death = false;
    tag_rescue_pending = false;
    tag_rescue_grace = 0;
}
if (global.tag_returning && room == rm_turtloid)
{
    obj_player.x = global.tag_return_x;
    obj_player.y = global.tag_return_y;
    global.tag_returning = false;
}
