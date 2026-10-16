if (coop_client() && global.pause_screen && global.pause_menu == "Options" && global.pause_menu_sub == "Options" && menu_position == 5)
{
    scr_get_input();
    if (global.input_jump_pressed)
    {
        coop_leave_session();
        exit;
    }
}
if (coop_client() && coop_play_room() && global.pause && global.pause_screen && global.pause_menu == "Paused" && menu_state == "Options" && menu_position == 3)
{
    scr_get_input();
    if (global.input_jump_pressed)
    {
        scr_make_sound(snd_menu_select, 1, 1, false);
        coop_leave_session();
        exit;
    }
}
if (room == rm_title && coop_controls_return && (global.pause_menu_sub == "Controls" || global.pause_menu_sub == "Options"))
{
    coop_controls_return = false;
    global.pause_menu_sub = "Co-op";
    coop_lobby_row = 3;
    keyboard_clear(vk_enter);
}
if (room == rm_title && global.pause_menu_sub == "Co-op")
{
    coop_lobby_age++;
    scr_get_input();
    if (coop_lobby_attack_x >= 0)
    {
        coop_lobby_attack_x++;
        if (coop_lobby_attack_x == 8)
        {
            scr_make_sound(snd_shoot_large, 0.7, 1, false);
        }
        if (coop_lobby_attack_x >= 44)
        {
            coop_lobby_attack_x = -1;
        }
    }
    if (coop_lobby_attack_zero >= 0)
    {
        coop_lobby_attack_zero++;
        if (coop_lobby_attack_zero == 4)
        {
            scr_make_sound(snd_shoot_saber_zero, 0.7, 1, false);
        }
        if (coop_lobby_attack_zero >= 32)
        {
            coop_lobby_attack_zero = -1;
        }
    }
    coop_lobby_pulse = max(0, coop_lobby_pulse - 1);
    if (global.input_up_pressed)
    {
        coop_lobby_row = max(0, coop_lobby_row - 1);
        scr_make_sound(snd_menu_move, 1, 1, false);
    }
    if (global.input_down_pressed)
    {
        coop_lobby_row = min(5, coop_lobby_row + 1);
        scr_make_sound(snd_menu_move, 1, 1, false);
    }
    var change = global.input_left_pressed || global.input_right_pressed;
    var confirm = global.input_jump_pressed;
    var backwards = global.input_left_pressed;
    if (global.coop_role == 0)
    {
        if (coop_lobby_row == 0 && (change || confirm))
        {
            coop_lobby_role = 3 - coop_lobby_role;
            scr_make_sound(snd_menu_select, 1, 1, false);
        }
        if (coop_lobby_row == 1 && (change || confirm))
        {
            if (change)
            {
                coop_lobby_char = backwards ? "X" : "Zero";
            }
            if (coop_lobby_char == "X")
            {
                coop_lobby_attack_x = 0;
            }
            else
            {
                coop_lobby_attack_zero = 0;
            }
            scr_make_sound(snd_menu_select, 1, 1, false);
        }
        if (coop_lobby_row == 2 && confirm)
        {
            if (coop_lobby_role == 2)
            {
                coop_lobby_error = coop_online_endpoint(get_string("Host IP : TCP port (same PC: 127.0.0.1)", global.coop_host + ":" + string(global.coop_port))) ? "" : "Enter a valid address and port";
            }
            else
            {
                var porttext = get_string("Host TCP port (1024-65535)", string(global.coop_port));
                if (string_digits(porttext) == porttext && porttext != "" && real(porttext) >= 1024 && real(porttext) <= 65535)
                {
                    global.coop_port = real(porttext);
                    coop_lobby_error = "";
                }
                else
                {
                    coop_lobby_error = "Invalid port";
                }
            }
            keyboard_clear(vk_enter);
        }
    }
    if (confirm && coop_lobby_row == 3)
    {
        coop_controls_return = true;
        global.pause_menu_sub = "Bindings";
        menu_position = 0;
        key_select = false;
        scr_make_sound(snd_menu_select, 1, 1, false);
        exit;
    }
    if (confirm && coop_lobby_row == 4)
    {
        with (obj_coop_net)
        {
            instance_destroy();
        }
        if (global.coop_role > 0)
        {
            global.coop_role = 0;
            global.coop_campaign_active = false;
            global.coop_preview_active = false;
        }
        else
        {
            global.coop_role = coop_lobby_role;
            global.coop_character = coop_lobby_char;
            global.coop_campaign_active = true;
            global.coop_preview_active = false;
            global.coop_buddy = false;
            global.zero_unlock = true;
        }
        instance_create_depth(0, 0, -9999, obj_coop_net);
        obj_manager.forest_tick = 0;
        coop_lobby_error = "";
        scr_make_sound(snd_menu_select, 1, 1, false);
    }
    if ((confirm && coop_lobby_row == 5) || (global.input_start_pressed && !confirm))
    {
        if (global.coop_role != 0)
        {
            with (obj_coop_net)
            {
                instance_destroy();
            }
            global.coop_role = 0;
            global.coop_campaign_active = false;
            global.coop_preview_active = false;
            instance_create_depth(0, 0, -9999, obj_coop_net);
        }
        global.pause_menu_sub = "Title";
        menu_position = 2;
        coop_lobby_age = 0;
    }
    coop_lobby_blend = lerp(coop_lobby_blend, (coop_lobby_char == "Zero") ? 1 : 0, 0.16);
    coop_lobby_cursor = lerp(coop_lobby_cursor, coop_lobby_row, 0.28);
    exit;
}
if (tag_binding_mode > 0)
{
    if (keyboard_check_pressed(vk_escape))
    {
        tag_binding_mode = 0;
        scr_make_sound(snd_menu_move, 1, 1, false);
        exit;
    }
    var tag_new_code = -1;
    if (tag_binding_mode == 1 && keyboard_check_pressed(vk_anykey))
    {
        tag_new_code = keyboard_key;
    }
    if (tag_binding_mode == 2)
    {
        for (var tgb = 32769; tgb <= 32784; tgb++)
        {
            if (gamepad_button_check_pressed_sdl(0, tgb))
            {
                tag_new_code = tgb;
                break;
            }
        }
    }
    if (tag_new_code > 0)
    {
        var tag_duplicate = false;
        var tag_bindings = (tag_binding_mode == 1) ? keyboard : controller;
        for (var tki = 0; tki < array_length(tag_bindings); tki++)
        {
            if (tag_bindings[tki] == tag_new_code)
            {
                tag_duplicate = true;
            }
        }
        if (tag_binding_mode == 2 && tag_new_code == 32778)
        {
            tag_duplicate = true;
        }
        if (tag_duplicate)
        {
            scr_make_sound(snd_menu_denied, 1, 1, false);
        }
        else
        {
            if (tag_binding_mode == 1)
            {
                global.tag_swap_key = tag_new_code;
            }
            else
            {
                global.tag_swap_pad = tag_new_code;
            }
            tag_binding_mode = 0;
            event_user(3);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
    }
    exit;
}
if (gamepad_is_connected(0) && controller_toggle == true)
{
    global.controller = true;
}
else
{
    global.controller = false;
}
event_user(2);
scr_get_input();
if (instance_exists(obj_comic_parent))
{
    exit;
}
if (global.pause == true)
{
    if (unpause == false)
    {
        unpause = true;
        for (var index = 0; index < instance_count; index++)
        {
            var instance = instance_id_get(index);
            if (instance_exists(instance) && instance.object_index != obj_menu_paused && instance.object_index != obj_openning)
            {
                for (var alarm_index = 0; alarm_index < 10; alarm_index++)
                {
                    var value = instance.alarm[alarm_index];
                    if (value >= 0)
                    {
                        add_alarm(instance, alarm_index, value);
                    }
                }
                if (instance.speed != 0)
                {
                    add_speed(instance, instance.speed);
                }
                if (instance.gravity != 0)
                {
                    add_gravity(instance, instance.gravity);
                }
                if (instance.image_speed != 0)
                {
                    add_animate(instance, instance.image_speed);
                }
            }
        }
    }
    if (key_select == false)
    {
        if (global.pause_screen_state > 0)
        {
            switch (global.pause_menu)
            {
                case "Paused":
                    if (tank_filling < 0)
                    {
                        if (global.pause_screen_state < 3)
                        {
                            switch (menu_state)
                            {
                                case "Weapons":
                                    if (global.input_down_pressed)
                                    {
                                        for (var i = 1; i < 11; i++)
                                        {
                                            if ((menu_position + i) < 10)
                                            {
                                                if (global.weapon[menu_position + i].type != 0)
                                                {
                                                    menu_position += i;
                                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                                    break;
                                                }
                                            }
                                            else
                                            {
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                menu_state = "Options";
                                                menu_position = 0;
                                                break;
                                            }
                                        }
                                    }
                                    else if (global.input_up_pressed && menu_position > 0)
                                    {
                                        for (var i = 1; i < 11; i++)
                                        {
                                            if (global.weapon[menu_position - i].type != 0)
                                            {
                                                menu_position -= i;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                break;
                                            }
                                        }
                                    }
                                    if (global.input_jump_pressed)
                                    {
                                        if (global.playable_character.name == "Zero" && menu_position > 0)
                                        {
                                            if (ds_list_find_index(global.weapon_disable_list, menu_position) == -1)
                                            {
                                                ds_list_add(global.weapon_disable_list, menu_position);
                                                scr_make_sound(snd_menu_denied, 1, 1, false);
                                            }
                                            else
                                            {
                                                for (var i = 0; i < ds_list_size(global.weapon_disable_list); i++)
                                                {
                                                    if (ds_list_find_value(global.weapon_disable_list, i) == menu_position)
                                                    {
                                                        ds_list_delete(global.weapon_disable_list, i);
                                                    }
                                                }
                                                scr_make_sound(snd_menu_equip, 1, 1, false);
                                            }
                                        }
                                        else
                                        {
                                            if (obj_player.player_state == UnknownEnum.Value_0 || obj_player.player_state == UnknownEnum.Value_1)
                                            {
                                                global.weapon_choice = menu_position;
                                            }
                                            event_user(0);
                                            scr_make_sound(snd_menu_select, 1, 1, false);
                                        }
                                    }
                                    if (global.input_right_pressed)
                                    {
                                        for (var i = 0; i < 3; i++)
                                        {
                                            if (menu_tank[i] >= 0)
                                            {
                                                menu_position = i;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                menu_state = "Tanks";
                                                tank_animate = 0;
                                                break;
                                            }
                                        }
                                    }
                                    break;
                                case "Tanks":
                                    if (global.input_right_pressed)
                                    {
                                        for (var i = 1; i < 3; i++)
                                        {
                                            if ((menu_position + i) < 3)
                                            {
                                                if (menu_tank[menu_position + i] >= 0)
                                                {
                                                    menu_position += i;
                                                    tank_animate = 0;
                                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                    else if (global.input_left_pressed)
                                    {
                                        for (var i = 1; i < 4; i++)
                                        {
                                            if ((menu_position - i) > -1)
                                            {
                                                if (menu_tank[menu_position - i] >= 0)
                                                {
                                                    menu_position -= i;
                                                    tank_animate = 0;
                                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                                    break;
                                                }
                                            }
                                            else
                                            {
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                menu_state = "Weapons";
                                                menu_position = 0;
                                                break;
                                            }
                                        }
                                    }
                                    else if (global.input_down_pressed)
                                    {
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        menu_state = "Options";
                                        menu_position = 0;
                                    }
                                    else if (global.input_jump_pressed)
                                    {
                                        if (menu_tank[menu_position] > 0)
                                        {
                                            tank_filling = 0;
                                            if (menu_tank[menu_position] == global.tank_cap)
                                            {
                                                tank_filling_full = true;
                                            }
                                        }
                                    }
                                    break;
                                case "Options":
                                    if (global.input_right_pressed && menu_position < 3)
                                    {
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        menu_position++;
                                    }
                                    else if (global.input_left_pressed && menu_position > 0)
                                    {
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        menu_position--;
                                    }
                                    else if (global.input_up_pressed)
                                    {
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        menu_state = "Weapons";
                                        for (var i = 9; i > 0; i--)
                                        {
                                            if (global.weapon[i].type != 0)
                                            {
                                                menu_position = i;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                break;
                                            }
                                            else
                                            {
                                                menu_position = 0;
                                            }
                                        }
                                    }
                                    else if (global.input_jump_pressed)
                                    {
                                        switch (menu_position)
                                        {
                                            case 0:
                                                event_user(0);
                                                break;
                                            case 1:
                                                global.pause_menu = "Options";
                                                global.pause_menu_sub = "Bindings";
                                                menu_position = 0;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                                break;
                                            case 2:
                                                global.pause_menu = "Options";
                                                menu_position = 1;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                                break;
                                            case 3:
                                                if (room != rm_intro)
                                                {
                                                    global.pause_screen_state = 99;
                                                    fade = instance_create_depth(0, 0, 0, obj_fade_out);
                                                    fade.fade_speed = 0.02;
                                                    scr_make_sound(snd_menu_select, 1, 1, false);
                                                }
                                                else
                                                {
                                                    scr_make_sound(snd_menu_denied, 1, 1, false);
                                                }
                                                break;
                                        }
                                    }
                                    break;
                            }
                        }
                        with (obj_fade_out)
                        {
                            if (alpha >= 1)
                            {
                                if (global.pause_screen_state == 99)
                                {
                                    if (obj_fade_out.alpha >= 2)
                                    {
                                        room_goto(rm_stage_select);
                                    }
                                }
                                else
                                {
                                    if (global.pause_screen == false)
                                    {
                                        global.pause_screen = true;
                                        global.pause_screen_state = 2;
                                        with (obj_menu_paused)
                                        {
                                            event_user(1);
                                        }
                                    }
                                    else
                                    {
                                        global.pause_screen = false;
                                        global.pause_screen_state = 4;
                                        global.hud_toggle = true;
                                    }
                                    fade = instance_create_depth(obj_camera.x, obj_camera.y, 0, obj_fade_in);
                                    fade.fade_speed = global.pause_screen_speed;
                                    instance_destroy();
                                }
                            }
                        }
                        if (global.input_start_pressed)
                        {
                            event_user(0);
                        }
                        if (global.pause_screen_state == 4 && !instance_exists(obj_fade_in))
                        {
                            global.pause_screen_state = 0;
                            global.pause = false;
                        }
                    }
                    else
                    {
                        switch (menu_position)
                        {
                            case 0:
                                if ((global.subtank_1 == 0 && tank_filling_full == false) || global.life == global.lifemax)
                                {
                                    tank_filling = -1;
                                    tank_filling_full = false;
                                }
                                else
                                {
                                    tank_filling++;
                                    if ((tank_filling % 3) == 0)
                                    {
                                        if (global.subtank_1 > 0)
                                        {
                                            global.subtank_1--;
                                        }
                                        global.life += 1;
                                        scr_make_sound(snd_energy_tank, 1, 1, false);
                                    }
                                }
                                break;
                            case 1:
                                if ((global.subtank_2 == 0 && tank_filling_full == false) || global.life == global.lifemax)
                                {
                                    tank_filling = -1;
                                    tank_filling_full = false;
                                }
                                else
                                {
                                    tank_filling++;
                                    if ((tank_filling % 3) == 0)
                                    {
                                        if (global.subtank_2 > 0)
                                        {
                                            global.subtank_2--;
                                        }
                                        global.life += 1;
                                        scr_make_sound(snd_energy_tank, 1, 1, false);
                                    }
                                }
                                break;
                            case 2:
                                var check_full = true;
                                tank_filling++;
                                if ((tank_filling % 3) == 0)
                                {
                                    for (var i = 0; i < 9; i++)
                                    {
                                        if (global.weapon[i] != 0)
                                        {
                                            if (global.weapon[i].ammo < global.weapon_ammo_max)
                                            {
                                                global.weapon[i].ammo++;
                                                check_full = false;
                                            }
                                        }
                                    }
                                    if (global.weapontank > 0)
                                    {
                                        global.weapontank--;
                                    }
                                    scr_make_sound(snd_weapon_tank, 1, 1, false);
                                }
                                else
                                {
                                    check_full = false;
                                }
                                if (check_full == true || (global.weapontank == 0 && tank_filling_full == false))
                                {
                                    tank_filling = -1;
                                    tank_filling_full = false;
                                }
                                break;
                        }
                    }
                    text_scrolling++;
                    break;
                case "Options":
                    if (global.pause_screen == true)
                    {
                        if (keyboard_check(vk_control) && keyboard_check_pressed(ord("D")))
                        {
                            defaults = true;
                            event_user(4);
                            scr_make_sound(snd_menu_equip, 1, 1, false);
                        }
                        if (global.music != snd_music_options && room == rm_stage_select)
                        {
                            if (global.music != "Off")
                            {
                                audio_stop_sound(global.music);
                            }
                            global.music = snd_music_options;
                        }
                        if (instance_exists(obj_prompt))
                        {
                            exit;
                        }
                        if (save_transition == false)
                        {
                            switch (global.pause_menu_sub)
                            {
                                case "Title":
                                    if (title_state > 0)
                                    {
                                        if (menu_position_horizontal == 0)
                                        {
                                            menu_length = 4;
                                            if (global.input_jump_pressed)
                                            {
                                                switch (menu_position)
                                                {
                                                    case 0:
                                                        save_transition = true;
                                                        scr_make_sound(snd_shoot_large, 1, 1, false);
                                                        audio_stop_sound(global.music);
                                                        global.music = "Off";
                                                        fade = instance_create_depth(0, 0, 0, obj_fade_out);
                                                        fade.fade_speed = 0.01;
                                                        break;
                                                    case 1:
                                                        global.pause_menu_sub = "Load Game";
                                                        menu_position = 0;
                                                        scr_make_sound(snd_menu_select, 1, 1, false);
                                                        save_import = 0;
                                                        save_file = false;
                                                        break;
                                                    case 2:
                                                        coop_lobby_age = 0;
                                                        coop_lobby_row = 0;
                                                        coop_lobby_pulse = 0;
                                                        coop_lobby_age = 0;
                                                        coop_lobby_row = 0;
                                                        coop_lobby_pulse = 0;
                                                        coop_lobby_attack_x = -1;
                                                        coop_lobby_attack_zero = -1;
                                                        global.pause_menu_sub = "Co-op";
                                                        menu_position = 0;
                                                        scr_make_sound(snd_menu_select, 1, 1, false);
                                                        break;
                                                    case 3:
                                                        global.pause_menu_sub = "Options";
                                                        menu_position = 1;
                                                        scr_make_sound(snd_menu_select, 1, 1, false);
                                                        break;
                                                    case 4:
                                                        event_user(3);
                                                        game_end();
                                                        break;
                                                }
                                            }
                                            else if (global.input_left_pressed)
                                            {
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                menu_position_horizontal = 1;
                                            }
                                        }
                                        else if (global.input_jump_pressed)
                                        {
                                            scr_make_sound(snd_menu_equip, 1, 1, false);
                                            if (global.locale < (ds_list_size(global.languages) - 1))
                                            {
                                                global.locale++;
                                            }
                                            else
                                            {
                                                global.locale = 0;
                                            }
                                            InitTranslations();
                                            event_user(3);
                                        }
                                        else if (global.input_right_pressed)
                                        {
                                            scr_make_sound(snd_menu_move, 1, 1, false);
                                            menu_position_horizontal = 0;
                                        }
                                    }
                                    else
                                    {
                                        if (global.input_start_pressed || global.input_jump_pressed)
                                        {
                                            title_state = 1;
                                            scr_make_sound(snd_turtloid_thunder, 1, 1, false);
                                            title_white_alpha = 1;
                                            instance_destroy(obj_fade_in);
                                            audio_stop_sound(snd_nightmare_heartbeat);
                                        }
                                        if (!audio_is_playing(snd_nightmare_heartbeat) && (pause_animate % 120) == 0)
                                        {
                                            scr_make_sound(snd_nightmare_heartbeat, 0.5, 1, false);
                                        }
                                    }
                                    break;
                                case "Options":
                                    menu_length = 5;
                                    if (room != rm_title)
                                    {
                                        menu_length = 6;
                                    }
                                    if (room != rm_stage_select && menu_position < 1)
                                    {
                                        menu_position = 1;
                                    }
                                    switch (menu_position)
                                    {
                                        case 0:
                                            if (global.input_jump_pressed)
                                            {
                                                global.pause_menu_sub = "Save Game";
                                                menu_position = 0;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                                save_import = 0;
                                                save_file = false;
                                            }
                                            break;
                                        case 1:
                                            if (global.input_jump_pressed)
                                            {
                                                global.pause_menu_sub = "Game";
                                                menu_position = 0;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 2:
                                            if (global.input_jump_pressed)
                                            {
                                                global.pause_menu_sub = "Audio";
                                                menu_position = 0;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 3:
                                            if (global.input_jump_pressed)
                                            {
                                                global.pause_menu_sub = "Visual";
                                                menu_position = 0;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 4:
                                            if (global.input_jump_pressed)
                                            {
                                                global.pause_menu_sub = "Controls";
                                                menu_position = 0;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 5:
                                            if (global.input_jump_pressed)
                                            {
                                                event_user(3);
                                                game_restart();
                                            }
                                            break;
                                        case 6:
                                            if (global.input_jump_pressed)
                                            {
                                                game_end();
                                            }
                                            break;
                                    }
                                    if (global.input_shoot_pressed && room != rm_stage_select)
                                    {
                                        event_user(3);
                                        if (room == rm_title)
                                        {
                                            global.pause_menu_sub = "Title";
                                            menu_position = 2;
                                        }
                                        else
                                        {
                                            global.pause_menu = "Paused";
                                            menu_position = 0;
                                        }
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                    }
                                    break;
                                case "Save Game":
                                    menu_length = 10;
                                    if (save_flash == 0)
                                    {
                                        if (global.input_jump_pressed)
                                        {
                                            if (file_exists("save_" + string(menu_position + 1) + ".txt"))
                                            {
                                                instance_create_depth(0, 0, 0, obj_prompt);
                                                scr_make_sound(snd_menu_denied, 1, 1, false);
                                            }
                                            else
                                            {
                                                event_user(5);
                                            }
                                        }
                                        else if (global.input_shoot_pressed)
                                        {
                                            global.pause_menu_sub = "Options";
                                            menu_position = 0;
                                            scr_make_sound(snd_menu_move, 1, 1, false);
                                        }
                                        else if (global.input_up_pressed || global.input_down_pressed)
                                        {
                                            save_import = 0;
                                            save_file = false;
                                        }
                                    }
                                    break;
                                case "Load Game":
                                    menu_length = file_exists("save_0.txt") ? 11 : 10;
                                    if (global.input_jump_pressed)
                                    {
                                        if (file_exists("save_" + string(tagteam_load_slot(menu_position)) + ".txt"))
                                        {
                                            scr_make_sound(snd_menu_equip, 1, 1, false);
                                            save_flash = 1;
                                            save_transition = true;
                                            audio_stop_sound(global.music);
                                            global.music = "Off";
                                            fade = instance_create_depth(0, 0, 0, obj_fade_out);
                                            fade.fade_speed = 0.01;
                                        }
                                        else
                                        {
                                            scr_make_sound(snd_menu_denied, 1, 1, false);
                                        }
                                    }
                                    else if (global.input_shoot_pressed)
                                    {
                                        global.pause_menu_sub = "Title";
                                        menu_position = 1;
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                    }
                                    else if (global.input_up_pressed || global.input_down_pressed)
                                    {
                                        save_import = 0;
                                        save_file = false;
                                    }
                                    break;
                                case "Game":
                                    menu_length = 6;
                                    if (global.ng_cycle > 0 && room == rm_stage_select)
                                    {
                                        menu_length = 7;
                                    }
                                    switch (menu_position)
                                    {
                                        case 0:
                                            if (global.input_jump_pressed)
                                            {
                                                if (global.indicators == true)
                                                {
                                                    global.indicators = false;
                                                }
                                                else
                                                {
                                                    global.indicators = true;
                                                }
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 1:
                                            if (global.input_jump_pressed)
                                            {
                                                if (global.cutscene_skip == true)
                                                {
                                                    global.cutscene_skip = false;
                                                }
                                                else
                                                {
                                                    global.cutscene_skip = true;
                                                }
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 2:
                                            if (global.input_jump_pressed)
                                            {
                                                global.lives_toggle = !global.lives_toggle;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 3:
                                            if (global.input_left_pressed && global.result_display > 0)
                                            {
                                                global.result_display--;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                            }
                                            else if (global.input_right_pressed && global.result_display < 2)
                                            {
                                                global.result_display++;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                            }
                                            break;
                                        case 4:
                                            if (global.input_jump_pressed)
                                            {
                                                global.gaichuuin_visability = !global.gaichuuin_visability;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 5:
                                            if (global.input_jump_pressed)
                                            {
                                                global.music_custom = !global.music_custom;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 6:
                                            if (global.input_jump_pressed)
                                            {
                                                global.x4_charge_shot = !global.x4_charge_shot;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 7:
                                            if ((ds_list_size(global.level_list) > 0 || ds_list_size(global.nightmare_progress) > 0) && (global.input_left_pressed || global.input_right_pressed))
                                            {
                                                scr_make_sound(snd_menu_denied, 1, 1, false);
                                                prompt = instance_create_depth(0, 0, 0, obj_prompt);
                                                prompt.action = "NG+ Change";
                                                prompt.action_description = localtext("prompt_6");
                                            }
                                            else if (global.input_left_pressed && global.ng_cycle > 1)
                                            {
                                                global.ng_cycle--;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                            }
                                            else if (global.input_right_pressed && global.ng_cycle < global.ng_cycle_max)
                                            {
                                                global.ng_cycle++;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                            }
                                            break;
                                    }
                                    if (global.input_shoot_pressed)
                                    {
                                        global.pause_menu_sub = "Options";
                                        menu_position = 1;
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        event_user(3);
                                    }
                                    break;
                                case "Audio":
                                    menu_length = 2;
                                    switch (menu_position)
                                    {
                                        case 0:
                                            if (global.input_left_pressed && global.volume_master > 0)
                                            {
                                                global.volume_master = clamp(global.volume_master - 0.1, 0, 1);
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                            }
                                            else if (global.input_right_pressed && global.volume_master < 1)
                                            {
                                                global.volume_master = clamp(global.volume_master + 0.1, 0, 1);
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                            }
                                            break;
                                        case 1:
                                            if (global.input_left_pressed && global.volume_music > 0)
                                            {
                                                global.volume_music = clamp(global.volume_music - 0.1, 0, 1);
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                            }
                                            else if (global.input_right_pressed && global.volume_music < 1)
                                            {
                                                global.volume_music = clamp(global.volume_music + 0.1, 0, 1);
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                            }
                                            break;
                                        case 2:
                                            if (global.input_left_pressed && global.volume_effect > 0)
                                            {
                                                global.volume_effect = clamp(global.volume_effect - 0.1, 0, 1);
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                            }
                                            else if (global.input_right_pressed && global.volume_effect < 1)
                                            {
                                                global.volume_effect = clamp(global.volume_effect + 0.1, 0, 1);
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                            }
                                            break;
                                    }
                                    if (global.input_shoot_pressed)
                                    {
                                        global.pause_menu_sub = "Options";
                                        menu_position = 2;
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        event_user(3);
                                    }
                                    break;
                                case "Visual":
                                    menu_length = 5;
                                    switch (menu_position)
                                    {
                                        case 0:
                                            if (global.input_left_pressed && window_mode > 0)
                                            {
                                                window_mode--;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                apply_video_settings();
                                                if (window_mode == 0)
                                                {
                                                    window_center();
                                                }
                                            }
                                            else if (global.input_right_pressed && window_mode < 2)
                                            {
                                                window_mode++;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                apply_video_settings();
                                            }
                                            break;
                                        case 1:
                                            if (window_mode == 0)
                                            {
                                                if (global.input_left_pressed && window_size > 1)
                                                {
                                                    window_size--;
                                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                                    apply_video_settings();
                                                    window_center();
                                                }
                                                else if (global.input_right_pressed && window_size < 4)
                                                {
                                                    window_size++;
                                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                                    apply_video_settings();
                                                    window_center();
                                                }
                                            }
                                            break;
                                        case 2:
                                            if (global.input_left_pressed && window_resolution > 0)
                                            {
                                                window_resolution--;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                apply_video_settings();
                                            }
                                            else if (global.input_right_pressed && window_resolution < 1)
                                            {
                                                window_resolution++;
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                apply_video_settings();
                                            }
                                            break;
                                        case 3:
                                            if (global.input_jump_pressed)
                                            {
                                                global.fps_display = !global.fps_display;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 4:
                                            if (global.input_left_pressed && global.ui_scale > 1)
                                            {
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                global.ui_scale -= 0.5;
                                            }
                                            if (global.input_right_pressed && global.ui_scale < 5)
                                            {
                                                scr_make_sound(snd_menu_move, 1, 1, false);
                                                global.ui_scale += 0.5;
                                            }
                                            break;
                                        case 5:
                                            if (global.input_jump_pressed)
                                            {
                                                global.vsync = !global.vsync;
                                                display_reset(0, global.vsync);
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                    }
                                    if (global.input_shoot_pressed)
                                    {
                                        global.pause_menu_sub = "Options";
                                        menu_position = 3;
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        event_user(3);
                                    }
                                    break;
                                case "Controls":
                                    menu_length = 5;
                                    switch (menu_position)
                                    {
                                        case 0:
                                            if (global.input_jump_pressed)
                                            {
                                                if (controller_toggle == true)
                                                {
                                                    controller_toggle = false;
                                                }
                                                else
                                                {
                                                    controller_toggle = true;
                                                }
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 1:
                                            if (global.input_jump_pressed)
                                            {
                                                global.pause_menu_sub = "Bindings";
                                                menu_position = 0;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 2:
                                            if (global.input_jump_pressed)
                                            {
                                                global.rapidfire = !global.rapidfire;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 3:
                                            if (global.input_jump_pressed)
                                            {
                                                global.autocharge = !global.autocharge;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                        case 4:
                                        case 5:
                                            if (global.input_jump_pressed)
                                            {
                                                tag_binding_mode = (menu_position == 4) ? 1 : 2;
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            break;
                                    }
                                    if (global.input_shoot_pressed)
                                    {
                                        global.pause_menu_sub = "Options";
                                        menu_position = 4;
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        event_user(3);
                                    }
                                    break;
                                case "Bindings":
                                    if (global.controller == true)
                                    {
                                        menu_length = 6;
                                        if (menu_position > menu_length)
                                        {
                                            menu_position = 0;
                                        }
                                    }
                                    else
                                    {
                                        menu_length = 18;
                                    }
                                    if (global.input_start_pressed)
                                    {
                                        if (menu_position != 11 && menu_position != 12)
                                        {
                                            scr_make_sound(snd_menu_select, 1, 1, false);
                                            key_select = true;
                                        }
                                        else
                                        {
                                            scr_make_sound(snd_menu_denied, 1, 1, false);
                                        }
                                    }
                                    else if (global.input_shoot_pressed)
                                    {
                                        if (room == rm_title && coop_controls_return)
                                        {
                                            coop_controls_return = false;
                                            global.pause_menu_sub = "Co-op";
                                            coop_lobby_row = 3;
                                            coop_lobby_cursor = 3;
                                            key_select = false;
                                            scr_make_sound(snd_menu_move, 1, 1, false);
                                            event_user(3);
                                            exit;
                                        }
                                        global.pause_menu_sub = "Controls";
                                        menu_position = 1;
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        event_user(3);
                                    }
                                    else if (global.input_right_pressed && menu_position < 8)
                                    {
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        menu_position += 11;
                                    }
                                    else if (global.input_left_pressed && menu_position >= 11)
                                    {
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                        menu_position -= 11;
                                    }
                                    break;
                            }
                            if (save_flash == 0 && menu_position_horizontal == 0)
                            {
                                if (global.input_up_pressed && menu_position > 0)
                                {
                                    if (!(global.pause_menu_sub == "Options" && room != rm_stage_select && menu_position == 1))
                                    {
                                        menu_position--;
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                    }
                                }
                                else if (global.input_down_pressed && menu_position < menu_length)
                                {
                                    menu_position++;
                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                }
                            }
                            if (room == rm_stage_select)
                            {
                                if (global.input_swap_right_pressed)
                                {
                                    menu_position = 0;
                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                    global.pause_menu = "Part Selection";
                                    global.pause_menu_sub = "Options";
                                    event_user(3);
                                }
                                else if (global.input_swap_left_pressed)
                                {
                                    menu_position = 0;
                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                    global.pause_menu = "Library";
                                    global.pause_menu_sub = "Options";
                                    event_user(3);
                                }
                            }
                        }
                        else if (obj_fade_out.alpha >= 1)
                        {
                            if (global.pause_menu_sub == "Title")
                            {
                                room_goto(rm_intro);
                            }
                            else
                            {
                                obj_manager.save_slot = tagteam_load_slot(menu_position);
                                with (obj_manager)
                                {
                                    event_user(1);
                                }
                            }
                            global.pause = false;
                        }
                        if (global.pause_menu_sub == "Title")
                        {
                            if (global.set_rendering == false)
                            {
                                if (global.input_swap_left_pressed)
                                {
                                    rendering_command++;
                                }
                                else if (global.input_swap_right_pressed && rendering_command == 3)
                                {
                                    global.set_rendering = true;
                                    scr_make_sound(snd_menu_equip, 1, 1, false);
                                }
                            }
                        }
                        else
                        {
                            rendering_command = 0;
                        }
                    }
                    break;
                case "Stage Select":
                    if (stageselect_state > 0)
                    {
                        if (stageselect_state == 2)
                        {
                            if (global.music != snd_music_stage_select)
                            {
                                if (global.music != "Off")
                                {
                                    audio_stop_sound(global.music);
                                }
                                global.music = snd_music_stage_select;
                            }
                            if (global.input_right_pressed && menu_position != 3 && menu_position != 7)
                            {
                                menu_position++;
                                scr_make_sound(snd_menu_move_2, 1, 1, false);
                                stageselect_bg_static = 0.5;
                            }
                            else if (global.input_left_pressed && menu_position != 0 && menu_position != 4)
                            {
                                menu_position--;
                                scr_make_sound(snd_menu_move_2, 1, 1, false);
                                stageselect_bg_static = 0.5;
                            }
                            else if (global.input_down_pressed && menu_position < 4)
                            {
                                menu_position += 4;
                                scr_make_sound(snd_menu_move_2, 1, 1, false);
                                stageselect_bg_static = 0.5;
                            }
                            else if (global.input_up_pressed && menu_position > 3)
                            {
                                menu_position -= 4;
                                scr_make_sound(snd_menu_move_2, 1, 1, false);
                                stageselect_bg_static = 0.5;
                            }
                            else if (global.input_jump_pressed)
                            {
                                scr_get_level(menu_position);
                                if (level_destination != "Nothing")
                                {
                                    stageselect_state = 3;
                                    scr_make_sound(snd_menu_equip, 1, 1, false);
                                    stageselect[menu_position].alpha = 1;
                                    fade = instance_create_depth(0, 0, 0, obj_fade_out);
                                    fade.fade_speed = 0.02;
                                }
                                else
                                {
                                    scr_make_sound(snd_menu_denied, 1, 1, false);
                                }
                            }
                            else if (global.input_swap_right_pressed)
                            {
                                menu_position = 0;
                                scr_make_sound(snd_menu_move, 1, 1, false);
                                global.pause_menu = "Library";
                            }
                            else if (global.input_swap_left_pressed)
                            {
                                menu_position = 0;
                                scr_make_sound(snd_menu_move, 1, 1, false);
                                global.pause_menu = "Part Selection";
                            }
                        }
                        else if (stageselect_state == 3)
                        {
                            if (obj_fade_out.alpha >= 2)
                            {
                                stageselect_state = 4;
                                if (ds_list_find_index(global.level_list, level_destination) == -1)
                                {
                                    global.level_completed = false;
                                }
                                else
                                {
                                    global.level_completed = true;
                                }
                                instance_create_depth(0, 0, 0, obj_cutscene_investigator);
                            }
                        }
                        else if (stageselect_state == 1)
                        {
                        }
                        if (stageselect_bg_swap > 0)
                        {
                            stageselect_bg_swap -= 0.02;
                        }
                        if (stageselect_bg_static > 0.05)
                        {
                            stageselect_bg_static -= 0.02;
                        }
                        if ((pause_animate % 5) == 0)
                        {
                            if (stageselect_entrance > 0)
                            {
                                stageselect_entrance--;
                                scr_make_sound(snd_menu_move, 1, 1.5, false);
                            }
                            else if (stageselect_state == 1)
                            {
                                stageselect_state = 2;
                                stageselect_bg_swap = 1;
                                scr_make_sound(snd_menu_boom, 1, 0.5, false);
                            }
                        }
                        for (var i = 0; i < 8; i++)
                        {
                            if (stageselect_entrance <= stageselect[i].position && stageselect[i].alpha > 0)
                            {
                                if (stageselect[i].alpha > 1)
                                {
                                    stageselect[i].alpha = 1;
                                }
                                else
                                {
                                    stageselect[i].alpha -= 0.1;
                                }
                            }
                        }
                    }
                    break;
                case "Part Selection":
                    if (global.music != snd_music_shop)
                    {
                        if (global.music != "Off")
                        {
                            audio_stop_sound(global.music);
                        }
                        global.music = snd_music_shop;
                    }
                    
                    function scr_menu_move(arg0)
                    {
                        if (global.input_up_pressed && arg0 > 0)
                        {
                            scr_make_sound(snd_menu_move, 1, 1, false);
                            if (global.pause_menu_sub == "Options")
                            {
                                menu_position--;
                            }
                            else
                            {
                                menu_position_sub--;
                            }
                        }
                        else if (global.input_down_pressed && arg0 < (length - 1))
                        {
                            scr_make_sound(snd_menu_move, 1, 1, false);
                            if (global.pause_menu_sub == "Options")
                            {
                                menu_position++;
                            }
                            else
                            {
                                menu_position_sub++;
                            }
                        }
                    }
                    
                    function scr_menu_scroll(arg0, arg1)
                    {
                        if (global.input_up_pressed && arg1 == 0 && scroll > 0)
                        {
                            scr_make_sound(snd_menu_move, 1, 1, false);
                            scroll--;
                        }
                        else if (global.input_down_pressed && arg1 == (length - 1) && ds_list_size(arg0) > (length + scroll))
                        {
                            scr_make_sound(snd_menu_move, 1, 1, false);
                            scroll++;
                        }
                    }
                    
                    if (instance_exists(obj_prompt))
                    {
                        exit;
                    }
                    if (travelling > 0)
                    {
                        if (travelling == 1 && obj_fade_out.alpha >= 2)
                        {
                            travelling = 2;
                            global.pause = false;
                            global.pause_screen = false;
                            global.pause_screen_state = 0;
                            room_goto(rm_training);
                        }
                        exit;
                    }
                    if (save_flash == 0)
                    {
                        switch (global.pause_menu_sub)
                        {
                            case "Options":
                                length = 4;
                                if (global.zero_unlock == true)
                                {
                                    length += 1;
                                }
                                scr_menu_move(menu_position);
                                if (global.input_jump_pressed)
                                {
                                    switch (menu_position)
                                    {
                                        case 0:
                                            if (ds_list_size(global.parts_owned) > 0)
                                            {
                                                global.pause_menu_sub = "Equip";
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                                ds_list_sort(global.parts_owned, true);
                                            }
                                            else
                                            {
                                                scr_make_sound(snd_menu_denied, 1, 1, false);
                                            }
                                            break;
                                        case 1:
                                            if (ds_list_size(global.parts_store) > 0)
                                            {
                                                global.pause_menu_sub = "Develop";
                                                scr_make_sound(snd_menu_select, 1, 1, false);
                                            }
                                            else
                                            {
                                                scr_make_sound(snd_menu_denied, 1, 1, false);
                                            }
                                            break;
                                        case 2:
                                            global.pause_menu_sub = "Armour";
                                            menu_position_sub = 0;
                                            scr_make_sound(snd_menu_select, 1, 1, false);
                                            break;
                                        case 3:
                                            travelling = 1;
                                            scr_make_sound(snd_menu_select, 1, 1, false);
                                            global.special_room = global.pause_menu;
                                            fade = instance_create_depth(0, 0, 0, obj_fade_out);
                                            fade.fade_speed = 0.05;
                                            break;
                                        case 4:
                                            scr_make_sound(snd_menu_equip, 1, 1, false);
                                            save_flash = 1;
                                            if (global.playable_character.name == "X")
                                            {
                                                global.playable_character = Character_Zero();
                                            }
                                            else
                                            {
                                                global.playable_character = Character_X();
                                            }
                                            for (var i = 0; i < ds_list_size(global.weapon_list); i++)
                                            {
                                                scr_weapon_get(ds_list_find_value(global.weapon_list, i), false);
                                            }
                                            break;
                                    }
                                    menu_position_sub = 0;
                                    scroll = 0;
                                }
                                break;
                            case "Armour":
                                var armour_rows = coop_armour_rows();
                                length = array_length(armour_rows);
                                menu_position_sub = clamp(menu_position_sub, 0, length - 1);
                                scr_menu_move(menu_position_sub);
                                if (global.input_left_pressed || global.input_right_pressed || global.input_jump_pressed)
                                {
                                    coop_armour_cycle(armour_rows[menu_position_sub], global.input_left_pressed ? -1 : 1);
                                }
                                if (global.input_shoot_pressed)
                                {
                                    global.pause_menu_sub = "Options";
                                    menu_position = 2;
                                    menu_position_sub = 0;
                                    coop_personal_save();
                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                }
                                break;
                            case "Equip":
                                length = ds_list_size(global.parts_owned);
                                if (length > length_limit)
                                {
                                    length = length_limit;
                                }
                                scr_menu_scroll(global.parts_owned, menu_position_sub);
                                scr_menu_move(menu_position_sub);
                                if (global.input_jump_pressed)
                                {
                                    var find = ds_list_find_value(global.parts_owned, menu_position_sub + scroll);
                                    if (find == 902 || find == 903)
                                    {
                                        tagteam_toggle_upgrade(find);
                                    }
                                    else if (ds_list_find_index(global.parts_equipped, find) == -1)
                                    {
                                        if (ds_list_size(global.parts_equipped) < global.parts_amount)
                                        {
                                            ds_list_add(global.parts_equipped, find);
                                            scr_make_sound(snd_menu_equip, 1, 1, false);
                                        }
                                        else
                                        {
                                            scr_make_sound(snd_menu_denied, 1, 1, false);
                                        }
                                    }
                                    else
                                    {
                                        var remove = ds_list_find_index(global.parts_equipped, find);
                                        ds_list_delete(global.parts_equipped, remove);
                                        scr_make_sound(snd_menu_move, 1, 1, false);
                                    }
                                }
                                else if (global.input_shoot_pressed)
                                {
                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                    menu_position_sub = 0;
                                    scroll = 0;
                                    global.pause_menu_sub = "Options";
                                }
                                break;
                            case "Develop":
                                length = ds_list_size(global.parts_store);
                                if (length > length_limit)
                                {
                                    length = length_limit;
                                }
                                scr_menu_scroll(global.parts_store, menu_position_sub);
                                scr_menu_move(menu_position_sub);
                                if (global.input_jump_pressed && ds_list_size(global.parts_store) > 0)
                                {
                                    var find = ds_list_find_value(global.parts_store, menu_position_sub + scroll);
                                    scr_get_part(find);
                                    if (global.nightmare_souls >= part_cost)
                                    {
                                        ds_list_add(global.parts_owned, find);
                                        global.nightmare_souls -= part_cost;
                                        if (find == 902 || find == 903)
                                        {
                                            tagteam_upgrade_purchase(find);
                                        }
                                        scr_make_sound(snd_menu_equip, 1, 1, false);
                                        var remove = ds_list_find_index(global.parts_store, find);
                                        ds_list_delete(global.parts_store, remove);
                                        if (find == 902 || find == 903)
                                        {
                                            with (obj_manager)
                                            {
                                                save_slot = 0;
                                                event_user(0);
                                            }
                                        }
                                        if (scroll > 0)
                                        {
                                            scroll--;
                                        }
                                        else if (menu_position_sub == (length - 1) && length > 1)
                                        {
                                            menu_position_sub--;
                                        }
                                    }
                                    else
                                    {
                                        scr_make_sound(snd_menu_denied, 1, 1, false);
                                    }
                                }
                                else if (global.input_shoot_pressed)
                                {
                                    scr_make_sound(snd_menu_move, 1, 1, false);
                                    menu_position_sub = 0;
                                    scroll = 0;
                                    global.pause_menu_sub = "Options";
                                }
                                break;
                        }
                        if (global.input_swap_right_pressed)
                        {
                            menu_position = 0;
                            scroll = 0;
                            text_scrolling = 0;
                            scr_make_sound(snd_menu_move, 1, 1, false);
                            global.pause_menu = "Stage Select";
                            global.pause_menu_sub = "Options";
                        }
                        else if (global.input_swap_left_pressed)
                        {
                            menu_position = 0;
                            scroll = 0;
                            text_scrolling = 0;
                            scr_make_sound(snd_menu_move, 1, 1, false);
                            global.pause_menu = "Options";
                            global.pause_menu_sub = "Options";
                        }
                    }
                    break;
                case "Library":
                    if (instance_exists(obj_cutscene_datalog))
                    {
                        exit;
                    }
                    if (travelling > 0)
                    {
                        if (travelling == 1 && obj_fade_out.alpha >= 2)
                        {
                            travelling = 2;
                            global.pause = false;
                            global.pause_screen = false;
                            global.pause_screen_state = 0;
                            global.training = true;
                            scr_weapon_get(ds_list_find_value(global.weapon_list, menu_position_sub + scroll), false);
                            room_goto(rm_weapon_get);
                        }
                        exit;
                    }
                    if (global.music != snd_music_library)
                    {
                        if (global.music != "Off")
                        {
                            audio_stop_sound(global.music);
                        }
                        global.music = snd_music_library;
                    }
                    
                    function scr_library_move(arg0)
                    {
                        if (global.input_up_pressed && arg0 > 0)
                        {
                            scr_make_sound(snd_menu_move, 1, 1, false);
                            if (global.pause_menu_sub == "Options")
                            {
                                menu_position--;
                            }
                            else
                            {
                                menu_position_sub--;
                            }
                        }
                        else if (global.input_down_pressed && arg0 < (length - 1))
                        {
                            scr_make_sound(snd_menu_move, 1, 1, false);
                            if (global.pause_menu_sub == "Options")
                            {
                                menu_position++;
                            }
                            else
                            {
                                menu_position_sub++;
                            }
                        }
                    }
                    
                    function scr_library_scroll(arg0, arg1)
                    {
                        if (global.input_up_pressed && arg1 == 0 && scroll > 0)
                        {
                            scr_make_sound(snd_menu_move, 1, 1, false);
                            scroll--;
                        }
                        else if (global.input_down_pressed && arg1 == (length - 1) && ds_list_size(arg0) > (length + scroll))
                        {
                            scr_make_sound(snd_menu_move, 1, 1, false);
                            scroll++;
                        }
                    }
                    
                    if (instance_exists(obj_prompt))
                    {
                        exit;
                    }
                    switch (global.pause_menu_sub)
                    {
                        case "Options":
                            length = 3;
                            if (ds_list_size(global.level_list) >= 5)
                            {
                                length += 1;
                            }
                            scr_library_move(menu_position);
                            if (global.input_jump_pressed)
                            {
                                switch (menu_position)
                                {
                                    case 0:
                                        if (ds_list_size(global.datalog_list) > 0)
                                        {
                                            global.pause_menu_sub = "Data Logs";
                                            scr_make_sound(snd_menu_select, 1, 1, false);
                                            ds_list_sort(global.datalog_list, true);
                                        }
                                        else
                                        {
                                            scr_make_sound(snd_menu_denied, 1, 1, false);
                                        }
                                        break;
                                    case 1:
                                        if (ds_list_size(global.result_store) > 0)
                                        {
                                            global.pause_menu_sub = "Level Performance";
                                            scr_make_sound(snd_menu_select, 1, 1, false);
                                        }
                                        else
                                        {
                                            scr_make_sound(snd_menu_denied, 1, 1, false);
                                        }
                                        break;
                                    case 2:
                                        if (ds_list_size(global.weapon_list) > 0)
                                        {
                                            global.pause_menu_sub = "Ability Details";
                                            scr_make_sound(snd_menu_select, 1, 1, false);
                                        }
                                        else
                                        {
                                            scr_make_sound(snd_menu_denied, 1, 1, false);
                                        }
                                        break;
                                    case 3:
                                        scr_make_sound(snd_menu_denied, 1, 1, false);
                                        prompt = instance_create_depth(0, 0, 0, obj_prompt);
                                        prompt.action = "New Game Plus";
                                        prompt.action_description = localtext("prompt_3");
                                        break;
                                }
                                menu_position_sub = 0;
                                scroll = 0;
                            }
                            break;
                        case "Data Logs":
                            length = ds_list_size(global.datalog_list);
                            if (length > length_limit)
                            {
                                length = length_limit;
                            }
                            scr_library_scroll(global.datalog_list, menu_position_sub);
                            scr_library_move(menu_position_sub);
                            if (global.input_jump_pressed)
                            {
                                cutscene = instance_create_depth(0, 0, 0, obj_cutscene_datalog);
                                cutscene.datalog = ds_list_find_value(global.datalog_list, menu_position_sub + scroll);
                            }
                            else if (global.input_shoot_pressed)
                            {
                                scr_make_sound(snd_menu_move, 1, 1, false);
                                menu_position_sub = 0;
                                scroll = 0;
                                global.pause_menu_sub = "Options";
                            }
                            break;
                        case "Level Performance":
                            length = ds_list_size(global.result_store);
                            if (length > 5)
                            {
                                length = 5;
                            }
                            scr_library_scroll(global.result_store, menu_position_sub);
                            scr_library_move(menu_position_sub);
                            if (global.input_shoot_pressed)
                            {
                                scr_make_sound(snd_menu_move, 1, 1, false);
                                menu_position_sub = 0;
                                scroll = 0;
                                global.pause_menu_sub = "Options";
                                with (obj_particle_gui)
                                {
                                    instance_destroy();
                                }
                            }
                            if (sparkle_fade > 0)
                            {
                                sparkle_fade--;
                            }
                            else
                            {
                                sparkle_fade = 240;
                            }
                            break;
                        case "Ability Details":
                            length = ds_list_size(global.weapon_list);
                            if (length > length_limit)
                            {
                                length = length_limit;
                            }
                            scr_library_scroll(global.weapon_list, menu_position_sub);
                            scr_library_move(menu_position_sub);
                            if (global.input_jump_pressed)
                            {
                                travelling = 1;
                                global.special_room = global.pause_menu;
                                scr_make_sound(snd_menu_select, 1, 1, false);
                                fade = instance_create_depth(0, 0, 0, obj_fade_out);
                                fade.fade_speed = 0.05;
                            }
                            else if (global.input_shoot_pressed)
                            {
                                scr_make_sound(snd_menu_move, 1, 1, false);
                                menu_position_sub = 0;
                                scroll = 0;
                                global.pause_menu_sub = "Options";
                            }
                            break;
                    }
                    if (global.input_swap_right_pressed)
                    {
                        menu_position = 0;
                        scroll = 0;
                        text_scrolling = 0;
                        scr_make_sound(snd_menu_move, 1, 1, false);
                        global.pause_menu = "Options";
                        global.pause_menu_sub = "Options";
                        with (obj_particle_gui)
                        {
                            instance_destroy();
                        }
                    }
                    else if (global.input_swap_left_pressed)
                    {
                        menu_position = 0;
                        scroll = 0;
                        text_scrolling = 0;
                        scr_make_sound(snd_menu_move, 1, 1, false);
                        global.pause_menu = "Stage Select";
                        global.pause_menu_sub = "Options";
                        with (obj_particle_gui)
                        {
                            instance_destroy();
                        }
                    }
                    break;
            }
        }
        else
        {
            if (global.pause_delay > 0)
            {
                global.pause_delay--;
                if (global.pause_delay == 0)
                {
                    global.pause = false;
                }
            }
            if (global.pause_healing > 0)
            {
                if (global.life < global.pause_healing)
                {
                    global.life += 0.5;
                    scr_make_sound(snd_healing, 0.5, 1, false);
                }
                else
                {
                    global.pause = false;
                    global.pause_healing = 0;
                }
            }
        }
    }
    else if (global.controller == true)
    {
        if (global.input_start_pressed)
        {
            scr_make_sound(snd_menu_move, 1, 1, false);
            key_select = false;
        }
        if (gamepad_button_check_pressed(0, gp_face1))
        {
            scr_gamepad_check(32769);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        else if (gamepad_button_check_pressed(0, gp_face2))
        {
            scr_gamepad_check(32770);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        else if (gamepad_button_check_pressed(0, gp_face3))
        {
            scr_gamepad_check(32771);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        else if (gamepad_button_check_pressed(0, gp_face4))
        {
            scr_gamepad_check(32772);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        else if (gamepad_button_check_pressed(0, gp_shoulderl))
        {
            scr_gamepad_check(32773);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        else if (gamepad_button_check_pressed(0, gp_shoulderlb))
        {
            scr_gamepad_check(32775);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        else if (gamepad_button_check_pressed(0, gp_shoulderr))
        {
            scr_gamepad_check(32774);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        else if (gamepad_button_check_pressed(0, gp_shoulderrb))
        {
            scr_gamepad_check(32776);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        else if (gamepad_button_check_pressed(0, gp_stickl))
        {
            scr_gamepad_check(32779);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        else if (gamepad_button_check_pressed(0, gp_stickr))
        {
            scr_gamepad_check(32780);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        else if (gamepad_button_check_pressed(0, gp_select))
        {
            scr_gamepad_check(32777);
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
    }
    else if (keyboard_check_pressed(vk_anykey))
    {
        if (global.input_start_pressed || global.input_select_pressed)
        {
            scr_make_sound(snd_menu_denied, 1, 1, false);
        }
        else
        {
            keyboard[menu_position] = keyboard_key;
            scr_make_sound(snd_menu_equip, 1, 1, false);
        }
        key_select = false;
    }
}
else if (unpause == true)
{
    unpause = false;
    for (var index = 0; index < array_length(arr_alarms); index++)
    {
        try
        {
            var instance = arr_alarms[index].instance;
            var alarm_index = arr_alarms[index].index;
            var value = arr_alarms[index].value;
            instance.alarm[alarm_index] = value;
        }
        catch (_exception)
        {
        }
    }
    for (var index = 0; index < array_length(arr_speed); index++)
    {
        try
        {
            var instance = arr_speed[index].instance;
            var value = arr_speed[index].value;
            instance.speed = value;
        }
        catch (_exception)
        {
        }
    }
    for (var index = 0; index < array_length(arr_animate); index++)
    {
        try
        {
            var instance = arr_animate[index].instance;
            var value = arr_animate[index].value;
            instance.image_speed = value;
        }
        catch (_exception)
        {
        }
    }
    for (var index = 0; index < array_length(arr_gravity); index++)
    {
        try
        {
            var instance = arr_gravity[index].instance;
            var value = arr_gravity[index].value;
            instance.gravity = value;
        }
        catch (_exception)
        {
        }
    }
    arr_alarms = [];
    arr_speed = [];
    arr_animate = [];
    arr_gravity = [];
}
if (save_flash > 0)
{
    save_flash -= 0.05;
}
if (room == rm_title && global.pause_screen == true)
{
    if (global.pause_menu_sub != "Co-op" && !coop_controls_return && global.music != snd_music_title && title_state > 0 && save_transition == false)
    {
        if (global.music != "Off")
        {
            audio_stop_sound(global.music);
        }
        global.music = snd_music_title;
    }
    if (global.pause_menu_sub != "Co-op" && !audio_is_playing(snd_ambience_nightmarestorm))
    {
        scr_make_sound(snd_ambience_nightmarestorm, 1, 1, true);
    }
    if (save_transition == true)
    {
        audio_sound_gain(snd_ambience_nightmarestorm, 0, 2000);
    }
    else
    {
        audio_sound_gain(snd_ambience_nightmarestorm, (global.volume_effect + (global.volume_effect * 1)) * global.volume_master, 500);
    }
    if (title_state > 0)
    {
        if (title_lightning_strike < title_lightning_delay)
        {
            title_lightning_strike++;
        }
        else
        {
            title_lightning_delay = 60 + irandom(60);
            title_lightning_strike = 0;
            title_lightning = 
            {
                _x: random_range(-170, 170),
                _y: random_range(-90, 90),
                alpha: 1,
                angle: irandom(359),
                colour: choose(255, 16711680)
            };
        }
        if (title_lightning.alpha > 0)
        {
            title_lightning.alpha -= 0.02;
        }
        if (title_thundercrack < title_thundercrack_delay)
        {
            title_thundercrack++;
        }
        else
        {
            scr_make_sound(snd_thundercrack, 1, random_range(0.5, 1.5), false);
            title_thundercrack = 0;
            title_thundercrack_delay = 240 + irandom(240);
        }
    }
    var scale = global.ui_scale / 1.25;
    if (global.pause_menu_sub != "Title")
    {
        title_eye_x += ((display_mouse_get_x() - title_eye_x) * 0.005);
        title_eye_y += ((display_mouse_get_y() - title_eye_y) * 0.005);
    }
    else
    {
        title_eye_x += (((display_get_gui_width() / 2) - title_eye_x) * 0.02);
        title_eye_y += (((display_get_gui_height() / 2) - title_eye_y) * 0.02);
    }
    title_eye_x = clamp(title_eye_x, (display_get_gui_width() / 2) - (45 * scale), (display_get_gui_width() / 2) + (45 * scale));
    title_eye_y = clamp(title_eye_y, (display_get_gui_height() / 2) - (5 * scale), (display_get_gui_height() / 2) + (40 * scale));
    if (global.pause_menu_sub == "Title" && (pause_animate % 5) == 0 && title_state > 0)
    {
        offset_x = 0;
        offset_y = 0;
        var offset_chance = irandom(3);
        var offset_range = 8;
        if (offset_chance == 0)
        {
            offset_x = random_range(-offset_range, offset_range) * scale;
            offset_y = random_range(-offset_range, offset_range) * scale;
        }
        afterimage = instance_create_depth((display_get_gui_width() / 2) + offset_x, ((display_get_gui_height() / 2) - (60 * scale)) + offset_y, depth + 10, obj_afterimage_gui);
        afterimage.image_blend = choose(c_blue, c_red);
        afterimage.sprite_index = spr_title;
        afterimage.image_index = global.language_title;
        afterimage.image_xscale = scale;
        afterimage.image_yscale = scale;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
