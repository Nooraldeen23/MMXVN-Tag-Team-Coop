if (file_exists("save_" + string(save_slot) + ".txt"))
{
    save_import = import_json("save_" + string(save_slot) + ".txt");
    global.nightmare_souls = ds_map_find_value(save_import, "save_nightmare_souls");
    ds_list_clear(global.rescue_list);
    for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_rescue_list")); i++)
    {
        ds_list_add(global.rescue_list, ds_list_find_value(ds_map_find_value(save_import, "save_rescue_list"), i));
    }
    ds_list_clear(global.pickup_list);
    for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_pickup_list")); i++)
    {
        ds_list_add(global.pickup_list, ds_list_find_value(ds_map_find_value(save_import, "save_pickup_list"), i));
    }
    ds_list_clear(global.level_list);
    for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_level_list")); i++)
    {
        ds_list_add(global.level_list, ds_list_find_value(ds_map_find_value(save_import, "save_level_list"), i));
    }
    if (ds_map_exists(save_import, "save_nightmare_progress"))
    {
        ds_list_clear(global.nightmare_progress);
        for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_nightmare_progress")); i++)
        {
            ds_list_add(global.nightmare_progress, ds_list_find_value(ds_map_find_value(save_import, "save_nightmare_progress"), i));
        }
        ds_list_clear(global.datalog_list);
        for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_datalog_list")); i++)
        {
            ds_list_add(global.datalog_list, ds_list_find_value(ds_map_find_value(save_import, "save_datalog_list"), i));
        }
    }
    global.hearttank = ds_map_find_value(save_import, "save_hearttank");
    global.subtank_1 = ds_map_find_value(save_import, "save_subtank_1");
    global.subtank_2 = ds_map_find_value(save_import, "save_subtank_2");
    global.weapontank = ds_map_find_value(save_import, "save_weapontank");
    global.powertank = ds_map_find_value(save_import, "save_powertank");
    global.blade_head_get = ds_map_find_value(save_import, "save_blade_head_get");
    global.blade_chest_get = ds_map_find_value(save_import, "save_blade_chest_get");
    global.blade_arm_get = ds_map_find_value(save_import, "save_blade_arm_get");
    global.blade_leg_get = ds_map_find_value(save_import, "save_blade_leg_get");
    global.shadow_head_get = ds_map_find_value(save_import, "save_shadow_head_get");
    global.shadow_chest_get = ds_map_find_value(save_import, "save_shadow_chest_get");
    global.shadow_arm_get = ds_map_find_value(save_import, "save_shadow_arm_get");
    global.shadow_leg_get = ds_map_find_value(save_import, "save_shadow_leg_get");
    global.x_armour_head = ds_map_find_value(save_import, "save_x_armour_head");
    global.x_armour_chest = ds_map_find_value(save_import, "save_x_armour_chest");
    global.x_armour_arm = ds_map_find_value(save_import, "save_x_armour_arm");
    global.x_armour_leg = ds_map_find_value(save_import, "save_x_armour_leg");
    global.zero_armour_black = ds_map_find_value(save_import, "save_zero_armour_black");
    global.black_armour_get = ds_map_find_value(save_import, "save_black_armour_get");
    ds_list_clear(global.parts_equipped);
    for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_parts_equipped")); i++)
    {
        ds_list_add(global.parts_equipped, ds_list_find_value(ds_map_find_value(save_import, "save_parts_equipped"), i));
    }
    ds_list_clear(global.parts_owned);
    for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_parts_owned")); i++)
    {
        ds_list_add(global.parts_owned, ds_list_find_value(ds_map_find_value(save_import, "save_parts_owned"), i));
    }
    ds_list_clear(global.parts_store);
    for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_parts_store")); i++)
    {
        ds_list_add(global.parts_store, ds_list_find_value(ds_map_find_value(save_import, "save_parts_store"), i));
    }
    ds_list_clear(global.parts_list);
    for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_parts_list")); i++)
    {
        ds_list_add(global.parts_list, ds_list_find_value(ds_map_find_value(save_import, "save_parts_list"), i));
    }
    if (ds_map_exists(save_import, "save_playable_character"))
    {
        switch (ds_map_find_value(save_import, "save_playable_character"))
        {
            case "Zero":
                global.playable_character = Character_Zero();
                break;
            case "X":
            default:
                global.playable_character = Character_X();
                break;
        }
        global.zero_unlock = ds_map_find_value(save_import, "save_zero_unlock");
    }
    if (ds_map_exists(save_import, "save_weapon"))
    {
        ds_list_clear(global.weapon_list);
        for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_weapon")); i++)
        {
            scr_weapon_get(ds_list_find_value(ds_map_find_value(save_import, "save_weapon"), i), true);
        }
    }
    if (ds_map_exists(save_import, "save_weapon_disable"))
    {
        ds_list_clear(global.weapon_disable_list);
        for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_weapon_disable")); i++)
        {
            ds_list_add(global.weapon_disable_list, ds_list_find_value(ds_map_find_value(save_import, "save_weapon_disable"), i));
        }
    }
    global.playtime = ds_map_find_value(save_import, "save_playtime");
    global.game_completion = ds_map_find_value(save_import, "save_game_completion");
    global.ng_cycle = ds_map_find_value(save_import, "save_ng_cycle");
    if (ds_map_exists(save_import, "save_ng_cycle_max"))
    {
        global.ng_cycle_max = ds_map_find_value(save_import, "save_ng_cycle_max");
    }
    if (ds_map_exists(save_import, "save_result_store"))
    {
        ds_list_clear(global.result_store);
        for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_result_store")); i++)
        {
            var entry = ds_list_find_value(ds_map_find_value(save_import, "save_result_store"), i);
            ds_list_add(global.result_store, 
            {
                level: ds_map_find_value(entry, "level"),
                time: ds_map_find_value(entry, "time"),
                time_rank: ds_map_find_value(entry, "time_rank"),
                kill: ds_map_find_value(entry, "kill"),
                kill_rank: ds_map_find_value(entry, "kill_rank"),
                damage: ds_map_find_value(entry, "damage"),
                damage_rank: ds_map_find_value(entry, "damage_rank")
            });
        }
    }
    for (var i = 0; i < global.event_list_size; i++)
    {
        global.event[i] = ds_list_find_value(ds_map_find_value(save_import, "save_event"), i);
    }
    global.tag_health_enabled = ds_map_exists(save_import, "save_tag_health_enabled") ? ds_map_find_value(save_import, "save_tag_health_enabled") : true;
    global.tag_energy_enabled = ds_map_exists(save_import, "save_tag_energy_enabled") ? ds_map_find_value(save_import, "save_tag_energy_enabled") : true;
    global.tag_secret_unlock = ds_map_exists(save_import, "save_tag_secret_unlock") ? ds_map_find_value(save_import, "save_tag_secret_unlock") : false;
    global.tag_colonel_soul_claimed = ds_map_exists(save_import, "save_tag_colonel_soul_claimed") ? ds_map_find_value(save_import, "save_tag_colonel_soul_claimed") : false;
    global.tag_secret_completed = ds_map_exists(save_import, "save_tag_secret_completed") ? ds_map_find_value(save_import, "save_tag_secret_completed") : global.tag_colonel_soul_claimed;
    global.tag_returning = false;
    global.tag_deferred_blade = ds_map_exists(save_import, "save_tag_deferred_blade") ? ds_map_find_value(save_import, "save_tag_deferred_blade") : false || ds_list_find_index(global.parts_owned, 900) != -1;
    global.tag_deferred_buster = ds_map_exists(save_import, "save_tag_deferred_buster") ? ds_map_find_value(save_import, "save_tag_deferred_buster") : false || ds_list_find_index(global.parts_owned, 901) != -1;
    for (var reserved = 900; reserved <= 901; reserved++)
    {
        var old = ds_list_find_index(global.parts_owned, reserved);
        if (old != -1)
        {
            ds_list_delete(global.parts_owned, old);
        }
        old = ds_list_find_index(global.parts_equipped, reserved);
        if (old != -1)
        {
            ds_list_delete(global.parts_equipped, old);
        }
    }
    global.tag_health = [-1, -1];
    global.tag_auto_swap = false;
    scr_part_storestock();
    ds_map_destroy(save_import);
    room_goto(rm_stage_select);
}
