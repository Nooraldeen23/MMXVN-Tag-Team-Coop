function coop_original_get_input()
{
    var paused_controls = false;
    if (global.pause == true)
    {
        if (global.pause_screen == true)
        {
            paused_controls = true;
        }
    }
    global.input_up = keyboard_check(button_up) || gamepad_button_check_sdl(0, button_up_2) || gamepad_axis_value_sdl(0, button_up) < -0.7;
    global.input_up_released = keyboard_check_released(button_up) || gamepad_button_check_released_sdl(0, button_up_2) || gamepad_axis_value_sdl(0, button_up) < -0.7;
    global.input_up_pressed = keyboard_check_pressed(button_up);
    global.input_down_pressed = keyboard_check_pressed(button_down);
    global.input_down = keyboard_check(button_down) || gamepad_button_check_sdl(0, button_down_2) || gamepad_axis_value_sdl(0, button_down) > 0.7;
    global.input_down_released = keyboard_check_released(button_down) || gamepad_button_check_released_sdl(0, button_down_2) || gamepad_axis_value_sdl(0, button_down) > 0.7;
    global.input_left_pressed = keyboard_check_pressed(button_left);
    global.input_left = keyboard_check(button_left) || gamepad_button_check_sdl(0, button_left_2) || gamepad_axis_value_sdl(0, button_left) < -0.7;
    global.input_left_released = keyboard_check_released(button_left) || gamepad_button_check_released_sdl(0, button_left_2) || gamepad_axis_value_sdl(0, button_left) < -0.7;
    global.input_right_pressed = keyboard_check_pressed(button_right);
    global.input_right = keyboard_check(button_right) || gamepad_button_check_sdl(0, button_right_2) || gamepad_axis_value_sdl(0, button_right) > 0.7;
    global.input_right_released = keyboard_check_released(button_right) || gamepad_button_check_released_sdl(0, button_right_2) || gamepad_axis_value_sdl(0, button_right) > 0.7;
    if (global.controller == true)
    {
        if (jump_trigger == false)
        {
            if (gamepad_axis_value_sdl(0, button_up) < -obj_menu_paused.controller_deadzone)
            {
                global.input_up_pressed = gamepad_axis_value_sdl(0, button_up) < 0 || gamepad_button_check_pressed_sdl(0, button_up_2);
            }
            else if (gamepad_axis_value_sdl(0, button_down) > obj_menu_paused.controller_deadzone)
            {
                global.input_down_pressed = gamepad_axis_value_sdl(0, button_down) > 0 || gamepad_button_check_pressed_sdl(0, button_down_2);
            }
            else if (gamepad_axis_value_sdl(0, button_left) < -obj_menu_paused.controller_deadzone)
            {
                global.input_left_pressed = gamepad_axis_value_sdl(0, button_left) < 0 || gamepad_button_check_pressed_sdl(0, button_left_2);
            }
            else if (gamepad_axis_value_sdl(0, button_right) > obj_menu_paused.controller_deadzone)
            {
                global.input_right_pressed = gamepad_axis_value_sdl(0, button_right) > 0 || gamepad_button_check_pressed_sdl(0, button_right_2);
            }
            if (gamepad_axis_value_sdl(0, 32786) > obj_menu_paused.controller_deadzone || gamepad_axis_value_sdl(0, 32786) < -obj_menu_paused.controller_deadzone || gamepad_axis_value_sdl(0, 32785) > obj_menu_paused.controller_deadzone || gamepad_axis_value_sdl(0, 32785) < -obj_menu_paused.controller_deadzone)
            {
                jump_trigger = true;
            }
        }
        else
        {
            global.input_up_pressed = gamepad_button_check_pressed_sdl(0, button_up_2);
            global.input_down_pressed = gamepad_button_check_pressed_sdl(0, button_down_2);
            global.input_left_pressed = gamepad_button_check_pressed_sdl(0, button_left_2);
            global.input_right_pressed = gamepad_button_check_pressed_sdl(0, button_right_2);
        }
        if (gamepad_axis_value_sdl(0, 32786) < 0.3 && gamepad_axis_value_sdl(0, 32786) > -0.3 && gamepad_axis_value_sdl(0, 32785) < 0.3 && gamepad_axis_value_sdl(0, 32785) > -0.3)
        {
            global.input_up_pressed = gamepad_button_check_pressed_sdl(0, button_up_2);
            global.input_down_pressed = gamepad_button_check_pressed_sdl(0, button_down_2);
            global.input_left_pressed = gamepad_button_check_pressed_sdl(0, button_left_2);
            global.input_right_pressed = gamepad_button_check_pressed_sdl(0, button_right_2);
            jump_trigger = false;
        }
    }
    else if (paused_controls == true)
    {
        global.input_up_pressed = keyboard_check_pressed(button_up_2);
        global.input_down_pressed = keyboard_check_pressed(button_down_2);
        global.input_left_pressed = keyboard_check_pressed(button_left_2);
        global.input_right_pressed = keyboard_check_pressed(button_right_2);
    }
    if (paused_controls == true)
    {
        global.input_shoot_pressed = keyboard_check_pressed(button_shoot_2) || gamepad_button_check_pressed_sdl(0, button_shoot_2);
    }
    else
    {
        global.input_shoot = keyboard_check(button_shoot) || gamepad_button_check_sdl(0, button_shoot);
        global.input_shoot_pressed = keyboard_check_pressed(button_shoot) || gamepad_button_check_pressed_sdl(0, button_shoot);
        global.input_shoot_released = keyboard_check_released(button_shoot) || gamepad_button_check_released_sdl(0, button_shoot);
    }
    if (paused_controls == true)
    {
        global.input_jump_pressed = keyboard_check_pressed(button_jump_2) || gamepad_button_check_pressed_sdl(0, button_jump_2);
    }
    else
    {
        global.input_jump = keyboard_check(button_jump) || gamepad_button_check_sdl(0, button_jump);
        global.input_jump_pressed = keyboard_check_pressed(button_jump) || gamepad_button_check_pressed_sdl(0, button_jump);
        global.input_jump_released = keyboard_check_released(button_jump) || gamepad_button_check_released_sdl(0, button_jump);
    }
    if (paused_controls == true)
    {
        global.input_special_pressed = keyboard_check_pressed(button_special_2) || gamepad_button_check_pressed_sdl(0, button_special_2);
    }
    else
    {
        global.input_special = keyboard_check(button_special) || gamepad_button_check_sdl(0, button_special);
        global.input_special_pressed = keyboard_check_pressed(button_special) || gamepad_button_check_pressed_sdl(0, button_special);
        global.input_special_released = keyboard_check_released(button_special) || gamepad_button_check_released_sdl(0, button_special);
    }
    global.input_dash = keyboard_check(button_dash) || gamepad_button_check_sdl(0, button_dash);
    global.input_dash_pressed = keyboard_check_pressed(button_dash) || gamepad_button_check_pressed_sdl(0, button_dash);
    global.input_dash_released = keyboard_check_released(button_dash) || gamepad_button_check_released_sdl(0, button_dash);
    global.input_giga = keyboard_check(button_giga) || gamepad_button_check_sdl(0, button_giga);
    global.input_giga_pressed = keyboard_check_pressed(button_giga) || gamepad_button_check_pressed_sdl(0, button_giga);
    global.input_giga_released = keyboard_check_released(button_giga) || gamepad_button_check_released_sdl(0, button_giga);
    global.input_swap_left = keyboard_check(button_swap_left) || gamepad_button_check_sdl(0, button_swap_left);
    global.input_swap_left_pressed = keyboard_check_pressed(button_swap_left) || gamepad_button_check_pressed_sdl(0, button_swap_left);
    global.input_swap_left_released = keyboard_check_released(button_swap_left) || gamepad_button_check_released_sdl(0, button_swap_left);
    global.input_swap_right = keyboard_check(button_swap_right) || gamepad_button_check_sdl(0, button_swap_right);
    global.input_swap_right_pressed = keyboard_check_pressed(button_swap_right) || gamepad_button_check_pressed_sdl(0, button_swap_right);
    global.input_swap_right_released = keyboard_check_released(button_swap_right) || gamepad_button_check_released_sdl(0, button_swap_right);
    global.input_start = keyboard_check(button_start) || gamepad_button_check_sdl(0, button_start);
    global.input_start_pressed = keyboard_check_pressed(button_start) || gamepad_button_check_pressed_sdl(0, button_start);
    global.input_start_released = keyboard_check_released(button_start) || gamepad_button_check_released_sdl(0, button_start);
    global.input_select = keyboard_check(button_select) || gamepad_button_check_sdl(0, button_select);
    global.input_select_pressed = keyboard_check_pressed(button_select) || gamepad_button_check_pressed_sdl(0, button_select);
    global.input_select_released = keyboard_check_released(button_select) || gamepad_button_check_released_sdl(0, button_select);
    coop_buddy_input();
    if (coop_client() && room == rm_weapon_get)
    {
        global.input_start_pressed = false;
    }
    if (coop_client() && room == rm_stage_select && global.pause_menu == "Stage Select")
    {
        global.input_jump_pressed = false;
    }
}

function scr_keybinds()
{
    key[9] = "Tab";
    key[8] = "Backspace";
    key[160] = "Left Shift";
    key[162] = "Left Control";
    key[164] = "Left Alt";
    key[165] = "Right Alt";
    key[92] = "Right Windows Key";
    key[163] = "Right Control";
    key[161] = "Right Shift";
    key[12] = "Num 5";
    key[13] = "Enter";
    key[16] = "Shift";
    key[17] = "Control";
    key[18] = "Alt";
    key[19] = "Pause";
    key[20] = "Capslock";
    key[32] = "Space";
    key[33] = "Page up";
    key[34] = "Page down";
    key[35] = "End";
    key[36] = "Home";
    key[27] = "Escape";
    key[37] = "Left";
    key[38] = "Up";
    key[39] = "Right";
    key[40] = "Down";
    key[45] = "Insert";
    key[46] = "Delete";
    key[48] = "0";
    key[49] = "1";
    key[50] = "2";
    key[51] = "3";
    key[52] = "4";
    key[53] = "5";
    key[54] = "6";
    key[55] = "7";
    key[56] = "8";
    key[57] = "9";
    key[65] = "A";
    key[66] = "B";
    key[67] = "C";
    key[68] = "D";
    key[69] = "E";
    key[70] = "F";
    key[71] = "G";
    key[72] = "H";
    key[73] = "I";
    key[74] = "J";
    key[75] = "K";
    key[76] = "L";
    key[77] = "M";
    key[78] = "N";
    key[79] = "O";
    key[80] = "P";
    key[81] = "Q";
    key[82] = "R";
    key[83] = "S";
    key[84] = "T";
    key[85] = "U";
    key[86] = "V";
    key[87] = "W";
    key[88] = "X";
    key[89] = "Y";
    key[90] = "Z";
    key[91] = "Windows Key";
    key[93] = "Context Menu";
    key[96] = "0";
    key[97] = "1";
    key[98] = "2";
    key[99] = "3";
    key[100] = "4";
    key[101] = "5";
    key[102] = "6";
    key[103] = "7";
    key[104] = "8";
    key[105] = "9";
    key[106] = "Num *";
    key[107] = "Num +";
    key[109] = "Num -";
    key[110] = "Num .";
    key[111] = "Num /";
    key[112] = "F1";
    key[113] = "F2";
    key[114] = "F3";
    key[115] = "F4";
    key[116] = "F5";
    key[117] = "F6";
    key[118] = "F7";
    key[119] = "F8";
    key[120] = "F9";
    key[121] = "F10";
    key[122] = "F11";
    key[123] = "F12";
    key[144] = "NUMLOCK";
    key[173] = "Mute";
    key[173] = "Volume Down";
    key[173] = "Volume Up";
    key[186] = ";";
    key[187] = "=";
    key[188] = ",";
    key[189] = "-";
    key[190] = ".";
    key[191] = "/";
    key[192] = "'";
    key[219] = "[";
    key[221] = "]";
    key[222] = "#";
    key[223] = "`";
}

function scr_controllerbinds()
{
    var key = argument[0];
    button = "Unknown";
    switch (key)
    {
        case 32769:
            button = "A";
            break;
        case 32770:
            button = "B";
            break;
        case 32771:
            button = "X";
            break;
        case 32772:
            button = "Y";
            break;
        case 32773:
            button = "LB";
            break;
        case 32775:
            button = "LT";
            break;
        case 32774:
            button = "RB";
            break;
        case 32776:
            button = "RT";
            break;
        case 32779:
            button = "L3";
            break;
        case 32780:
            button = "R3";
            break;
        case 32777:
            button = "Select";
            break;
        case 32781:
            button = "Dpad Up";
            break;
        case 32782:
            button = "Dpad Down";
            break;
        case 32783:
            button = "Dpad Left";
            break;
        case 32784:
            button = "Dpad Right";
            break;
    }
    return button;
}

function scr_gamepad_check(arg0)
{
    arg0 = argument[0];
    controller[menu_position + 4] = arg0;
    key_select = false;
}

function scr_get_direction()
{
    temp_direction = argument[0];
    var haxis = gamepad_axis_value_sdl(0, 32785);
    var vaxis = gamepad_axis_value_sdl(0, 32786);
    if (global.controller == true)
    {
        if (global.input_up || global.input_down || global.input_left || global.input_right)
        {
            temp_direction = point_direction(0, 0, haxis, vaxis);
        }
    }
    if (haxis < obj_menu_paused.controller_deadzone && haxis > -obj_menu_paused.controller_deadzone && vaxis < obj_menu_paused.controller_deadzone && vaxis > -obj_menu_paused.controller_deadzone)
    {
        if (global.input_left)
        {
            temp_direction = 180;
            if (global.input_down)
            {
                temp_direction = 225;
            }
            else if (global.input_up)
            {
                temp_direction = 135;
            }
        }
        else if (global.input_right)
        {
            temp_direction = 0;
            if (global.input_down)
            {
                temp_direction = -45;
            }
            else if (global.input_up)
            {
                temp_direction = 45;
            }
        }
        else if (global.input_up)
        {
            temp_direction = 90;
        }
        else if (global.input_down)
        {
            temp_direction = -90;
        }
    }
    return temp_direction;
}

function tagteam_load_slot(arg0)
{
    return arg0 + (file_exists("save_0.txt") ? 0 : 1);
}

function tagteam_key_name(arg0)
{
    if ((arg0 >= 65 && arg0 <= 90) || (arg0 >= 48 && arg0 <= 57))
    {
        return chr(arg0);
    }
    if (arg0 >= 112 && arg0 <= 123)
    {
        return "F" + string(arg0 - 111);
    }
    switch (arg0)
    {
        case 32:
            return "SPACE";
        case 16:
            return "SHIFT";
        case 160:
            return "LSHIFT";
        case 161:
            return "RSHIFT";
        case 17:
            return "CTRL";
        case 162:
            return "LCTRL";
        case 163:
            return "RCTRL";
        case 18:
            return "ALT";
        case 164:
            return "LALT";
        case 165:
            return "RALT";
        case 9:
            return "TAB";
        case 8:
            return "BACKSPACE";
        case 13:
            return "ENTER";
        case 37:
            return "LEFT";
        case 38:
            return "UP";
        case 39:
            return "RIGHT";
        case 40:
            return "DOWN";
        case 45:
            return "INSERT";
        case 46:
            return "DELETE";
        case 36:
            return "HOME";
        case 35:
            return "END";
        case 33:
            return "PGUP";
        case 34:
            return "PGDN";
        case 186:
            return ";";
        case 187:
            return "=";
        case 188:
            return ",";
        case 189:
            return "-";
        case 190:
            return ".";
        case 191:
            return "/";
        case 192:
            return "'";
        case 219:
            return "[";
        case 221:
            return "]";
        case 222:
            return "#";
        case 223:
            return "`";
    }
    return "KEY " + string(arg0);
}

function tagteam_has_sigma_saber()
{
    return false;
}

function tagteam_has_ultimate_buster()
{
    return false;
}

function tagteam_refresh_energy_capacity()
{
    if (!instance_exists(obj_manager) || !variable_global_exists("weapon_ammo_max"))
    {
        exit;
    }
    var base_capacity = obj_manager.base_weapon_ammo_max;
    if (global.powertank > 0)
    {
        base_capacity = ceil(base_capacity * 1.25);
    }
    var doubled = (global.playable_character.name == "X") ? tagteam_has_ultimate_buster() : tagteam_has_sigma_saber();
    var next_capacity = base_capacity * (doubled ? 2 : 1);
    var previous_capacity = global.weapon_ammo_max;
    if (previous_capacity != next_capacity && previous_capacity > 0)
    {
        for (var i = 1; i < array_length(global.weapon); i++)
        {
            if (global.weapon[i].ammo >= 0)
            {
                global.weapon[i].ammo = clamp((global.weapon[i].ammo / previous_capacity) * next_capacity, 0, next_capacity);
            }
        }
        global.weapon_ammo_max = next_capacity;
    }
}

function tagteam_sigma_shot(arg0, arg1, arg2, arg3)
{
    var b = instance_create_layer(arg0, arg1, "Projectiles", obj_tag_sigma_orb);
    b.direction = arg2;
    b.speed = arg3;
    return b;
}

function tagteam_sigma_enter(arg0, arg1, arg2)
{
    with (arg0)
    {
        sig_state = arg1;
        sig_timer = 0;
        sig_anim = variable_struct_get(sig_anims, arg2);
        sprite_index = sig_anim.sprite;
        image_index = 0;
        image_speed = 0;
    }
}

function tagteam_sigma_animations()
{
    return 
    {
        stop: 
        {
            sprite: spr_tag_copy_stop,
            ticks: [6],
            duration: 6
        },
        talk: 
        {
            sprite: spr_tag_copy_talk,
            ticks: [7, 7],
            duration: 14
        },
        appear: 
        {
            sprite: spr_tag_copy_appear,
            ticks: [5, 3, 5, 15, 3, 3, 3],
            duration: 37
        },
        appear_loop: 
        {
            sprite: spr_tag_copy_appear_loop,
            ticks: [3, 3, 3, 3, 3, 3, 3, 3],
            duration: 24
        },
        appear_end: 
        {
            sprite: spr_tag_copy_appear_end,
            ticks: [3, 3, 3, 3, 3, 3, 3, 40, 5, 5, 5],
            duration: 76
        },
        idle: 
        {
            sprite: spr_tag_copy_idle,
            ticks: [5],
            duration: 5
        },
        dash_prepare: 
        {
            sprite: spr_tag_copy_dash_prepare,
            ticks: [3, 5, 3, 2, 2, 2],
            duration: 17
        },
        dash_prepare_loop: 
        {
            sprite: spr_tag_copy_dash_prepare_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        dash_start: 
        {
            sprite: spr_tag_copy_dash_start,
            ticks: [3, 5, 2, 2, 2],
            duration: 14
        },
        dash_start_loop: 
        {
            sprite: spr_tag_copy_dash_start_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        dash_slash_1: 
        {
            sprite: spr_tag_copy_dash_slash_1,
            ticks: [3, 3, 3, 2, 2, 2],
            duration: 15
        },
        dash_slash_1_loop: 
        {
            sprite: spr_tag_copy_dash_slash_1_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        dash_start_2: 
        {
            sprite: spr_tag_copy_dash_start_2,
            ticks: [3, 5, 2, 2, 2],
            duration: 14
        },
        dash_start_2_loop: 
        {
            sprite: spr_tag_copy_dash_start_2_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        dash_slash_2: 
        {
            sprite: spr_tag_copy_dash_slash_2,
            ticks: [3, 3, 3, 2, 2, 2],
            duration: 15
        },
        dash_slash_2_loop: 
        {
            sprite: spr_tag_copy_dash_slash_2_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        dash_slash_2_end: 
        {
            sprite: spr_tag_copy_dash_slash_2_end,
            ticks: [5, 5, 5, 5],
            duration: 20
        },
        throw_prepare: 
        {
            sprite: spr_tag_copy_throw_prepare,
            ticks: [5, 5, 3, 3, 2, 2, 2],
            duration: 22
        },
        throw_prepare_loop: 
        {
            sprite: spr_tag_copy_throw_prepare_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        throw_start: 
        {
            sprite: spr_tag_copy_throw_start,
            ticks: [3, 3, 3, 3],
            duration: 12
        },
        throw: 
        {
            sprite: spr_tag_copy_throw,
            ticks: [3, 3, 3, 3, 15, 5, 5, 4, 5, 5],
            duration: 51
        },
        low_dash_prepare: 
        {
            sprite: spr_tag_copy_low_dash_prepare,
            ticks: [5, 5, 3, 3, 5, 3, 2, 2, 2],
            duration: 30
        },
        low_dash_prepare_loop: 
        {
            sprite: spr_tag_copy_low_dash_prepare_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        low_dash: 
        {
            sprite: spr_tag_copy_low_dash,
            ticks: [2, 2, 2, 2, 2, 2, 2],
            duration: 14
        },
        low_dash_loop: 
        {
            sprite: spr_tag_copy_low_dash_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        low_dash_pause: 
        {
            sprite: spr_tag_copy_low_dash_pause,
            ticks: [2, 2, 2, 2],
            duration: 8
        },
        upward_start: 
        {
            sprite: spr_tag_copy_upward_start,
            ticks: [2, 2, 2, 2, 2],
            duration: 10
        },
        upward: 
        {
            sprite: spr_tag_copy_upward,
            ticks: [2, 2, 2, 2],
            duration: 8
        },
        upward_loop: 
        {
            sprite: spr_tag_copy_upward_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        upward_end: 
        {
            sprite: spr_tag_copy_upward_end,
            ticks: [3, 3, 3, 3, 5, 5, 5],
            duration: 27
        },
        land: 
        {
            sprite: spr_tag_copy_land,
            ticks: [4, 4, 5, 5, 5],
            duration: 23
        },
        eye_start: 
        {
            sprite: spr_tag_copy_eye_start,
            ticks: [3, 5, 20, 3],
            duration: 31
        },
        eye_loop: 
        {
            sprite: spr_tag_copy_eye_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        eye_end: 
        {
            sprite: spr_tag_copy_eye_end,
            ticks: [15, 4, 4, 5, 5],
            duration: 33
        },
        jump_start: 
        {
            sprite: spr_tag_copy_jump_start,
            ticks: [3, 5, 5, 2, 2, 2],
            duration: 19
        },
        jump_start_loop: 
        {
            sprite: spr_tag_copy_jump_start_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        jump: 
        {
            sprite: spr_tag_copy_jump,
            ticks: [3, 5, 2, 2, 2],
            duration: 14
        },
        jump_loop: 
        {
            sprite: spr_tag_copy_jump_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        wall_land: 
        {
            sprite: spr_tag_copy_wall_land,
            ticks: [3, 5, 2, 2, 2],
            duration: 14
        },
        wall_loop: 
        {
            sprite: spr_tag_copy_wall_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        downward_prepare: 
        {
            sprite: spr_tag_copy_downward_prepare,
            ticks: [3, 5, 2, 2, 2],
            duration: 14
        },
        downward_loop: 
        {
            sprite: spr_tag_copy_downward_loop,
            ticks: [2, 2, 2],
            duration: 6
        },
        downward_land: 
        {
            sprite: spr_tag_copy_downward_land,
            ticks: [3, 3, 3, 3, 5, 5, 15, 5, 5, 3, 5, 5],
            duration: 60
        },
        death: 
        {
            sprite: spr_tag_copy_death,
            ticks: [5],
            duration: 5
        },
        dash_slash_1_end: 
        {
            sprite: spr_tag_copy_dash_slash_1_end,
            ticks: [3, 3, 5, 5, 5, 3, 4, 5, 5, 5],
            duration: 43
        }
    };
}

function tagteam_sigma_second_animations()
{
    return 
    {
        fire_prepare: 
        {
            sprite: spr_tag_satan_fire_prepare,
            ticks: [5, 5, 5, 5, 5],
            duration: 25,
            loop: false
        },
        fire_loop: 
        {
            sprite: spr_tag_satan_fire_loop,
            ticks: [3, 3, 3],
            duration: 9,
            loop: true
        },
        fire_end: 
        {
            sprite: spr_tag_satan_fire_end,
            ticks: [5, 5, 5, 5, 3, 5, 5],
            duration: 33,
            loop: false
        },
        slashjump_prepare: 
        {
            sprite: spr_tag_satan_slashjump_prepare,
            ticks: [5, 3, 3, 5, 5, 5],
            duration: 26,
            loop: false
        },
        slashjump_prepare_loop: 
        {
            sprite: spr_tag_satan_slashjump_prepare_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        slashjump_start: 
        {
            sprite: spr_tag_satan_slashjump_start,
            ticks: [5, 3, 5, 5],
            duration: 18,
            loop: false
        },
        slashjump_slash: 
        {
            sprite: spr_tag_satan_slashjump_slash,
            ticks: [3, 3, 5, 5, 8],
            duration: 24,
            loop: false
        },
        slashjump_jump: 
        {
            sprite: spr_tag_satan_slashjump_jump,
            ticks: [3, 3, 3, 3, 3, 8, 8],
            duration: 31,
            loop: false
        },
        slashjump_fall: 
        {
            sprite: spr_tag_satan_slashjump_fall,
            ticks: [3, 3, 3, 3, 3],
            duration: 15,
            loop: false
        },
        slashjump_fall_loop: 
        {
            sprite: spr_tag_satan_slashjump_fall_loop,
            ticks: [3, 3, 3],
            duration: 9,
            loop: true
        },
        slashjump_land: 
        {
            sprite: spr_tag_satan_slashjump_land,
            ticks: [3, 3, 3, 3, 5, 5, 5, 5],
            duration: 32,
            loop: false
        },
        slashjump_land_loop: 
        {
            sprite: spr_tag_satan_slashjump_land_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        slashjump_end: 
        {
            sprite: spr_tag_satan_slashjump_end,
            ticks: [5, 3, 5, 5],
            duration: 18,
            loop: false
        },
        slash_1_prepare: 
        {
            sprite: spr_tag_satan_slash_1_prepare,
            ticks: [5, 5, 3, 3, 5, 5, 5, 5, 5],
            duration: 41,
            loop: false
        },
        slash_1_prepare_loop: 
        {
            sprite: spr_tag_satan_slash_1_prepare_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        slash_1_start: 
        {
            sprite: spr_tag_satan_slash_1_start,
            ticks: [5, 5],
            duration: 10,
            loop: false
        },
        slash_1: 
        {
            sprite: spr_tag_satan_slash_1,
            ticks: [3, 3, 3, 5, 5, 5, 5],
            duration: 29,
            loop: false
        },
        slash_1_loop: 
        {
            sprite: spr_tag_satan_slash_1_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        slash_2_prepare: 
        {
            sprite: spr_tag_satan_slash_2_prepare,
            ticks: [5, 3, 3, 5, 5, 5, 5, 5],
            duration: 36,
            loop: false
        },
        slash_2_prepare_loop: 
        {
            sprite: spr_tag_satan_slash_2_prepare_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        slash_2: 
        {
            sprite: spr_tag_satan_slash_2,
            ticks: [3, 3, 3, 3, 5, 5, 5, 5],
            duration: 32,
            loop: false
        },
        slash_2_loop: 
        {
            sprite: spr_tag_satan_slash_2_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        slash_2_end: 
        {
            sprite: spr_tag_satan_slash_2_end,
            ticks: [5, 3, 5, 5, 5],
            duration: 23,
            loop: false
        },
        slash_3_prepare: 
        {
            sprite: spr_tag_satan_slash_3_prepare,
            ticks: [3, 5, 7, 3],
            duration: 18,
            loop: false
        },
        slash_3: 
        {
            sprite: spr_tag_satan_slash_3,
            ticks: [3, 3, 3, 3, 5, 5, 5, 5, 5],
            duration: 37,
            loop: false
        },
        slash_3_loop: 
        {
            sprite: spr_tag_satan_slash_3_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        slash_3_end: 
        {
            sprite: spr_tag_satan_slash_3_end,
            ticks: [5, 3, 3, 5, 5, 5, 5],
            duration: 31,
            loop: false
        },
        seated_loop: 
        {
            sprite: spr_tag_satan_seated_loop,
            ticks: [7, 7, 7],
            duration: 21,
            loop: true
        },
        talk: 
        {
            sprite: spr_tag_satan_talk,
            ticks: [7, 7, 7, 7, 7, 7],
            duration: 42,
            loop: false
        },
        intro: 
        {
            sprite: spr_tag_satan_intro,
            ticks: [5, 3, 5, 5, 5, 5, 5, 3, 5, 5, 5, 8, 5, 3, 3],
            duration: 70,
            loop: false
        },
        intro2: 
        {
            sprite: spr_tag_satan_intro2,
            ticks: [3, 5, 5, 5, 5, 5],
            duration: 28,
            loop: false
        },
        intro_loop: 
        {
            sprite: spr_tag_satan_intro_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        intro_end: 
        {
            sprite: spr_tag_satan_intro_end,
            ticks: [5, 3, 3, 5, 5, 5, 3, 5, 5],
            duration: 39,
            loop: false
        },
        idle: 
        {
            sprite: spr_tag_satan_idle,
            ticks: [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5],
            duration: 85,
            loop: false
        },
        death: 
        {
            sprite: spr_tag_satan_death,
            ticks: [2, 2, 2, 2, 5, 5, 5],
            duration: 23,
            loop: false
        },
        death_2: 
        {
            sprite: spr_tag_satan_death_2,
            ticks: [48],
            duration: 48,
            loop: false
        },
        spear_jump_prepare: 
        {
            sprite: spr_tag_satan_spear_jump_prepare,
            ticks: [5, 5, 5, 5],
            duration: 20,
            loop: false
        },
        spear_prepare: 
        {
            sprite: spr_tag_satan_spear_prepare,
            ticks: [3, 3, 3, 3, 3, 3, 3, 3, 3],
            duration: 27,
            loop: false
        },
        spear_throw: 
        {
            sprite: spr_tag_satan_spear_throw,
            ticks: [3, 3, 3],
            duration: 9,
            loop: false
        },
        spear_throw_end: 
        {
            sprite: spr_tag_satan_spear_throw_end,
            ticks: [3, 5, 5, 5, 5, 5],
            duration: 28,
            loop: false
        },
        spear_loop: 
        {
            sprite: spr_tag_satan_spear_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        land: 
        {
            sprite: spr_tag_satan_land,
            ticks: [3, 5, 5, 5],
            duration: 18,
            loop: false
        },
        jump_prepare: 
        {
            sprite: spr_tag_satan_jump_prepare,
            ticks: [3, 5, 7],
            duration: 15,
            loop: false
        },
        jump: 
        {
            sprite: spr_tag_satan_jump,
            ticks: [5, 5, 5, 5, 3],
            duration: 23,
            loop: false
        },
        jumpslash_prepare: 
        {
            sprite: spr_tag_satan_jumpslash_prepare,
            ticks: [3, 5, 5, 7],
            duration: 20,
            loop: false
        },
        jumpslash: 
        {
            sprite: spr_tag_satan_jumpslash,
            ticks: [3, 3, 5, 5, 5],
            duration: 21,
            loop: false
        },
        jumplash_tojump: 
        {
            sprite: spr_tag_satan_jumplash_tojump,
            ticks: [5, 5, 5, 5, 5, 5, 3],
            duration: 33,
            loop: false
        },
        dive_prepare: 
        {
            sprite: spr_tag_satan_dive_prepare,
            ticks: [4, 3, 3, 4, 5],
            duration: 19,
            loop: false
        },
        dive: 
        {
            sprite: spr_tag_satan_dive,
            ticks: [2, 2, 2],
            duration: 6,
            loop: false
        },
        dive_land: 
        {
            sprite: spr_tag_satan_dive_land,
            ticks: [3, 5, 5, 5, 5, 5],
            duration: 28,
            loop: false
        },
        dive_land_loop: 
        {
            sprite: spr_tag_satan_dive_land_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        dive_end: 
        {
            sprite: spr_tag_satan_dive_end,
            ticks: [5, 5, 3, 5, 5, 5],
            duration: 28,
            loop: false
        },
        throw_prepare: 
        {
            sprite: spr_tag_satan_throw_prepare,
            ticks: [5, 3, 5, 5, 5, 5, 5],
            duration: 33,
            loop: false
        },
        throw_prepare_loop: 
        {
            sprite: spr_tag_satan_throw_prepare_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        throw_start: 
        {
            sprite: spr_tag_satan_throw_start,
            ticks: [3, 3],
            duration: 6,
            loop: false
        },
        throw: 
        {
            sprite: spr_tag_satan_throw,
            ticks: [3, 5, 5, 5, 5],
            duration: 23,
            loop: false
        },
        throw_loop: 
        {
            sprite: spr_tag_satan_throw_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        throw_end: 
        {
            sprite: spr_tag_satan_throw_end,
            ticks: [5, 5, 3, 5, 5, 5, 5],
            duration: 33,
            loop: false
        },
        throw_end_loop: 
        {
            sprite: spr_tag_satan_throw_end_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        dash_prepare: 
        {
            sprite: spr_tag_satan_dash_prepare,
            ticks: [5, 5, 5],
            duration: 15,
            loop: false
        },
        dash: 
        {
            sprite: spr_tag_satan_dash,
            ticks: [3, 3, 3],
            duration: 9,
            loop: false
        },
        dash_backwards: 
        {
            sprite: spr_tag_satan_dash_backwards,
            ticks: [3, 3, 3],
            duration: 9,
            loop: false
        },
        cannon_prepare: 
        {
            sprite: spr_tag_satan_cannon_prepare,
            ticks: [5, 5, 5, 5, 5, 5, 3, 5, 5, 5, 3, 3, 3],
            duration: 57,
            loop: false
        },
        cannon_prepare_loop: 
        {
            sprite: spr_tag_satan_cannon_prepare_loop,
            ticks: [3, 3, 3],
            duration: 9,
            loop: true
        },
        cannon_start: 
        {
            sprite: spr_tag_satan_cannon_start,
            ticks: [3, 3],
            duration: 6,
            loop: false
        },
        cannon_loop: 
        {
            sprite: spr_tag_satan_cannon_loop,
            ticks: [2, 2, 2, 2, 2, 2, 2, 2],
            duration: 16,
            loop: true
        },
        cannon_end_loop: 
        {
            sprite: spr_tag_satan_cannon_end_loop,
            ticks: [5, 5, 5],
            duration: 15,
            loop: true
        },
        cannon_end: 
        {
            sprite: spr_tag_satan_cannon_end,
            ticks: [5, 5, 3, 5, 5, 5],
            duration: 28,
            loop: false
        }
    };
}

function tagteam_sigma_sfx(arg0, arg1 = 1)
{
    var sound = asset_get_index("snd_tag_sigma_" + arg0);
    if (sound == -1)
    {
        return -1;
    }
    audio_stop_sound(sound);
    var voice = audio_play_sound(sound, 8, false);
    audio_sound_gain(voice, global.volume_effect * global.volume_master * arg1, 0);
    return voice;
}

function tagteam_sigma_wave(arg0, arg1, arg2, arg3)
{
    var b = instance_create_layer(arg0, arg1, "Projectiles", obj_tag_sigma_wave);
    b.direction = arg2;
    b.speed = arg3;
    return b;
}

function tagteam_sigma_hurt_player(arg0)
{
    if (!instance_exists(obj_player) || global.death || obj_player.invul || obj_player.invul_contact || obj_player.invul_bullet || obj_player.hurt)
    {
        exit;
    }
    var b = instance_create_layer(obj_player.x, obj_player.y - 12, "Projectiles", obj_tag_sigma_orb);
    b.damage = arg0;
    b.speed = 0;
    b.expiry = 1;
    b.image_alpha = 0;
}

function tagteam_sigma_poly_contains(arg0, arg1, arg2)
{
    var inside = false;
    var j = array_length(arg0) - 1;
    for (var i = 0; i < array_length(arg0); i++)
    {
        var ax = arg0[i][0];
        var ay = arg0[i][1];
        var bx = arg0[j][0];
        var by = arg0[j][1];
        if ((ay > arg2) != (by > arg2))
        {
            if (arg1 < ((((bx - ax) * (arg2 - ay)) / (by - ay)) + ax))
            {
                inside = !inside;
            }
        }
        j = i;
    }
    return inside;
}

function tagteam_sigma_melee(arg0, arg1, arg2)
{
    if (!instance_exists(obj_player) || obj_player.invul || obj_player.invul_contact || obj_player.hurt)
    {
        exit;
    }
    var polys = [[[38, 60], [136, 60], [190, 13], [150, -29], [56, -53], [-4, -53], [40, 6]], [[38, 60], [161, 60], [161, 22], [131, -54], [74, -87], [-38, -81], [-91, -34], [21, -42]], [[59, -22], [129, 52], [143, -16], [117, -59], [71, -74], [-50, -70], [-113, -26], [-121, 36], [-8, -23]], [[18, 59], [136, 60], [135, 19], [114, -17], [56, -53], [-27, -70], [21, -4]], [[39, 56], [110, 60], [109, 19], [88, -17], [21, -57], [-11, -46], [-19, -23], [-15, 0]]];
    var points = polys[arg1];
    for (var iy = 0; iy < 3; iy++)
    {
        for (var ix = 0; ix < 3; ix++)
        {
            var sx = lerp(obj_player.bbox_left + 2, obj_player.bbox_right - 2, ix / 2);
            var sy = lerp(obj_player.bbox_top + 2, obj_player.bbox_bottom - 2, iy / 2);
            if (tagteam_sigma_poly_contains(points, (sx - arg0.x) * arg0.sig_face, (sy - arg0.y) + 60))
            {
                tagteam_sigma_hurt_player(arg2);
                exit;
            }
        }
    }
}

function tagteam_sigma_line_hit(arg0, arg1, arg2, arg3, arg4)
{
    var px = (obj_player.bbox_left + obj_player.bbox_right) / 2;
    var py = (obj_player.bbox_top + obj_player.bbox_bottom) / 2;
    var dx = arg2 - arg0;
    var dy = arg3 - arg1;
    var t = clamp((((px - arg0) * dx) + ((py - arg1) * dy)) / max(1, (dx * dx) + (dy * dy)), 0, 1);
    return point_distance(px, py, arg0 + (t * dx), arg1 + (t * dy)) < (arg4 + 8);
}

function tagteam_colonel_state(arg0, arg1)
{
    with (arg0)
    {
        col_state = arg1;
        col_tick = 0;
        if (arg1 == "idle")
        {
            col_idle_delay = irandom_range(18, 32);
        }
        if (arg1 == "recover")
        {
            col_recover_delay = irandom_range(10, 18);
        }
    }
}

function tagteam_colonel_pose(arg0, arg1, arg2)
{
    with (arg0)
    {
        col_pose = arg1;
        sprite_index = asset_get_index("spr_tag_colonel_" + arg1);
        image_index = clamp(arg2, 0, sprite_get_number(sprite_index) - 1);
        col_frame = floor(image_index);
        image_xscale = -col_face;
        image_speed = 0;
        var eyes = tagteam_colonel_eyes();
        if (variable_struct_exists(eyes, arg1))
        {
            var pose_eyes = variable_struct_get(eyes, arg1);
            col_eye = pose_eyes[col_frame];
        }
    }
}

function tagteam_colonel_wave(arg0, arg1)
{
    with (arg0)
    {
        var shot = instance_create_layer(x + (col_face * 32), arg1 ? 491 : 518, "Projectiles", obj_tag_colonel_wave);
        shot.col_face = col_face;
        shot.image_xscale = -col_face;
        shot.col_wave_scale = 1;
        shot.damage = 8 * col_damage_scale;
        shot.speed = col_enraged ? 5.5 : 4;
        shot.direction = (col_face > 0) ? 0 : 180;
    }
}

function tagteam_colonel_melee(arg0, arg1)
{
    with (arg0)
    {
        if (!instance_exists(obj_player) || invul || col_dead)
        {
            exit;
        }
        var local_x = (obj_player.x - x) * col_face;
        var local_y = obj_player.y - 12 - y;
        if (local_x >= -12 && local_x <= 88 && local_y > (arg1 ? -33 : -83) && local_y < (arg1 ? 8 : -9))
        {
            tagteam_sigma_hurt_player(9 * col_damage_scale);
        }
    }
}

function tagteam_secret_conversation(arg0, arg1 = false)
{
    if (instance_exists(obj_tag_secret_arena) && obj_tag_secret_arena.secret_skip_dialogue)
    {
        return -4;
    }
    var d = instance_create_depth(0, 0, -1000, obj_dialogue);
    d.dialogue = "tag_" + string_lower(arg0) + "_intro";
    d.movement = false;
    if (arg1)
    {
        d.text_volume = 0;
    }
    return d;
}

function tagteam_colonel_sfx(arg0, arg1 = 1)
{
    if (arg0 == "slash" || arg0 == "thrust")
    {
        arg0 = "wave";
    }
    var sound = asset_get_index("snd_tag_colonel_fx_" + arg0);
    if (sound == -1)
    {
        return -1;
    }
    var gain = global.volume_effect * global.volume_master * arg1;
    var attack_voice = arg0 == "wave" || arg0 == "slash" || arg0 == "thrust" || arg0 == "electric";
    if ((attack_voice || arg0 == "crush" || arg0 == "death") && instance_exists(obj_tag_colonel))
    {
        var previous = obj_tag_colonel.col_wave_voice;
        if (previous != -1 && audio_is_playing(previous))
        {
            audio_sound_gain(previous, (arg0 == "death") ? 0 : (gain * 0.12), 35);
        }
    }
    if ((arg0 == "crush" || arg0 == "death") && instance_exists(obj_tag_colonel))
    {
        var ground = obj_tag_colonel.col_ground_voice;
        if (ground != -1 && audio_is_playing(ground))
        {
            audio_sound_gain(ground, (arg0 == "death") ? 0 : (gain * 0.15), 80);
        }
    }
    var voice = audio_play_sound(sound, 8, false);
    audio_sound_gain(voice, gain, 0);
    if (attack_voice && instance_exists(obj_tag_colonel))
    {
        obj_tag_colonel.col_wave_voice = voice;
    }
    if (arg0 == "crush" && instance_exists(obj_tag_colonel))
    {
        obj_tag_colonel.col_ground_voice = voice;
    }
    return voice;
}

function tagteam_colonel_foot_offsets()
{
    return 
    {
        idle: [2, 2, 2, 2, 2, 2],
        ready: [2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2],
        slash: [-5, -5, -5, 2, 2, 2, -1, -1, -1],
        low: [2, 2, 0, 1, 1, 1, 1],
        dash: [1, 1, 1, 1],
        thunder: [1, 1, 1, 2, 2, 2, 2, 2, 2, 2],
        air: [2, 2, 2, 2, 2, 2, 1, 1, -3],
        defeat: [1, 2],
        fallen: [1, 1, 1, 1, 1, 1, 1, 1, 1]
    };
}

function tagteam_secret_music(arg0 = false)
{
    with (obj_tag_secret_arena)
    {
        if (secret_music != -1)
        {
            audio_stop_sound(secret_music);
        }
        secret_music_native = !arg0;
        secret_music_asset = arg0 ? snd_tag_colonel_theme : (global.music_custom ? snd_music_eidola_boss : snd_music_investigator);
        global.music = secret_music_asset;
        secret_music = audio_play_sound(secret_music_asset, 10, true);
        audio_sound_gain(secret_music, arg0 ? (global.volume_music * global.volume_master * 1.2) : 1, 0);
        audio_sound_pitch(secret_music, 1);
    }
}

function tagteam_upgrade_icon(arg0, arg1, arg2, arg3)
{
    var color = draw_get_color();
    draw_set_color(make_color_rgb(17, 18, 32));
    draw_rectangle(arg1, arg2, arg1 + (13 * arg3), arg2 + (13 * arg3), false);
    for (var i = 0; i < 2; i++)
    {
        var gx = arg1 + ((1 + (i * 7)) * arg3);
        var tint = (i == 0) ? make_color_rgb(64, 190, 255) : make_color_rgb(202, 92, 246);
        draw_set_color(make_color_rgb(190, 184, 208));
        draw_rectangle(gx, arg2 + arg3, gx + (4 * arg3), arg2 + (11 * arg3), false);
        draw_set_color(make_color_rgb(24, 24, 44));
        draw_rectangle(gx + arg3, arg2 + (2 * arg3), gx + (3 * arg3), arg2 + (10 * arg3), false);
        draw_set_color(tint);
        if (arg0 == 902)
        {
            draw_rectangle(gx + arg3, arg2 + (3 * arg3), gx + (2 * arg3), arg2 + (9 * arg3), false);
        }
        else
        {
            for (var j = 0; j < 3; j++)
            {
                draw_rectangle(gx + arg3, arg2 + ((3 + (j * 3)) * arg3), gx + (2 * arg3), arg2 + ((4 + (j * 3)) * arg3), false);
            }
        }
    }
    draw_set_color(draw_get_color());
    draw_set_color(color);
}

function tagteam_colonel_ground_wave(arg0)
{
    with (arg0)
    {
        for (var i = 0; i < 3; i++)
        {
            var wave = instance_create_layer(x + (col_face * (40 - (i * 16))), 544, "Projectiles", obj_tag_colonel_wave);
            wave.sprite_index = spr_tag_colonel_crush;
            wave.col_face = col_face;
            wave.image_xscale = -col_face;
            wave.col_wave_scale = 1;
            wave.col_wave_growth = 1/3;
            wave.col_wave_role = i;
            wave.col_wave_phase = (i == 0) ? 0 : ((i == 1) ? 6 : 7);
            wave.speed = col_enraged ? 5.2 : 4;
            wave.direction = (col_face > 0) ? 0 : 180;
            wave.damage = ((i == 0) ? 11 : 7) * col_damage_scale;
        }
    }
}

function tagteam_colonel_choose_attack(arg0)
{
    with (arg0)
    {
        var pool = [];
        var weights = (abs(obj_player.x - x) > 110) ? [3, 3, 2, 2] : [2, 4, 2, 2];
        for (var move = 0; move < 4; move++)
        {
            if (move != col_attack || col_attack_repeat < 2)
            {
                for (var count = 0; count < weights[move]; count++)
                {
                    array_push(pool, move);
                }
            }
        }
        var next = pool[irandom(array_length(pool) - 1)];
        col_attack_repeat = (next == col_attack) ? (col_attack_repeat + 1) : 1;
        col_attack = next;
        return col_attack;
    }
    return 0;
}

function tagteam_colonel_release_electric(arg0)
{
    with (arg0)
    {
        for (var side = -1; side <= 1; side += 2)
        {
            var spark = instance_create_layer(x + (side * 8), col_floor, "Projectiles", obj_tag_colonel_bolt);
            spark.bolt_face = side;
            spark.bolt_damage = 9 * col_damage_scale;
            spark.bolt_speed = col_enraged ? 5.6 : 4.4;
        }
        tagteam_colonel_sfx("spark", 0.65);
    }
}

function tagteam_colonel_floor_columns(arg0)
{
    with (arg0)
    {
        for (var i = 0; i < 6; i++)
        {
            var bolt = instance_create_layer(86 + (i * 54), col_floor, "Projectiles", obj_tag_colonel_bolt);
            bolt.bolt_kind = 1;
            bolt.bolt_damage = 9 * col_damage_scale;
        }
        tagteam_colonel_sfx("charge", 0.45);
    }
}

function tagteam_colonel_saber_tip(arg0)
{
    with (arg0)
    {
        var tips = [[118.5, 30.5], [118.5, 30.5], [118.5, 30.5], [120.5, 32.5], [120.5, 31.5], [120.5, 32.5], [120.5, 16.5], [120.5, 16.5], [120.5, 23.5], [118.5, 30.5]];
        var point = tips[clamp(col_frame, 0, 9)];
        var offsets = tagteam_colonel_foot_offsets();
        var feet = offsets.thunder;
        return [x + ((point[0] - 128) * image_xscale), (y + feet[col_frame] + point[1]) - 160];
    }
    return [0, 0];
}

function tagteam_colonel_bolt_anchor(arg0)
{
    var anchors = [[-0.5, -0.5, 255, -6.5, 8.5], [0.5, -0.5, 255, -7.5, 6.5], [1, -0.5, 255, -6, 4], [0.5, -4.5, 251, -4.5, 1.5], [-0.5, -1.5, 94, -3.5, 2.5]];
    return anchors[arg0 % 5];
}

function tagteam_colonel_eyes()
{
    return 
    {
        idle: [[126, 94], [126, 94], [126, 94], [126, 94], [126, 95], [126, 96]],
        ready: [[122, 93], [112, 92], [112, 91], [112, 92], [130, 92], [130, 91], [130, 92], [128, 92], [130, 92], [130, 91], [143, 86]],
        slash: [[121, 107], [121, 107], [121, 107], [137, 111], [138, 111], [141, 95], [122, 109], [123, 109], [124, 109]],
        low: [[135, 98], [137, 98], [120, 99], [113, 86], [113, 86], [116, 86], [135, 98]],
        dash: [[135, 98], [135, 98], [135, 98], [136, 98]],
        thunder: [[112, 92], [112, 91], [112, 92], [130, 92], [130, 91], [130, 92], [128, 92], [130, 92], [130, 91], [143, 86]],
        air: [[126, 89], [124, 89], [124, 88], [122, 92], [130, 92], [130, 92], [112, 91], [109, 91], [131, 105]],
        defeat: [[120, 99], [115, 120]]
    };
}

function tagteam_has_separate_health()
{
    return ds_list_find_index(global.parts_owned, 902) != -1;
}

function tagteam_has_separate_energy()
{
    return ds_list_find_index(global.parts_owned, 903) != -1;
}

function tagteam_separate_health_active()
{
    return !coop_enabled() && tagteam_has_separate_health() && global.tag_health_enabled;
}

function tagteam_separate_energy_active()
{
    return !coop_enabled() && tagteam_has_separate_energy() && global.tag_energy_enabled;
}

function tagteam_upgrade_enabled(arg0)
{
    return (arg0 == 902) ? tagteam_separate_health_active() : tagteam_separate_energy_active();
}

function tagteam_actor_slot()
{
    return (global.playable_character.name == "Zero") ? 1 : 0;
}

function tagteam_copy_ammo()
{
    var a = [];
    for (var i = 0; i < array_length(global.weapon); i++)
    {
        array_push(a, global.weapon[i].ammo);
    }
    return a;
}

function tagteam_initialize_pools()
{
    if (!variable_global_exists("weapon_ammo_max") || !variable_global_exists("weapon") || !variable_global_exists("life"))
    {
        exit;
    }
    global.tag_health = [global.life, global.life];
    global.tag_energy = [tagteam_copy_ammo(), tagteam_copy_ammo()];
    global.tag_energy_capacity = [global.weapon_ammo_max, global.weapon_ammo_max];
    global.tag_auto_swap = false;
}

function tagteam_ensure_pools()
{
    if (global.tag_health[0] < 0)
    {
        tagteam_initialize_pools();
    }
    if (tagteam_has_separate_health() && !global.tag_health_enabled)
    {
        for (var i = 0; i < 2; i++)
        {
            global.tag_health[i] = min(global.tag_health[i], max(0, global.life));
        }
    }
    if (tagteam_has_separate_energy() && !global.tag_energy_enabled)
    {
        for (var i = 0; i < 2; i++)
        {
            var a = global.tag_energy[i];
            var cap = max(1, global.tag_energy_capacity[i]);
            for (var j = 0; j < array_length(global.weapon); j++)
            {
                if (j < array_length(a) && a[j] >= 0 && global.weapon[j].ammo >= 0)
                {
                    a[j] = min(a[j], (global.weapon[j].ammo / max(1, global.weapon_ammo_max)) * cap);
                }
            }
            global.tag_energy[i] = a;
        }
    }
}

function tagteam_capture_actor()
{
    tagteam_ensure_pools();
    var slot = tagteam_actor_slot();
    if (tagteam_separate_health_active())
    {
        global.tag_health[slot] = global.tag_auto_swap ? 0 : clamp(global.life, 0, global.lifemax);
    }
    if (tagteam_separate_energy_active())
    {
        global.tag_energy[slot] = tagteam_copy_ammo();
        global.tag_energy_capacity[slot] = global.weapon_ammo_max;
    }
}

function tagteam_restore_actor()
{
    var slot = tagteam_actor_slot();
    if (tagteam_separate_health_active())
    {
        global.life = clamp(global.tag_health[slot], 0, global.lifemax);
    }
    if (tagteam_separate_energy_active())
    {
        var ammo = global.tag_energy[slot];
        var capacity = max(1, global.tag_energy_capacity[slot]);
        for (var i = 0; i < array_length(global.weapon); i++)
        {
            if (i < array_length(ammo) && ammo[i] >= 0)
            {
                global.weapon[i].ammo = clamp((ammo[i] / capacity) * global.weapon_ammo_max, 0, global.weapon_ammo_max);
            }
        }
    }
    global.tag_auto_swap = false;
}

function tagteam_partner_alive()
{
    tagteam_ensure_pools();
    return !tagteam_separate_health_active() || global.tag_health[1 - tagteam_actor_slot()] > 0;
}

function tagteam_upgrade_purchase(arg0)
{
    if (!variable_global_exists("weapon_ammo_max"))
    {
        global.tag_health = [-1, -1];
        exit;
    }
    tagteam_ensure_pools();
    if (arg0 == 902)
    {
        global.tag_health_enabled = true;
        global.tag_health = [global.life, global.life];
    }
    if (arg0 == 903)
    {
        global.tag_energy_enabled = true;
        global.tag_energy = [tagteam_copy_ammo(), tagteam_copy_ammo()];
        global.tag_energy_capacity = [global.weapon_ammo_max, global.weapon_ammo_max];
    }
}

function tagteam_check_partner_rescue()
{
    if (global.pause || global.death || global.life > 0 || !tagteam_separate_health_active() || !global.zero_unlock || !instance_exists(obj_player))
    {
        exit;
    }
    tagteam_ensure_pools();
    global.tag_health[tagteam_actor_slot()] = 0;
    if (obj_player.tag_pit_death || place_meeting_player_pit())
    {
        exit;
    }
    if (!tagteam_partner_alive() || obj_player.player_state != 0 || instance_exists(obj_dialogue) || instance_exists(obj_comic_parent))
    {
        exit;
    }
    if (obj_player.tag_state != 0)
    {
        exit;
    }
    global.tag_auto_swap = true;
    global.life = 1;
    with (obj_player)
    {
        tag_rescue_pending = true;
        hurt = false;
        recovery = 1;
        recovery_time = 180;
        alarm[1] = 180;
        alarm[2] = 1;
        alarm[3] = -1;
        invul = false;
        invul_bullet = false;
        invul_contact = false;
        movement = true;
        movement_freeze = false;
        animation_lock = false;
        tag_cooldown = 0;
        xspeed = 0;
        yspeed = 0;
    }
}

function tagteam_toggle_upgrade(arg0)
{
    if (arg0 != 902 && arg0 != 903)
    {
        return false;
    }
    if (ds_list_find_index(global.parts_owned, arg0) == -1)
    {
        return false;
    }
    if (instance_exists(obj_player) && (obj_player.tag_state != 0 || obj_player.tag_rescue_pending || global.death))
    {
        scr_make_sound(snd_menu_denied, 1, 1, false);
        return false;
    }
    if (variable_global_exists("weapon_ammo_max") && variable_global_exists("life"))
    {
        tagteam_capture_actor();
        var slot = tagteam_actor_slot();
        if (arg0 == 902)
        {
            global.tag_health[slot] = global.life;
            global.tag_health[1 - slot] = min(global.tag_health[1 - slot], global.life);
        }
        else
        {
            global.tag_energy[slot] = tagteam_copy_ammo();
            global.tag_energy_capacity[slot] = global.weapon_ammo_max;
        }
    }
    if (arg0 == 902)
    {
        global.tag_health_enabled = !global.tag_health_enabled;
    }
    else
    {
        global.tag_energy_enabled = !global.tag_energy_enabled;
    }
    if (variable_global_exists("weapon_ammo_max") && variable_global_exists("life"))
    {
        tagteam_ensure_pools();
    }
    scr_make_sound(tagteam_upgrade_enabled(arg0) ? snd_menu_equip : snd_menu_move, 1, 1, false);
    with (obj_manager)
    {
        save_slot = 0;
        event_user(0);
    }
    return true;
}

function tagteam_rescue_tick()
{
    with (obj_player)
    {
        if (global.pause)
        {
            exit;
        }
        if (tag_rescue_grace > 0 && tag_state == 0)
        {
            tag_rescue_grace--;
            recovery = 1;
            hurt = false;
            alarm[1] = max(2, tag_rescue_grace);
            if (alarm[2] < 0)
            {
                alarm[2] = 1;
            }
        }
    }
}

function tagteam_finish_rescue()
{
    with (obj_player)
    {
        if (!tag_rescue_pending)
        {
            exit;
        }
        tag_rescue_pending = false;
        tag_rescue_grace = 180;
        recovery = 1;
        recovery_time = 180;
        hurt = false;
        alarm[1] = 180;
        alarm[2] = 1;
        flicker = true;
        invul = false;
        invul_bullet = false;
        invul_contact = false;
    }
}

function place_meeting_player_pit()
{
    with (obj_player)
    {
        return place_meeting(x, y, obj_pit);
    }
    return false;
}

function tagteam_colonel_charge_walls(arg0)
{
    with (obj_tag_secret_arena)
    {
        if (secret_wall_state != "off")
        {
            exit;
        }
        var sx = arg0.x + (8 * arg0.col_face);
        var sy = arg0.y - 142;
        secret_wall_sparks = [
        {
            sx: sx,
            sy: sy,
            x: sx,
            y: sy,
            tx: 64,
            ty: 408,
            side: 0
        }, 
        {
            sx: sx,
            sy: sy,
            x: sx,
            y: sy,
            tx: 384,
            ty: 408,
            side: 1
        }];
        secret_wall_state = "charging";
        secret_wall_tick = 0;
        secret_wall_timer = 0;
        secret_wall_side = -1;
    }
}

function tagteam_colonel_wall_strength(arg0)
{
    var age = arg0 % 180;
    var t = clamp(min(age / 18, (180 - age) / 18), 0, 1);
    return t * t * (3 - (2 * t));
}

function tagteam_colonel_wall_step()
{
    with (obj_tag_secret_arena)
    {
        if (secret_wall_state == "off")
        {
            exit;
        }
        if (!instance_exists(obj_tag_colonel) || obj_tag_colonel.col_dead || obj_tag_colonel.life <= 0)
        {
            secret_wall_state = "off";
            secret_wall_sparks = [];
            secret_wall_side = -1;
            exit;
        }
        if (secret_wall_state == "charging")
        {
            secret_wall_tick++;
            var t = clamp(secret_wall_tick / 36, 0, 1);
            var ease = t * t * (3 - (2 * t));
            for (var i = 0; i < 2; i++)
            {
                var sp = secret_wall_sparks[i];
                sp.x = lerp(sp.sx, sp.tx, ease);
                sp.y = lerp(sp.sy, sp.ty, t) - (sin(pi * t) * 22);
            }
            if (secret_wall_tick >= 36)
            {
                secret_wall_state = "active";
                secret_wall_sparks = [];
                secret_wall_timer = 0;
                secret_wall_side = 1;
                tagteam_colonel_sfx("wall", 0.45);
            }
            exit;
        }
        secret_wall_timer++;
        secret_wall_side = 1 - ((secret_wall_timer div 180) % 2);
        if ((secret_wall_timer % 180) == 0)
        {
            tagteam_colonel_sfx("wall", 0.4);
        }
        if (!instance_exists(obj_player) || obj_player.recovery != 0)
        {
            exit;
        }
        var strength = tagteam_colonel_wall_strength(secret_wall_timer);
        if (strength < 0.6)
        {
            exit;
        }
        if (obj_player.bbox_bottom < (408 - (87 * strength)) || obj_player.bbox_top >= (408 + (87 * strength)))
        {
            exit;
        }
        var touches = (secret_wall_side == 0) ? (obj_player.bbox_left <= 65) : (obj_player.bbox_right >= 383);
        if (touches)
        {
            tagteam_sigma_hurt_player(6 * obj_tag_colonel.col_damage_scale);
        }
    }
}

function tagteam_colonel_wall_draw()
{
    with (obj_tag_secret_arena)
    {
        if (secret_wall_state == "charging")
        {
            for (var i = 0; i < array_length(secret_wall_sparks); i++)
            {
                var sp = secret_wall_sparks[i];
                draw_sprite_ext(spr_tag_colonel_spark, floor(secret_wall_tick / 3) % 8, sp.x, sp.y, 0.75, 0.75, 0, c_white, 1);
            }
            exit;
        }
        if (secret_wall_state != "active")
        {
            exit;
        }
        var wx = (secret_wall_side == 0) ? 64 : 384;
        var strength = tagteam_colonel_wall_strength(secret_wall_timer);
        if (strength <= 0)
        {
            exit;
        }
        var age = secret_wall_timer % 180;
        var cel = (age >= 162) ? ((age >= 174) ? 4 : 3) : (floor(secret_clock / 2) % 3);
        draw_sprite_ext(spr_tag_colonel_bolt, cel, wx, 408, 1, 0.67 * strength, 0, c_white, strength);
        var spark_scale = 0.3 * (0.6 + (0.4 * strength));
        draw_sprite_ext(spr_tag_colonel_spark, 3 + (floor(secret_clock / 3) % 5), wx, lerp(408, 326, strength), spark_scale, spark_scale, 0, c_white, 0.9 * strength);
        draw_sprite_ext(spr_tag_colonel_spark, 3 + (floor((secret_clock / 3) + 2) % 5), wx, lerp(408, 494, strength), spark_scale, spark_scale, 0, c_white, 0.9 * strength);
    }
}

function coop_log(arg0)
{
    var file = file_text_open_append("coop-log.txt");
    file_text_write_string(file, string(current_time) + " " + arg0);
    file_text_writeln(file);
    file_text_close(file);
}

function coop_enabled()
{
    return variable_global_exists("coop_role") && global.coop_role > 0 && (global.coop_role == 2 || (variable_global_exists("coop_campaign_active") && global.coop_campaign_active) || (variable_global_exists("coop_preview_active") && global.coop_preview_active));
}

function coop_client()
{
    return coop_enabled() && global.coop_role == 2;
}

function coop_play_room()
{
    return instance_exists(obj_player) && (room == rm_highmax || room == rm_intro || room == rm_yammark || room == rm_turtloid || room == rm_heatnix || room == rm_mijinion || room == rm_tag_sigma || room == rm_training || room == rm_template || room == rm_dragoon);
}

function coop_send(arg0)
{
    if (!instance_exists(obj_coop_net))
    {
        return false;
    }
    var net = obj_coop_net;
    if (!net.connected || net.peer < 0)
    {
        return false;
    }
    var data = json_stringify(arg0);
    var buf = buffer_create(string_byte_length(data) + 1, buffer_grow, 1);
    buffer_write(buf, buffer_string, data);
    var result = network_send_packet(net.peer, buf, buffer_tell(buf));
    buffer_delete(buf);
    net.tx_count++;
    return result >= 0;
}

function coop_apply_character()
{
    var name = global.coop_character;
    if (global.playable_character.name == name)
    {
        exit;
    }
    global.playable_character = (name == "X") ? Character_X() : Character_Zero();
    scr_weapon_get("Default", false);
    for (var i = 0; i < ds_list_size(global.weapon_list); i++)
    {
        scr_weapon_get(ds_list_find_value(global.weapon_list, i), false);
    }
    with (obj_player)
    {
        spr_manager = new sprite_manager(id);
        scr_setup_player_sprites();
    }
    global.zero_unlock = true;
}

function coop_pack_player(arg0)
{
    with (arg0)
    {
        return coop_packet("x", x, "y", y, "sprite", sprite_get_name(sprite_index), "frame", image_index, "sx", image_xscale, "sy", image_yscale, "angle", image_angle, "alpha", image_alpha, "blend", image_blend, "char", global.playable_character.name, "lives", global.lives, "spectating", obj_coop_net.spectating, "zone", coop_zone_key(camera_zone), "last_zone", coop_zone_key(camera_lasttouch), "movable", movement && !movement_freeze && !animation_lock && !global.death, "hp", global.life, "maxhp", global.lifemax, "palette", palette, "palette_sprite", sprite_get_name(global.playable_character.visual.palette), "flash", flicker, "air", airborne, "charging", global.playable_character.name == "X" && (shooting_charge >= shooting_charge_lvl_1 || special_charge >= shooting_charge_lvl_1));
    }
    return json_parse("{}");
}

function coop_visual(arg0, arg1)
{
    with (arg0)
    {
        if (object_index == obj_coop_foe || object_index == obj_coop_enemy_shot)
        {
            var fresh = !variable_instance_exists(id, "coop_target_x");
            if (fresh)
            {
                coop_target_x = x;
                coop_target_y = y;
                coop_sample_time = current_time;
                coop_vx = 0;
                coop_vy = 0;
            }
            var dt = max(1, (current_time - coop_sample_time) / 16.6667);
            var warp = fresh || point_distance(x, y, arg1.x, arg1.y) > 80;
            coop_vx = warp ? 0 : clamp((arg1.x - coop_target_x) / dt, -12, 12);
            coop_vy = warp ? 0 : clamp((arg1.y - coop_target_y) / dt, -12, 12);
            coop_target_x = arg1.x;
            coop_target_y = arg1.y;
            coop_sample_time = current_time;
            if (warp)
            {
                x = arg1.x;
                y = arg1.y;
            }
        }
        else
        {
            x = arg1.x;
            y = arg1.y;
        }
        sprite_index = asset_get_index(arg1.sprite);
        if (variable_struct_exists(arg1, "mask"))
        {
            mask_index = asset_get_index(arg1.mask);
        }
        image_index = arg1.frame;
        image_xscale = arg1.sx;
        image_yscale = arg1.sy;
        image_angle = arg1.angle;
        image_alpha = arg1.alpha;
        image_blend = arg1.blend;
        image_speed = 0;
        visible = variable_struct_exists(argument1, "visible") ? argument1.visible : true;
        coop_seen = current_time;
    }
}

function coop_pack_shots(arg0)
{
    var shots = [];
    with (obj_bullet_default)
    {
        if (villainy != 2 && object_index != obj_coop_shot && sprite_index != -1)
        {
            var native_slash = variable_instance_exists(id, "slash") && slash && villainy == 0;
            var native_palette = palette_type;
            if (native_slash && variable_instance_exists(id, "palette_sprite"))
            {
                native_palette = palette_sprite;
            }
            var draw_frame = native_slash ? obj_player.image_index : image_index;
            var d = coop_packet("draw_frame", draw_frame, "slash", native_slash, "palette_name", (native_palette > 0) ? sprite_get_name(native_palette) : "", "palette_row", palette, "key", string(id), "x", x, "y", y, "sprite", sprite_get_name(sprite_index), "frame", image_index, "sx", image_xscale, "sy", image_yscale, "angle", image_angle, "alpha", image_alpha, "blend", image_blend, "owner", arg0, "character", global.coop_character, "damage", damage, "mask", (mask_index == -1) ? sprite_get_name(sprite_index) : sprite_get_name(mask_index), "damage_mult", damage_mult, "melee", melee, "melee_frames", melee_frames, "special", special, "special_type", special_type, "piercing", piercing, "piercing_armour", piercing_armour, "ignore_iframes", ignore_iframes, "crit_disable", crit_disable, "phasing", phasing, "yammar_marking", yammar_marking, "explosive", explosive, "passive", passive, "tick", tick);
            array_push(shots, d);
        }
    }
    return shots;
}

function coop_pack_world()
{
    var result = [];
    with (obj_enemy_parent)
    {
        if (object_index != obj_coop_foe && sprite_index != -1 && (life > 0 || boss) && coop_in_interest(x, y))
        {
            array_push(result, coop_packet("key", string(id), "kind", object_get_name(object_index), "draw_angle", (object_index == obj_boss_donut) ? rotate : image_angle, "environment", coop_pack_environment_actor(id), "native_jet", (object_index == obj_enemy_moth) ? (action > 0) : false, "x", x, "y", y, "sprite", sprite_get_name(sprite_index), "frame", image_index, "sx", image_xscale, "sy", image_yscale, "angle", image_angle, "alpha", image_alpha, "blend", image_blend, "visible", visible, "life", life, "maxhp", lifemax, "damage", damage, "invul", invul, "armour", armour, "isHit", isHit, "boss_flicker", variable_instance_exists(id, "boss_flicker") ? boss_flicker : false, "boss", boss, "mask", (mask_index == -1) ? sprite_get_name(sprite_index) : sprite_get_name(mask_index), "faction", variable_instance_exists(id, "faction") ? faction : 0, "physics", coop_pack_physics(id)));
        }
    }
    with (obj_bullet_default)
    {
        if (villainy == 2 && coop_in_interest(x, y))
        {
            array_push(result, coop_packet("key", string(id), "kind", "Host Bullet", "palette_name", (palette_type > 0) ? sprite_get_name(palette_type) : "", "palette_row", palette, "passive", passive, "mask", (mask_index == -1) ? sprite_get_name(sprite_index) : sprite_get_name(mask_index), "x", x, "y", y, "sprite", sprite_get_name(sprite_index), "frame", image_index, "sx", image_xscale, "sy", image_yscale, "angle", image_angle, "alpha", image_alpha, "blend", image_blend, "visible", visible, "life", 1, "maxhp", 1, "damage", damage, "invul", false, "armour", false, "isHit", false, "boss", false));
        }
    }
    with (obj_pickup)
    {
        if (object_index != obj_coop_pickup && sprite_index != -1 && coop_in_interest(x, y))
        {
            array_push(result, coop_packet("key", string(id), "kind", "Pickup", "x", x, "y", y, "sprite", sprite_get_name(sprite_index), "frame", image_index, "sx", image_xscale, "sy", image_yscale, "angle", image_angle, "alpha", image_alpha, "blend", image_blend, "visible", visible, "life", 1, "maxhp", 1, "damage", 0, "invul", false, "armour", false, "isHit", false, "boss", false));
        }
    }
    with (obj_reploid)
    {
        if (object_index != obj_coop_npc && sprite_index != -1)
        {
            array_push(result, coop_packet("key", string(id), "kind", "Reploid", "x", x, "y", y, "sprite", sprite_get_name(sprite_index), "frame", image_index, "sx", image_xscale, "sy", image_yscale, "angle", image_angle, "alpha", image_alpha, "blend", image_blend, "visible", visible, "life", 1, "maxhp", 1, "damage", 0, "invul", false, "armour", false, "isHit", false, "boss", false, "main", palette_main, "skin", palette_skin, "secondary", palette_secondary, "rescued", rescued, "opening", openning));
        }
    }
    return result;
}

function coop_receive(arg0)
{
    var net = obj_coop_net;
    switch (arg0.op)
    {
        case "consumed":
            if (coop_client() && arg0.room == room_get_name(room))
            {
                var target_key = arg0.key;
                with (obj_bullet_default)
                {
                    if (object_index != obj_coop_shot && ("2-" + string(id)) == target_key)
                    {
                        alarm[9] = 1;
                    }
                }
            }
            break;
        case "death_fx":
            coop_death_fx(argument0.x, argument0.y, asset_get_index(argument0.sprite));
            break;
        case "pickup_request":
            if (global.coop_role == 1 && argument0.room == room_get_name(room))
            {
                coop_pickup_request(argument0.key);
            }
            break;
        case "pickup_grant":
            if (coop_client())
            {
                coop_pickup_grant(argument0.type, argument0.power);
            }
            break;
        case "rescue_request":
            if (global.coop_role == 1 && argument0.room == room_get_name(room))
            {
                coop_rescue_request(argument0.key);
            }
            break;
        case "peer_sound":
            if (coop_enabled() && argument0.room == room_get_name(room))
            {
                var snd = asset_get_index(argument0.sound);
                if (snd == snd_player_x_charge_fadeout)
                {
                    snd = snd_coop_peer_charge;
                }
                else if (snd == snd_shoot_large)
                {
                    snd = snd_coop_peer_charge_shot;
                }
                if (snd != -1)
                {
                    var remote_gain = argument0.volume;
                    if (snd == snd_coop_peer_charge || snd == snd_coop_peer_charge_shot)
                    {
                        remote_gain *= (global.volume_effect * global.volume_master);
                    }
                    coop_original_make_sound(snd, remote_gain * ((snd == snd_coop_peer_charge) ? 0.75 : 1), argument0.pitch, false);
                }
            }
            break;
        case "hit_request":
            if (global.coop_role == 1 && argument0.room == room_get_name(room))
            {
                coop_resolve_hit(argument0.target, argument0.attack);
            }
            break;
        case "native_fx":
            coop_receive_native_effect(argument0);
            break;
        case "fx_update":
            coop_fx_update(argument0);
            break;
        case "fx_end":
            coop_fx_end(argument0);
            break;
        case "leave":
            if (global.coop_role == 1)
            {
                coop_partner_left();
            }
            break;
        case "hello":
            if (variable_struct_exists(argument0, "character"))
            {
                net.guest_character = argument0.character;
            }
            net.profile_dirty = true;
            break;
        case "welcome":
            net.session_id = arg0.session;
            if (variable_struct_exists(argument0, "character"))
            {
                net.host_character = argument0.character;
            }
            break;
        case "profile":
            if (global.coop_role == 2)
            {
                var f = file_text_open_write("save_0.txt");
                file_text_write_string(f, arg0.save);
                file_text_close(f);
                if (!net.profile_applied)
                {
                    net.profile_applied = true;
                    with (obj_manager)
                    {
                        save_slot = 0;
                        event_user(1);
                    }
                    net.pending_room = arg0.room;
                    coop_log("PROFILE_IMPORTED");
                }
                else
                {
                    coop_log("PROFILE_MIRRORED");
                }
            }
            break;
        case "player":
            obj_coop_net.remote_room = argument0.room;
            if (arg0.room == room_get_name(room) && coop_play_room())
            {
                if (!instance_exists(net.remote))
                {
                    net.remote = instance_create_depth(arg0.actor.x, arg0.actor.y, -1, obj_coop_remote);
                }
                coop_visual(net.remote, arg0.actor);
                if (variable_struct_exists(arg0.actor, "charging") && !arg0.actor.charging)
                {
                    audio_stop_sound(snd_coop_peer_charge);
                }
                net.remote.coop_character = arg0.actor.char;
                net.remote.coop_hp = arg0.actor.hp;
                net.remote.coop_lives = variable_struct_exists(argument0.actor, "lives") ? argument0.actor.lives : 0;
                net.remote.coop_spectating = variable_struct_exists(argument0.actor, "spectating") && argument0.actor.spectating;
                net.remote.coop_maxhp = arg0.actor.maxhp;
                net.remote.coop_zone = variable_struct_exists(arg0.actor, "zone") ? arg0.actor.zone : "";
                net.remote.coop_last_zone = variable_struct_exists(arg0.actor, "last_zone") ? arg0.actor.last_zone : "";
                net.remote.coop_movable = variable_struct_exists(arg0.actor, "movable") && arg0.actor.movable;
                net.remote.coop_air = arg0.actor.air;
                net.remote.coop_palette = arg0.actor.palette;
                net.remote.coop_palette_sprite = asset_get_index(arg0.actor.palette_sprite);
                net.remote.coop_flash = arg0.actor.flash;
                coop_receive_shots(arg0.shots);
            }
            break;
        case "world":
            if (global.coop_role == 2 && net.profile_applied)
            {
                coop_receive_world(arg0);
            }
            break;
    }
}

function coop_attack_character(arg0)
{
    if (coop_enabled() && variable_instance_exists(arg0, "coop_owner") && arg0.coop_owner == 2)
    {
        if (variable_instance_exists(arg0, "coop_character"))
        {
            return arg0.coop_character;
        }
        if (instance_exists(obj_coop_net) && variable_instance_exists(obj_coop_net, "guest_character"))
        {
            return obj_coop_net.guest_character;
        }
    }
    return global.playable_character.name;
}

function coop_packet()
{
    var packet = json_parse("{}");
    for (var i = 0; i < argument_count; i += 2)
    {
        variable_struct_set(packet, argument[i], argument[i + 1]);
    }
    return packet;
}

function coop_receive_shots(arg0)
{
    var net = obj_coop_net;
    net.shot_epoch++;
    for (var i = 0; i < array_length(arg0); i++)
    {
        var d = arg0[i];
        var key = string(d.owner) + "-" + d.key;
        if (ds_map_exists(net.consumed_shots, key))
        {
            continue;
        }
        var shot = ds_map_exists(net.client_shots, key) ? ds_map_find_value(net.client_shots, key) : -4;
        if (!instance_exists(shot))
        {
            shot = instance_create_layer(d.x, d.y, "Projectiles", obj_coop_shot);
            shot.coop_server_id = key;
            shot.coop_owner = d.owner;
            shot.damage = d.damage;
            shot.coop_character = variable_struct_exists(d, "character") ? d.character : net.guest_character;
            shot.damage_mult = d.damage_mult;
            shot.melee = d.melee;
            shot.melee_frames = d.melee_frames;
            shot.special = d.special;
            shot.special_type = d.special_type;
            shot.piercing = d.piercing;
            shot.piercing_armour = d.piercing_armour;
            shot.ignore_iframes = d.ignore_iframes;
            shot.crit_disable = d.crit_disable;
            shot.phasing = variable_struct_exists(d, "phasing") && d.phasing;
            shot.yammar_marking = variable_struct_exists(d, "yammar_marking") ? d.yammar_marking : 0;
            shot.explosive = d.explosive;
            shot.passive = d.passive;
            shot.tick = d.tick;
            shot.villainy = 0;
            shot.melee_slash = false;
            ds_map_set(net.client_shots, key, shot);
        }
        shot.damage = d.damage;
        shot.coop_character = variable_struct_exists(d, "character") ? d.character : net.guest_character;
        shot.damage_mult = d.damage_mult;
        shot.melee = d.melee;
        shot.melee_frames = d.melee_frames;
        shot.special = d.special;
        shot.special_type = d.special_type;
        shot.piercing = d.piercing;
        shot.piercing_armour = d.piercing_armour;
        shot.ignore_iframes = d.ignore_iframes;
        shot.crit_disable = d.crit_disable;
        shot.phasing = variable_struct_exists(d, "phasing") && d.phasing;
        shot.yammar_marking = variable_struct_exists(d, "yammar_marking") ? d.yammar_marking : 0;
        shot.explosive = d.explosive;
        shot.passive = d.passive;
        shot.tick = d.tick;
        coop_visual(shot, d);
        shot.coop_draw_frame = variable_struct_exists(d, "draw_frame") ? d.draw_frame : d.frame;
        shot.coop_slash = variable_struct_exists(d, "slash") && d.slash;
        shot.coop_palette_sprite = (variable_struct_exists(d, "palette_name") && d.palette_name != "") ? asset_get_index(d.palette_name) : -1;
        shot.coop_palette = variable_struct_exists(d, "palette_row") ? d.palette_row : 0;
        shot.coop_epoch = net.shot_epoch;
    }
    with (obj_coop_shot)
    {
        if (coop_epoch != obj_coop_net.shot_epoch)
        {
            coop_expired = true;
            instance_destroy();
        }
    }
}

function coop_receive_world(arg0)
{
    var net = obj_coop_net;
    net.host_blocked = arg0.blocked;
    if (variable_struct_exists(arg0, "dialogue"))
    {
        coop_apply_dialogue(arg0.dialogue);
    }
    global.coop_campaign_active = arg0.campaign;
    if (variable_struct_exists(arg0, "progress"))
    {
        coop_apply_progress(arg0.progress);
    }
    if (net.remote_epoch != -1 && net.remote_epoch != arg0.epoch && room_get_name(room) == arg0.room)
    {
        net.pending_restart = true;
        net.pending_room = arg0.room;
    }
    net.remote_epoch = arg0.epoch;
    if (room_get_name(room) != arg0.room)
    {
        net.pending_room = arg0.room;
        exit;
    }
    net.world_tick++;
    if (variable_struct_exists(arg0, "mobility"))
    {
        coop_receive_mobility(arg0.mobility);
    }
    if (variable_struct_exists(argument0, "solids"))
    {
        coop_apply_solids(argument0.solids);
    }
    if (variable_struct_exists(argument0, "rain"))
    {
        coop_apply_rain(argument0.rain);
    }
    var actors = arg0.actors;
    for (var i = 0; i < array_length(actors); i++)
    {
        var d = actors[i];
        var key = d.key;
        var actor = ds_map_exists(net.entities, key) ? ds_map_find_value(net.entities, key) : -4;
        if (!instance_exists(actor))
        {
            actor = instance_create_layer(d.x, d.y, "Instances", (d.kind == "Host Bullet") ? obj_coop_enemy_shot : ((d.kind == "Pickup") ? obj_coop_pickup : ((d.kind == "Reploid") ? obj_coop_npc : obj_coop_foe)));
            actor.coop_server_id = key;
            ds_map_set(net.entities, key, actor);
        }
        coop_visual(actor, d);
        if (variable_struct_exists(d, "environment"))
        {
            coop_apply_environment_actor(actor, d.environment);
        }
        actor.life = d.life;
        actor.lifemax = d.maxhp;
        actor.damage = (d.life <= 0) ? 0 : d.damage;
        actor.coop_draw_angle = variable_struct_exists(d, "draw_angle") ? d.draw_angle : d.angle;
        actor.coop_boss_flicker = variable_struct_exists(d, "boss_flicker") && d.boss_flicker;
        if (actor.object_index == obj_coop_enemy_shot)
        {
            actor.passive = variable_struct_exists(d, "passive") ? d.passive : true;
            actor.palette_type = (variable_struct_exists(d, "palette_name") && d.palette_name != "") ? asset_get_index(d.palette_name) : 0;
            actor.palette = variable_struct_exists(d, "palette_row") ? d.palette_row : 0;
        }
        actor.invul = d.invul;
        actor.armour = d.armour;
        actor.isHit = d.isHit;
        actor.boss = d.boss;
        actor.faction = variable_struct_exists(d, "faction") ? d.faction : 0;
        actor.coop_kind = asset_get_index(d.kind);
        actor.coop_native_jet = variable_struct_exists(d, "native_jet") && d.native_jet;
        actor.coop_epoch = net.world_tick;
        if (variable_struct_exists(d, "physics"))
        {
            coop_apply_physics(actor, d.physics);
            if (d.life <= 0)
            {
                actor.colliding = false;
            }
        }
        if (d.kind == "Reploid")
        {
            actor.palette_main = d.main;
            actor.palette_skin = d.skin;
            actor.palette_secondary = d.secondary;
            actor.rescued = d.rescued;
            actor.openning = d.opening;
        }
    }
    if (variable_struct_exists(argument0, "boss_hud"))
    {
        coop_apply_boss_hud(argument0.boss_hud);
    }
    if (variable_struct_exists(argument0, "camera_controls"))
    {
        coop_apply_camera_controls(argument0.camera_controls);
    }
    with (obj_coop_foe)
    {
        if (coop_epoch != obj_coop_net.world_tick)
        {
            instance_destroy();
        }
    }
    with (obj_coop_enemy_shot)
    {
        if (coop_epoch != obj_coop_net.world_tick)
        {
            instance_destroy();
        }
    }
}

function coop_shot_consumed(arg0)
{
    if (!instance_exists(obj_coop_net))
    {
        exit;
    }
    var net = obj_coop_net;
    ds_map_set(net.consumed_shots, arg0, true);
    ds_map_delete(net.client_shots, arg0);
    if (global.coop_role == 1)
    {
        coop_send(coop_packet("op", "consumed", "key", arg0, "room", room_get_name(room)));
    }
}

function coop_buddy_input()
{
    if (!coop_play_room())
    {
        exit;
    }
    if (!variable_global_exists("coop_buddy") || !global.coop_buddy || global.coop_role != 1)
    {
        exit;
    }
    global.input_up = false;
    global.input_down = false;
    global.input_left = false;
    global.input_right = false;
    global.input_shoot = false;
    global.input_shoot_pressed = false;
    global.input_shoot_released = false;
    global.input_jump = false;
    global.input_jump_pressed = false;
    global.input_jump_released = false;
    global.input_dash = false;
    global.input_dash_pressed = false;
    global.input_dash_released = false;
    global.input_special = false;
    global.input_special_pressed = false;
    global.input_special_released = false;
    global.input_start_pressed = false;
    global.input_select_pressed = false;
    global.input_giga = false;
    global.input_giga_pressed = false;
    if (!coop_play_room() || !obj_player.movement || global.pause || global.pause_screen || global.death)
    {
        exit;
    }
    var net = obj_coop_net;
    var partner = net.remote;
    if (!instance_exists(partner))
    {
        exit;
    }
    if (!variable_instance_exists(net, "buddy_fire_at"))
    {
        net.buddy_fire_at = 0;
        net.buddy_jump_at = 0;
        net.buddy_burst = 0;
        net.buddy_stuck = 0;
        net.buddy_last_x = obj_player.x;
    }
    var target = -4;
    var best = 270;
    var cy = (obj_player.bbox_top + obj_player.bbox_bottom) / 2;
    with (obj_enemy_parent)
    {
        var range = abs(x - obj_player.x);
        var ey = (bbox_top + bbox_bottom) / 2;
        if (life > 0 && !invul && !armour && range < best && abs(ey - cy) < 22 && !collision_line(obj_player.x, cy, x, ey, obj_solid, false, true))
        {
            target = id;
            best = range;
        }
    }
    var dx = partner.x - (40 * partner.image_xscale) - obj_player.x;
    if (abs(dx) > 48)
    {
        global.input_left = dx < 0;
        global.input_right = dx > 0;
    }
    if (instance_exists(target) && abs(dx) < 150 && net.tick >= net.buddy_fire_at)
    {
        global.input_left = false;
        global.input_right = false;
        obj_player.image_xscale = (target.x < obj_player.x) ? -1 : 1;
        global.input_shoot_pressed = true;
        global.input_shoot = true;
        net.buddy_burst++;
        net.buddy_fire_at = net.tick + (((net.buddy_burst % 3) == 0) ? irandom_range(80, 115) : irandom_range(27, 42));
    }
    var moving = global.input_left || global.input_right;
    net.buddy_stuck = (moving && abs(obj_player.x - net.buddy_last_x) < 0.3) ? (net.buddy_stuck + 1) : 0;
    net.buddy_last_x = obj_player.x;
    var danger = false;
    with (obj_bullet_default)
    {
        if (villainy == 2 && point_distance(x, y, obj_player.x, cy) < 75)
        {
            danger = true;
        }
    }
    var dir = (dx < 0) ? -1 : 1;
    var obstacle = moving && place_meeting(obj_player.x + (dir * 10), obj_player.y, obj_solid);
    var needs_jump = net.buddy_stuck > 12 || obstacle || partner.y < (obj_player.y - 28) || danger;
    if (needs_jump && !obj_player.airborne && net.tick >= net.buddy_jump_at)
    {
        global.input_jump_pressed = true;
        global.input_jump = true;
        net.buddy_jump_at = net.tick + 45;
        net.buddy_stuck = 0;
    }
}

function coop_death_fx(arg0, arg1, arg2)
{
    scr_make_sound(snd_player_death, 1, 1, false);
    for (var i = 0; i < 16; i++)
    {
        var p = instance_create_layer(arg0, arg1 - 12, "Explosions", obj_particle_animated);
        p.sprite_index = arg2;
        p.speed = 2.5;
        p.direction = i * 22.5;
    }
}

function coop_boss_entry_inside(arg0, arg1)
{
    if (!instance_exists(arg0) || !instance_exists(arg1))
    {
        return false;
    }
    var span = global.view_width;
    var left = arg0.bbox_left - 16;
    var right = arg0.bbox_right + 16;
    if (arg0.walk)
    {
        if (arg0.run_direction >= 0)
        {
            right += span;
        }
        else
        {
            left -= span;
        }
    }
    return arg1.x >= left && arg1.x <= right && arg1.y >= (arg0.bbox_top - 24) && arg1.y <= (arg0.bbox_bottom + 24);
}

function coop_boss_ready(arg0)
{
    if (!coop_enabled())
    {
        return true;
    }
    if (global.coop_role != 1 || !instance_exists(obj_coop_net))
    {
        return false;
    }
    var net = obj_coop_net;
    if (!net.connected)
    {
        return true;
    }
    if (!instance_exists(net.remote) || net.remote_room != room_get_name(room))
    {
        return false;
    }
    if (net.remote.coop_hp <= 0)
    {
        return true;
    }
    return coop_boss_entry_inside(arg0, net.remote);
}

function coop_draw_proxy()
{
    if (!variable_instance_exists(id, "coop_render_x"))
    {
        coop_render_x = x;
        coop_render_y = y;
    }
    if (point_distance(coop_render_x, coop_render_y, x, y) > 96)
    {
        coop_render_x = x;
        coop_render_y = y;
    }
    else
    {
        coop_render_x = lerp(coop_render_x, x, 0.55);
        coop_render_y = lerp(coop_render_y, y, 0.55);
    }
    draw_sprite_ext(sprite_index, image_index, coop_render_x, coop_render_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

function coop_scene_packet()
{
    var paused = global.pause_screen || (global.pause && global.pause_delay <= 0 && global.pause_healing <= 0 && !global.death);
    var blocked = paused || instance_exists(obj_dialogue) || instance_exists(obj_comic_parent);
    if (instance_exists(obj_player) && !global.death && global.life > 0)
    {
        blocked = blocked || (!obj_player.movement && !obj_player.hurt && !coop_local_healing());
    }
    return coop_packet("mobility", coop_pack_mobility(), "boss_hud", coop_pack_boss_hud(), "camera_controls", coop_pack_camera_controls(), "solids", coop_solid_changes(), "rain", coop_pack_rain(), "op", "world", "room", room_get_name(room), "epoch", obj_coop_net.room_epoch, "campaign", global.coop_campaign_active, "paused", paused, "blocked", blocked, "actors", coop_play_room() ? coop_pack_world() : [], "progress", coop_pack_progress(), "dialogue", coop_pack_dialogue());
}

function coop_list_array(arg0)
{
    var result = [];
    for (var i = 0; i < ds_list_size(arg0); i++)
    {
        array_push(result, ds_list_find_value(arg0, i));
    }
    return result;
}

function coop_set_list(arg0, arg1)
{
    ds_list_clear(arg0);
    for (var i = 0; i < array_length(arg1); i++)
    {
        ds_list_add(arg0, arg1[i]);
    }
}

function coop_pack_progress()
{
    return coop_packet("reward_type", global.coop_reward_type, "give_weapon", global.give_weapon, "level_completed", global.level_completed, "souls", global.nightmare_souls, "reward_total", obj_coop_net.reward_total, "hearts", global.hearttank, "lives", global.lives, "zero", global.zero_unlock, "levels", coop_list_array(global.level_list), "rescues", coop_list_array(global.rescue_list), "pickups", coop_list_array(global.pickup_list), "weapons", coop_list_array(global.weapon_list), "parts", coop_list_array(global.parts_owned), "stock", coop_list_array(global.parts_store), "events", global.event, "secret", global.tag_secret_completed, "unlocked", global.tag_secret_unlock, "claimed", global.tag_colonel_soul_claimed);
}

function coop_apply_progress(arg0)
{
    var net = obj_coop_net;
    var signature = json_stringify(arg0);
    if (net.progress_signature == signature)
    {
        exit;
    }
    net.progress_signature = signature;
    coop_personal_progress(argument0);
    if (variable_struct_exists(arg0, "reward_type") && arg0.reward_type != "")
    {
        if (global.coop_reward_type != arg0.reward_type)
        {
            coop_apply_character();
            var previous_weapons = global.weapon;
            var previous_choice = global.weapon_choice;
            var previous_list = coop_list_array(global.weapon_list);
            scr_weapon_get("Default", false);
            scr_weapon_get(arg0.reward_type, true);
            global.weapon = previous_weapons;
            global.weapon_choice = previous_choice;
            coop_set_list(global.weapon_list, previous_list);
            global.coop_reward_type = arg0.reward_type;
        }
    }
    else if (variable_struct_exists(arg0, "give_weapon"))
    {
        global.give_weapon = arg0.give_weapon;
    }
    if (variable_struct_exists(arg0, "level_completed"))
    {
        global.level_completed = arg0.level_completed;
    }
    global.hearttank = arg0.hearts;
    global.zero_unlock = arg0.zero;
    coop_set_list(global.level_list, arg0.levels);
    coop_set_list(global.rescue_list, arg0.rescues);
    coop_set_list(global.pickup_list, arg0.pickups);
    global.event = arg0.events;
    global.tag_secret_completed = arg0.secret;
    global.tag_secret_unlock = arg0.unlocked;
    global.tag_colonel_soul_claimed = arg0.claimed;
    var weapon_signature = json_stringify(arg0.weapons);
    if (net.weapon_signature != weapon_signature)
    {
        net.weapon_signature = weapon_signature;
        var previous = global.weapon;
        coop_set_list(global.weapon_list, arg0.weapons);
        scr_weapon_get("Default", false);
        for (var i = 0; i < array_length(arg0.weapons); i++)
        {
            scr_weapon_get(arg0.weapons[i], false);
        }
        for (var i = 0; i < min(array_length(previous), array_length(global.weapon)); i++)
        {
            if (previous[i].type == global.weapon[i].type)
            {
                global.weapon[i].ammo = previous[i].ammo;
            }
        }
    }
}

function coop_pickup_request(arg0)
{
    var net = obj_coop_net;
    var remote = net.remote;
    if (!instance_exists(remote) || remote.coop_hp <= 0)
    {
        exit;
    }
    var found = -4;
    with (obj_pickup)
    {
        if (string(id) == arg0)
        {
            found = id;
        }
    }
    if (!instance_exists(found) || found.pickup_delay || point_distance(found.x, found.y, remote.x, remote.y) > 60)
    {
        exit;
    }
    var type = found.pickup_type;
    var power = found.pickup_power;
    if (type == 0 || type == 1 || type == 8)
    {
        coop_send(coop_packet("op", "pickup_grant", "type", type, "power", power));
        with (found)
        {
            instance_destroy();
        }
    }
    else
    {
        with (found)
        {
            event_perform(ev_collision, obj_player);
        }
        net.profile_dirty = true;
    }
}

function coop_pickup_grant(arg0, arg1)
{
    if (argument0 == 8)
    {
        global.lives = min(9, global.lives + argument1);
        scr_make_sound(snd_pickup, 1, 1, false);
        coop_log("PERSONAL_1UP lives=" + string(global.lives));
    }
    if (arg0 == 0)
    {
        global.life = min(global.lifemax, global.life + arg1);
        scr_make_sound(snd_healing, 0.5, 1, false);
    }
    if (arg0 == 1)
    {
        var choice = global.weapon_choice;
        if (choice == 0)
        {
            for (var i = 1; i < array_length(global.weapon); i++)
            {
                if (global.weapon[i].type != 0 && global.weapon[i].ammo < global.weapon_ammo_max)
                {
                    choice = i;
                    break;
                }
            }
        }
        if (choice > 0)
        {
            global.weapon[choice].ammo = min(global.weapon_ammo_max, global.weapon[choice].ammo + arg1);
        }
        scr_make_sound(snd_weapon_tank, 1, 1, false);
    }
}

function coop_pack_dialogue()
{
    var d = instance_find(obj_dialogue, 0);
    if (!instance_exists(d) || !variable_instance_exists(d, "text"))
    {
        return 0;
    }
    var p = coop_packet("dialogue", d.dialogue, "text", d.text, "left", (d.left_character == "Player") ? global.playable_character.name : d.left_character, "right", (d.right_character == "Player") ? global.playable_character.name : d.right_character);
    var fields = ["page", "cutoff", "timer", "text_delay", "opening", "animation_x", "animation_y", "animation_static", "speaking_is_right", "hidden_faces", "cutscene", "y_offset", "flash", "left_blink", "right_blink", "left_talking", "right_talking", "dr_light_flicker", "name_hidden", "name_removed", "finish", "text_volume"];
    for (var i = 0; i < array_length(fields); i++)
    {
        if (variable_instance_exists(d, fields[i]))
        {
            variable_struct_set(p, fields[i], variable_instance_get(d, fields[i]));
        }
    }
    return p;
}

function coop_apply_dialogue(arg0)
{
    var d = instance_find(obj_coop_dialogue, 0);
    if (!is_struct(arg0))
    {
        if (instance_exists(d))
        {
            instance_destroy(d);
        }
        exit;
    }
    if (!instance_exists(d))
    {
        d = instance_create_depth(0, 0, -10000, obj_coop_dialogue);
    }
    var fields = variable_struct_get_names(arg0);
    for (var i = 0; i < array_length(fields); i++)
    {
        if (fields[i] != "left" && fields[i] != "right")
        {
            variable_instance_set(d, fields[i], variable_struct_get(arg0, fields[i]));
        }
    }
    d.left_character = arg0.left;
    d.right_character = arg0.right;
    d.movement = false;
    global.hud_toggle = false;
}

function coop_rescue_request(arg0)
{
    var remote = obj_coop_net.remote;
    if (!instance_exists(remote) || remote.coop_hp <= 0)
    {
        exit;
    }
    var target = -4;
    with (obj_reploid)
    {
        if (string(id) == arg0)
        {
            target = id;
        }
    }
    if (instance_exists(target) && !target.rescued && !target.openning && !target.transforming && point_distance(target.x, target.y, remote.x, remote.y) < 65)
    {
        with (target)
        {
            event_perform(ev_collision, obj_player);
        }
        obj_coop_net.profile_dirty = true;
    }
}

function coop_party_step()
{
    var net = obj_coop_net;
    if (!global.coop_campaign_active || !coop_play_room() || !instance_exists(obj_player))
    {
        exit;
    }
    if (!net.lives_ready)
    {
        global.lives = 2;
        net.lives_ready = true;
        coop_log("PERSONAL_LIVES_START=2");
    }
    if (global.life <= 0 && net.downed == 0 && !net.spectating)
    {
        net.death_x = obj_player.x;
        net.death_y = obj_player.y;
        net.death_mask = obj_player.mask_index;
        net.downed = 180;
        global.death = true;
        coop_death_fx(net.death_x, net.death_y, global.playable_character.visual.death_ring);
        coop_send(coop_packet("op", "death_fx", "x", net.death_x, "y", net.death_y, "sprite", sprite_get_name(global.playable_character.visual.death_ring)));
        coop_log("PERSONAL_DOWNED lives=" + string(global.lives));
    }
    if (net.downed > 0 || net.spectating)
    {
        global.life = 0;
        global.death = true;
        with (obj_player)
        {
            xspeed = 0;
            yspeed = 0;
            movement = false;
            movement_freeze = true;
            colliding = false;
            mask_index = spr_coop_empty_mask;
            image_alpha = 0;
        }
        if (net.downed > 0)
        {
            net.downed--;
            if (net.downed == 0)
            {
                if (global.lives > 0)
                {
                    global.lives--;
                    var px = global.checkpointx;
                    var py = global.checkpointy;
                    if (instance_exists(net.remote) && net.remote.coop_hp > 0)
                    {
                        px = net.remote.x;
                        py = net.remote.y;
                    }
                    obj_player.x = px;
                    obj_player.y = py;
                    global.life = global.lifemax;
                    global.death = false;
                    with (obj_player)
                    {
                        movement = true;
                        movement_freeze = false;
                        animation_lock = false;
                        image_alpha = 1;
                        hurt = false;
                        mask_index = net.death_mask;
                        colliding = instance_exists(obj_ridechaser) ? obj_ridechaser.coop_rider_colliding : true;
                        player_state = instance_exists(obj_ridechaser) ? obj_ridechaser.coop_rider_state : 0;
                        xspeed = 0;
                        yspeed = 0;
                        recovery = 1;
                        invul = true;
                        alarm[1] = 180;
                        alarm[2] = 1;
                    }
                    obj_game.death_animation = 0;
                    obj_game.alarm[0] = -1;
                    coop_log("PERSONAL_RESPAWN full_hp=" + string(global.life) + " lives=" + string(global.lives));
                }
                else
                {
                    net.spectating = true;
                    coop_log("PERSONAL_SPECTATE");
                }
            }
        }
        if (net.spectating && instance_exists(net.remote) && net.remote.coop_hp > 0)
        {
            obj_player.x = net.remote.x;
            obj_player.y = net.remote.y;
            obj_player.airborne = net.remote.coop_air;
        }
        if (net.spectating && global.coop_role == 1 && (!net.connected || (instance_exists(net.remote) && net.remote.coop_hp <= 0 && net.remote.coop_lives <= 0 && net.remote.coop_spectating)))
        {
            net.party_end_delay++;
            if (net.party_end_delay >= 90)
            {
                net.lives_ready = false;
                net.spectating = false;
                global.death = false;
                global.life = global.lifemax;
                global.lives = 2;
                room_goto(rm_stage_select);
            }
        }
        else
        {
            net.party_end_delay = 0;
        }
    }
}

function coop_trim_tag_upgrades()
{
    if (!coop_enabled())
    {
        exit;
    }
    for (var code = 902; code <= 903; code++)
    {
        if (variable_global_exists("parts_store"))
        {
            var i = ds_list_find_index(global.parts_store, code);
            if (i != -1)
            {
                ds_list_delete(global.parts_store, i);
            }
        }
        if (variable_global_exists("parts_owned"))
        {
            var i = ds_list_find_index(global.parts_owned, code);
            if (i != -1)
            {
                ds_list_delete(global.parts_owned, i);
            }
        }
        if (variable_global_exists("parts_equipped"))
        {
            var i = ds_list_find_index(global.parts_equipped, code);
            if (i != -1)
            {
                ds_list_delete(global.parts_equipped, i);
            }
        }
    }
}

function coop_in_interest(arg0, arg1)
{
    return point_distance(arg0, arg1, obj_player.x, obj_player.y) < 900 || (instance_exists(obj_coop_net.remote) && point_distance(arg0, arg1, obj_coop_net.remote.x, obj_coop_net.remote.y) < 900);
}

function coop_proxy_motion()
{
    if (!variable_instance_exists(id, "coop_target_x"))
    {
        exit;
    }
    var age = clamp((current_time - coop_sample_time) / 16.6667, 0, 2);
    var px = coop_target_x + (coop_vx * age);
    var py = coop_target_y + (coop_vy * age);
    x = lerp(x, px, 0.65);
    y = lerp(y, py, 0.65);
    if (abs(x - px) < 0.1)
    {
        x = px;
    }
    if (abs(y - py) < 0.1)
    {
        y = py;
    }
}

function coop_request_hit(arg0, arg1)
{
    if (!coop_client() || arg1.villainy != 0 || arg1.passive || arg1.damage <= 0 || arg0.life <= 0)
    {
        exit;
    }
    var key = "2-" + string(arg1.id);
    var marker = "request:" + key + ":" + arg0.coop_server_id;
    if (ds_map_exists(obj_coop_net.consumed_shots, marker))
    {
        exit;
    }
    var shots = coop_pack_shots(2);
    for (var i = 0; i < array_length(shots); i++)
    {
        if (shots[i].key == string(arg1.id))
        {
            ds_map_set(obj_coop_net.consumed_shots, marker, true);
            coop_send(coop_packet("op", "hit_request", "room", room_get_name(room), "target", arg0.coop_server_id, "attack", shots[i]));
            exit;
        }
    }
}

function coop_resolve_hit(arg0, arg1)
{
    if (global.coop_role != 1 || !is_struct(arg1) || arg1.owner != 2 || arg1.passive || arg1.damage <= 0)
    {
        exit;
    }
    var net = obj_coop_net;
    if (!instance_exists(net.remote) || net.remote.coop_hp <= 0)
    {
        exit;
    }
    var target = -4;
    with (obj_enemy_parent)
    {
        if (string(id) == arg0)
        {
            target = id;
        }
    }
    if (!instance_exists(target) || target.life <= 0)
    {
        exit;
    }
    var reach = arg1.melee ? 160 : 90;
    if (point_distance(arg1.x, arg1.y, target.x, target.y) > reach)
    {
        exit;
    }
    if (arg1.melee && point_distance(net.remote.x, net.remote.y, target.x, target.y) > 180)
    {
        exit;
    }
    var key = "2-" + arg1.key;
    var marker = "hit:" + key + ":" + arg0;
    if (ds_map_exists(net.consumed_shots, marker) || ds_map_exists(net.consumed_shots, key))
    {
        exit;
    }
    ds_map_set(net.consumed_shots, marker, true);
    var shot = ds_map_exists(net.client_shots, key) ? ds_map_find_value(net.client_shots, key) : -4;
    if (!instance_exists(shot))
    {
        shot = instance_create_layer(arg1.x, arg1.y, "Projectiles", obj_coop_shot);
        shot.coop_owner = 2;
        shot.coop_server_id = key;
        ds_map_set(net.client_shots, key, shot);
    }
    var fields = ["damage", "damage_mult", "melee", "melee_frames", "special", "special_type", "piercing", "piercing_armour", "ignore_iframes", "crit_disable", "explosive", "passive", "tick"];
    for (var i = 0; i < array_length(fields); i++)
    {
        variable_instance_set(shot, fields[i], variable_struct_get(arg1, fields[i]));
    }
    shot.phasing = variable_struct_exists(argument1, "phasing") && argument1.phasing;
    shot.yammar_marking = variable_struct_exists(argument1, "yammar_marking") ? argument1.yammar_marking : 0;
    coop_visual(shot, arg1);
    shot.coop_epoch = net.shot_epoch;
    shot.villainy = 0;
    shot.coop_character = variable_struct_exists(argument1, "character") ? argument1.character : net.guest_character;
    with (shot)
    {
        with (target)
        {
            event_perform(ev_collision, obj_bullet_default);
        }
    }
}

function coop_send_native_effect()
{
    if (sprite_index == -1 || variable_instance_exists(id, "coop_fx_sent") || !coop_in_interest(x, y))
    {
        exit;
    }
    coop_fx_sent = true;
    ds_map_set(obj_coop_net.fx_sent, string(id), id);
    coop_send(coop_packet("op", "native_fx", "key", string(id), "room", room_get_name(room), "object", object_get_name(object_index), "sprite", sprite_get_name(sprite_index), "x", x, "y", y, "frame", image_index, "rate", image_speed, "sx", image_xscale, "sy", image_yscale, "angle", image_angle, "alpha", image_alpha, "blend", image_blend, "depth", depth, "palette", variable_instance_exists(id, "palette") ? palette : 0, "palette_sprite", (variable_instance_exists(id, "palette_type") && palette_type != 0 && palette_type != -1) ? sprite_get_name(palette_type) : ""));
}

function coop_receive_native_effect(arg0)
{
    if (!coop_client() || arg0.room != room_get_name(room))
    {
        exit;
    }
    var sprite = asset_get_index(arg0.sprite);
    if (sprite == -1)
    {
        exit;
    }
    var type = asset_get_index(arg0.object);
    if (type != obj_explosion && type != obj_particle_cut)
    {
        type = obj_explosion;
    }
    if (ds_map_exists(obj_coop_net.fx_remote, argument0.key) && instance_exists(ds_map_find_value(obj_coop_net.fx_remote, argument0.key)))
    {
        exit;
    }
    var fx = instance_create_depth(arg0.x, arg0.y, arg0.depth, type);
    ds_map_set(obj_coop_net.fx_remote, argument0.key, fx);
    fx.coop_fx_seen = current_time;
    fx.coop_remote_effect = true;
    fx.sprite_index = sprite;
    fx.image_index = arg0.frame;
    fx.image_speed = 0;
    fx.image_xscale = arg0.sx;
    fx.image_yscale = arg0.sy;
    fx.image_angle = arg0.angle;
    fx.image_alpha = arg0.alpha;
    fx.image_blend = arg0.blend;
    if (variable_instance_exists(fx, "palette"))
    {
        fx.palette = arg0.palette;
    }
    if (variable_instance_exists(fx, "palette_type"))
    {
        fx.palette_type = (arg0.palette_sprite == "") ? 0 : asset_get_index(arg0.palette_sprite);
    }
    coop_log("REMOTE_FX " + arg0.sprite);
}

function coop_pack_physics(arg0)
{
    var packet = coop_packet();
    var fields = ["colliding", "collide_vertical", "collide_horizontal", "priority", "type", "ignore_types", "axis"];
    for (var i = 0; i < array_length(fields); i++)
    {
        if (variable_instance_exists(arg0, fields[i]))
        {
            variable_struct_set(packet, fields[i], variable_instance_get(arg0, fields[i]));
        }
    }
    return packet;
}

function coop_apply_physics(arg0, arg1)
{
    var fields = variable_struct_get_names(arg1);
    for (var i = 0; i < array_length(fields); i++)
    {
        variable_instance_set(arg0, fields[i], variable_struct_get(arg1, fields[i]));
    }
}

function coop_fx_lifecycle()
{
    var net = obj_coop_net;
    var key = ds_map_find_first(net.fx_sent);
    while (!is_undefined(key))
    {
        var next = ds_map_find_next(net.fx_sent, key);
        var fx = ds_map_find_value(net.fx_sent, key);
        if (!instance_exists(fx))
        {
            coop_send(coop_packet("op", "fx_end", "room", room_get_name(room), "key", key));
            ds_map_delete(net.fx_sent, key);
        }
        else if ((net.tick % 2) == 0)
        {
            coop_send(coop_packet("op", "fx_update", "room", room_get_name(room), "key", key, "x", fx.x, "y", fx.y, "frame", fx.image_index, "alpha", fx.image_alpha, "sx", fx.image_xscale, "sy", fx.image_yscale, "angle", fx.image_angle));
        }
        key = next;
    }
}

function coop_fx_update(arg0)
{
    if (!coop_client() || arg0.room != room_get_name(room) || !ds_map_exists(obj_coop_net.fx_remote, arg0.key))
    {
        exit;
    }
    var fx = ds_map_find_value(obj_coop_net.fx_remote, arg0.key);
    if (!instance_exists(fx))
    {
        exit;
    }
    fx.x = arg0.x;
    fx.y = arg0.y;
    fx.image_index = arg0.frame;
    fx.image_alpha = arg0.alpha;
    fx.image_xscale = arg0.sx;
    fx.image_yscale = arg0.sy;
    fx.image_angle = arg0.angle;
    fx.coop_fx_seen = current_time;
}

function coop_fx_end(arg0)
{
    if (!coop_client() || arg0.room != room_get_name(room) || !ds_map_exists(obj_coop_net.fx_remote, arg0.key))
    {
        exit;
    }
    var fx = ds_map_find_value(obj_coop_net.fx_remote, arg0.key);
    if (instance_exists(fx))
    {
        instance_destroy(fx);
    }
    ds_map_delete(obj_coop_net.fx_remote, arg0.key);
}

function coop_source_can_hit(arg0)
{
    if (!instance_exists(arg0) || !arg0.visible || arg0.sprite_index < 0 || arg0.image_alpha <= 0 || arg0.damage <= 0)
    {
        return false;
    }
    if (variable_instance_exists(arg0, "coop_seen") && (current_time - arg0.coop_seen) > 250)
    {
        return false;
    }
    if (variable_instance_exists(arg0, "coop_epoch") && arg0.coop_epoch != obj_coop_net.world_tick)
    {
        return false;
    }
    return true;
}

function coop_connection_lost()
{
    with (obj_coop_net)
    {
        connected = false;
        peer = -1;
        status = "Connection lost";
        host_blocked = false;
        if (instance_exists(remote))
        {
            remote.visible = false;
        }
    }
    if (coop_client() && coop_play_room())
    {
        with (obj_coop_foe)
        {
            damage = 0;
            colliding = false;
        }
        with (obj_coop_enemy_shot)
        {
            damage = 0;
            passive = true;
        }
        if (!global.death)
        {
            global.pause = false;
            global.pause_screen = false;
            with (obj_player)
            {
                movement = true;
                movement_freeze = false;
            }
        }
    }
    coop_log("CONNECTION_LOST_CONTROLS_RELEASED");
}

function coop_enemy_target()
{
    var local = obj_player;
    if (!instance_exists(local))
    {
        return local;
    }
    if (coop_enabled() && global.coop_role == 1 && instance_exists(obj_coop_net) && obj_coop_net.connected)
    {
        var peer = obj_coop_net.remote;
        if (instance_exists(peer) && peer.coop_hp > 0 && obj_coop_net.remote_room == room_get_name(room))
        {
            if (global.life <= 0 || point_distance(x, y, peer.x, peer.y) < point_distance(x, y, local.x, local.y))
            {
                return peer;
            }
        }
    }
    return local;
}

function coop_partner_left()
{
    audio_stop_sound(snd_coop_peer_charge);
    var net = obj_coop_net;
    var old_peer = net.peer;
    net.connected = false;
    net.peer = -1;
    net.host_blocked = false;
    net.status = "Partner left";
    global.coop_buddy = false;
    if (instance_exists(net.remote))
    {
        net.remote.coop_hp = 0;
        net.remote.visible = false;
    }
    with (obj_coop_spawnzone)
    {
        instance_destroy();
    }
    with (obj_coop_shot)
    {
        if (coop_owner == 2)
        {
            coop_expired = true;
            instance_destroy();
        }
    }
    if (old_peer >= 0)
    {
        network_destroy(old_peer);
    }
    coop_log("PARTNER_LEFT_HOST_CONTINUES");
}

function coop_leave_session()
{
    audio_stop_sound(snd_coop_peer_charge);
    if (global.coop_role != 2)
    {
        exit;
    }
    coop_personal_save();
    coop_send(coop_packet("op", "leave"));
    with (obj_coop_net)
    {
        instance_destroy();
    }
    global.coop_role = 0;
    global.coop_campaign_active = false;
    global.coop_preview_active = false;
    global.coop_buddy = false;
    global.pause = false;
    global.pause_screen = false;
    global.pause_screen_state = 0;
    global.death = false;
    global.pause_menu = "Options";
    global.pause_menu_sub = "Title";
    global.music = snd_music_title;
    coop_log("GUEST_LEFT_TO_TITLE");
    room_goto(rm_title);
}

function coop_illumina_target()
{
    if (variable_instance_exists(id, "coop_attack_target") && instance_exists(coop_attack_target))
    {
        if (coop_attack_target == obj_coop_net.remote && obj_coop_net.connected && coop_attack_target.coop_hp > 0)
        {
            return coop_attack_target;
        }
        if (coop_attack_target == obj_player && global.life > 0)
        {
            return coop_attack_target;
        }
    }
    return coop_enemy_target();
}

function coop_personal_save()
{
    if (!coop_client() || !instance_exists(obj_coop_net) || !obj_coop_net.personal_ready)
    {
        exit;
    }
    var p = coop_packet("souls", global.nightmare_souls, "owned", coop_list_array(global.parts_owned), "equipped", coop_list_array(global.parts_equipped), "stock", coop_list_array(global.parts_store), "armour", [global.x_armour_head, global.x_armour_chest, global.x_armour_arm, global.x_armour_leg, global.zero_armour_black]);
    var data = json_stringify(p);
    if (data == obj_coop_net.personal_signature)
    {
        exit;
    }
    obj_coop_net.personal_signature = data;
    var f = file_text_open_write("coop_personal.txt");
    file_text_write_string(f, data);
    file_text_close(f);
}

function coop_personal_progress(arg0)
{
    var net = obj_coop_net;
    var rewards = variable_struct_exists(arg0, "reward_total") ? arg0.reward_total : 0;
    if (!net.personal_ready)
    {
        global.nightmare_souls = arg0.souls;
        if (file_exists("coop_personal.txt"))
        {
            var f = file_text_open_read("coop_personal.txt");
            var raw = file_text_read_string(f);
            file_text_close(f);
            try
            {
                var own = json_parse(raw);
                global.nightmare_souls = own.souls;
                coop_set_list(global.parts_owned, own.owned);
                coop_set_list(global.parts_equipped, own.equipped);
                coop_set_list(global.parts_store, own.stock);
                if (variable_struct_exists(own, "armour") && is_array(own.armour) && array_length(own.armour) == 5)
                {
                    global.x_armour_head = own.armour[0];
                    global.x_armour_chest = own.armour[1];
                    global.x_armour_arm = own.armour[2];
                    global.x_armour_leg = own.armour[3];
                    global.zero_armour_black = own.armour[4];
                    global.playable_character = (global.coop_character == "X") ? Character_X() : Character_Zero();
                }
            }
            catch (err)
            {
                coop_log("PERSONAL_SAVE_READ_FAILED");
            }
        }
        net.reward_seen = rewards;
        net.personal_ready = true;
    }
    else
    {
        var earned = max(0, rewards - net.reward_seen);
        global.nightmare_souls += earned;
        net.reward_seen = rewards;
        if (earned > 0)
        {
            coop_log("PARTNER_SOUL_REWARD=" + string(earned));
        }
    }
    var catalog = [argument0.parts, argument0.stock];
    for (var group = 0; group < array_length(catalog); group++)
    {
        for (var index = 0; index < array_length(catalog[group]); index++)
        {
            var part = catalog[group][index];
            if (part != 902 && part != 903 && ds_list_find_index(global.parts_owned, part) == -1 && ds_list_find_index(global.parts_store, part) == -1)
            {
                ds_list_add(global.parts_store, part);
            }
        }
    }
}

function coop_solid_key()
{
    if (!variable_instance_exists(id, "coop_solid_key_cached"))
    {
        coop_solid_key_cached = object_get_name(object_index) + ":" + string(xstart) + ":" + string(ystart);
    }
    return coop_solid_key_cached;
}

function coop_register_solids()
{
    if (global.coop_role != 1 || !instance_exists(obj_coop_net))
    {
        exit;
    }
    var net = obj_coop_net;
    with (obj_solid)
    {
        var k = coop_solid_key();
        ds_map_set(net.solid_registry, id, k);
    }
}

function coop_solid_changes()
{
    var net = obj_coop_net;
    coop_register_solids();
    var k = ds_map_find_first(net.solid_registry);
    while (!is_undefined(k))
    {
        var next = ds_map_find_next(net.solid_registry, k);
        if (!instance_exists(k))
        {
            var stable = ds_map_find_value(net.solid_registry, k);
            var still_alive = false;
            with (obj_solid)
            {
                if (coop_solid_key() == stable)
                {
                    still_alive = true;
                }
            }
            if (!still_alive && !ds_map_exists(net.solid_removed, stable))
            {
                ds_map_set(net.solid_removed, stable, true);
                net.solid_revision++;
                coop_log("SHARED_SOLID_REMOVED " + stable);
            }
            ds_map_delete(net.solid_registry, k);
        }
        k = next;
    }
    var gone = [];
    k = ds_map_find_first(net.solid_removed);
    while (!is_undefined(k))
    {
        array_push(gone, k);
        k = ds_map_find_next(net.solid_removed, k);
    }
    return coop_packet("revision", net.solid_revision, "removed", gone);
}

function coop_apply_solids(arg0)
{
    var net = obj_coop_net;
    if (!is_struct(arg0) || arg0.revision == net.solid_seen_revision)
    {
        exit;
    }
    var gone = arg0.removed;
    with (obj_solid)
    {
        var stable = coop_solid_key();
        for (var i = 0; i < array_length(gone); i++)
        {
            if (stable == gone[i])
            {
                instance_destroy(id, false);
                break;
            }
        }
    }
    net.solid_seen_revision = arg0.revision;
    coop_log("SHARED_SOLIDS_APPLIED revision=" + string(arg0.revision) + " removed=" + string(array_length(gone)));
}

function coop_pack_environment_actor(arg0)
{
    var p = coop_packet();
    var fields = ["shield_strength", "shield_fade", "heat"];
    for (var i = 0; i < array_length(fields); i++)
    {
        if (variable_instance_exists(arg0, fields[i]))
        {
            variable_struct_set(p, fields[i], variable_instance_get(arg0, fields[i]));
        }
    }
    return p;
}

function coop_apply_environment_actor(arg0, arg1)
{
    if (!is_struct(arg1))
    {
        exit;
    }
    var fields = variable_struct_get_names(arg1);
    for (var i = 0; i < array_length(fields); i++)
    {
        variable_instance_set(arg0, fields[i], variable_struct_get(arg1, fields[i]));
    }
}

function coop_pack_rain()
{
    var rains = [];
    with (obj_acid_rain)
    {
        array_push(rains, coop_packet("x", xstart, "y", ystart, "active", rain_active));
    }
    return rains;
}

function coop_apply_rain(arg0)
{
    with (obj_acid_rain)
    {
        for (var i = 0; i < array_length(arg0); i++)
        {
            if (xstart == arg0[i].x && ystart == arg0[i].y)
            {
                rain_active = arg0[i].active;
                break;
            }
        }
    }
}

function coop_local_healing()
{
    var active = false;
    if (!instance_exists(obj_player))
    {
        return false;
    }
    with (obj_healing_pad)
    {
        if (coop_heal_owner == obj_player.id && state > 0 && state < 4)
        {
            active = true;
        }
    }
    return active;
}

function coop_pad_release(arg0)
{
    if (instance_exists(effect))
    {
        instance_destroy(effect);
        effect = -4;
    }
    if (instance_exists(coop_heal_owner) && global.life > 0 && !global.death)
    {
        with (coop_heal_owner)
        {
            animation_lock = false;
            movement_freeze = false;
            movement = true;
        }
    }
    state = 4;
    wall_animation = 0;
    pad_animation = 0;
    image_index = 0;
    coop_heal_owner = -4;
    coop_heal_age = 0;
    coop_log(arg0 ? "HEAL_PAD_CANCELLED" : "HEAL_PAD_FINISHED");
}

function coop_cancel_local_healing()
{
    with (obj_healing_pad)
    {
        if (coop_heal_owner == obj_player.id && state > 0 && state < 4)
        {
            coop_pad_release(true);
        }
    }
}

function coop_healing_pad_step()
{
    if (!instance_exists(obj_player))
    {
        exit;
    }
    var p = obj_player;
    if (state > 0 && state < 4)
    {
        coop_heal_age++;
        if (global.life <= 0 || global.death || p.hurt || point_distance(p.x, p.y, x, y + 4) > 32 || coop_heal_age > 240)
        {
            coop_pad_release(true);
            exit;
        }
        if (global.pause_screen)
        {
            exit;
        }
        p.x = x;
        p.y = y + 4;
        p.xspeed = 0;
        p.yspeed = 0;
        p.movement = false;
        p.animation_lock = true;
    }
    switch (state)
    {
        case 0:
            if (!global.pause && !global.pause_screen && !p.hurt && !p.animation_lock && p.movement && !p.airborne && global.life > 0 && global.life < global.lifemax && abs(p.x - x) < 10 && place_meeting(x, y - 1, obj_player))
            {
                state = 1;
                coop_heal_owner = p.id;
                coop_heal_age = 0;
                wall_animation = 0;
                pad_animation = 0;
                healing_animation = 0;
                p.x = x;
                p.y = y + 4;
                p.xspeed = 0;
                p.yspeed = 0;
                p.movement = false;
                p.animation_lock = true;
                p.sprite_index = global.playable_character.action.idle;
                effect = instance_create_layer(x, y, "Explosions", obj_capsule_effect);
                effect.sprite_index = spr_healingpad_wall;
                effect.blendmode = true;
                scr_make_sound(snd_healing_pad, 1, 1, false);
                coop_log("HEAL_PAD_STARTED");
            }
            break;
        case 1:
            if ((coop_heal_age % 2) == 0)
            {
                wall_animation++;
                if (instance_exists(effect))
                {
                    effect.image_index = wall_animation;
                }
            }
            if (wall_animation >= 9)
            {
                state = 2;
                wall_animation = 0;
                if (instance_exists(effect))
                {
                    effect.sprite_index = spr_healingpad_energy;
                }
            }
            break;
        case 2:
            if (global.life < global.lifemax)
            {
                global.life = min(global.lifemax, global.life + 0.5);
                scr_make_sound(snd_healing, 0.5, 1, false);
                if (instance_exists(effect))
                {
                    effect.image_index = healing_animation / 2;
                }
            }
            else
            {
                state = 3;
                wall_animation = 0;
                if (instance_exists(effect))
                {
                    effect.sprite_index = spr_healingpad_energy_end;
                }
            }
            break;
        case 3:
            if ((coop_heal_age % 2) == 0)
            {
                wall_animation++;
                if (instance_exists(effect))
                {
                    effect.image_index = wall_animation;
                }
            }
            if (wall_animation >= 11)
            {
                coop_pad_release(false);
            }
            break;
        case 4:
            if (!place_meeting(x, y - 1, obj_player))
            {
                state = 0;
            }
            break;
    }
    if (state > 0 && state < 4)
    {
        pad_animation++;
        if ((pad_animation % 2) == 0)
        {
            image_index++;
        }
        healing_animation++;
    }
}

function scr_get_input()
{
    coop_original_get_input();
    if (coop_enabled() && global.input_start_pressed && instance_exists(obj_player) && coop_local_healing())
    {
        coop_cancel_local_healing();
    }
}

function coop_pack_boss_hud()
{
    var list = [];
    with (obj_bossmanager)
    {
        if (instance_exists(boss) && (bossfight_state == 7 || bossfight_state == 8) && !hide_health)
        {
            array_push(list, coop_packet("x", xstart, "y", ystart, "boss", string(boss.id), "state", bossfight_state, "intro", lifebar_intro, "miniboss", miniboss));
        }
    }
    return list;
}

function coop_apply_boss_hud(arg0)
{
    with (obj_bossmanager)
    {
        boss = -4;
        hide_health = true;
    }
    for (var i = 0; i < array_length(arg0); i++)
    {
        var p = arg0[i];
        var actor = ds_map_exists(obj_coop_net.entities, p.boss) ? ds_map_find_value(obj_coop_net.entities, p.boss) : -4;
        if (instance_exists(actor))
        {
            var hud = -4;
            with (obj_bossmanager)
            {
                if (xstart == p.x && ystart == p.y)
                {
                    hud = id;
                }
            }
            if (!instance_exists(hud))
            {
                hud = instance_create_depth(p.x, p.y, -100, obj_bossmanager);
            }
            hud.boss = actor;
            hud.bossfight_state = p.state;
            hud.lifebar_intro = max(0, p.intro);
            hud.miniboss = p.miniboss;
            hud.hide_health = false;
        }
    }
}

function coop_pack_camera_controls()
{
    var list = [];
    with (obj_camera_bossroom)
    {
        array_push(list, coop_packet("kind", object_get_name(object_index), "x", xstart, "y", ystart, "active", active));
    }
    with (obj_camera_freemove)
    {
        array_push(list, coop_packet("kind", object_get_name(object_index), "x", xstart, "y", ystart, "active", active));
    }
    return list;
}

function coop_apply_camera_controls(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        var p = arg0[i];
        var kind = asset_get_index(p.kind);
        if (kind == obj_camera_bossroom || kind == obj_camera_freemove)
        {
            with (kind)
            {
                if (xstart == p.x && ystart == p.y)
                {
                    active = p.active;
                }
            }
        }
    }
}

function coop_local_broker()
{
    return false;
}

function coop_local_packet()
{
    return false;
}

function coop_local_input()
{
    return false;
}

function coop_local_camera()
{
    return false;
}

function coop_local_tether()
{
    return false;
}

function coop_online_endpoint(arg0)
{
    arg0 = string_trim(arg0);
    if (arg0 == "")
    {
        return false;
    }
    var colon = string_pos(":", arg0);
    var addr = arg0;
    var port = global.coop_port;
    if (colon > 0)
    {
        addr = string_copy(arg0, 1, colon - 1);
        var digits = string_delete(arg0, 1, colon);
        if (digits == "" || string_digits(digits) != digits)
        {
            return false;
        }
        port = real(digits);
    }
    if (addr == "" || port < 1024 || port > 65535 || floor(port) != port)
    {
        return false;
    }
    global.coop_host = addr;
    global.coop_port = port;
    return true;
}

function coop_local_guest_menu()
{
    return false;
}

function coop_local_receive_menu()
{
    return false;
}

function coop_zone_key(arg0)
{
    if (!instance_exists(arg0))
    {
        return "";
    }
    return object_get_name(arg0.object_index) + ":" + string(arg0.xstart) + ":" + string(arg0.ystart);
}

function coop_platform_zone_active(arg0)
{
    if ((!coop_enabled() || global.life > 0) && (arg0 == obj_player.camera_zone || arg0 == obj_player.camera_lasttouch))
    {
        return true;
    }
    if (!coop_enabled() || global.coop_role != 1 || !obj_coop_net.connected || !instance_exists(obj_coop_net.remote) || obj_coop_net.remote.coop_hp <= 0)
    {
        return false;
    }
    var key = coop_zone_key(arg0);
    return key != "" && (key == obj_coop_net.remote.coop_zone || key == obj_coop_net.remote.coop_last_zone);
}

function coop_pack_mobility()
{
    var platforms = [];
    with (obj_solid_moving)
    {
        array_push(platforms, coop_packet("key", coop_solid_key(), "x", x, "y", y, "stop", stop, "axis", axis, "dir", dir, "speed", move_speed, "sprite", sprite_get_name(sprite_index), "sx", image_xscale, "sy", image_yscale));
    }
    var bike = coop_packet("active", false, "cinematic", coop_ride_cinematic(), "x", obj_player.x, "y", obj_player.y);
    if (instance_exists(obj_ridechaser))
    {
        var r = obj_ridechaser;
        if (!variable_instance_exists(r, "coop_rider_state"))
        {
            r.coop_rider_state = 4;
        }
        if (global.life > 0 && !global.death)
        {
            r.coop_rider_state = obj_player.player_state;
            r.coop_rider_colliding = obj_player.colliding;
        }
        bike = coop_packet("active", true, "scroll", r.ridechaser_moving, "speed", r.ridechaser_speed, "action", r.action, "type", r.ridechaser_type, "mode", r.coop_rider_state, "colliding", r.coop_rider_colliding, "cinematic", coop_ride_cinematic(), "x", obj_player.x, "y", obj_player.y);
    }
    return coop_packet("platforms", platforms, "bike", bike);
}

function coop_receive_mobility(arg0)
{
    if (!coop_client())
    {
        exit;
    }
    obj_coop_net.mobility_epoch++;
    var epoch = obj_coop_net.mobility_epoch;
    for (var i = 0; i < array_length(arg0.platforms); i++)
    {
        var p = arg0.platforms[i];
        var target = -4;
        with (obj_solid_moving)
        {
            if (coop_solid_key() == p.key)
            {
                target = id;
            }
        }
        if (!instance_exists(target))
        {
            target = instance_create_depth(p.x, p.y, 0, obj_solid_moving);
            target.coop_solid_key_cached = p.key;
            target.sprite_index = asset_get_index(p.sprite);
            target.image_xscale = p.sx;
            target.image_yscale = p.sy;
        }
        with (target)
        {
            coop_platform_epoch = epoch;
            coop_platform_x = p.x;
            coop_platform_y = p.y;
            coop_platform_vx = (!p.stop && p.axis == 0) ? (p.speed * p.dir) : 0;
            coop_platform_vy = (!p.stop && p.axis == 1) ? (p.speed * p.dir) : 0;
            coop_platform_seen = current_time;
            stop = p.stop;
            axis = p.axis;
            dir = p.dir;
            move_speed = p.speed;
        }
    }
    with (obj_solid_moving)
    {
        if (variable_instance_exists(id, "coop_platform_epoch") && coop_platform_epoch != epoch)
        {
            instance_destroy();
        }
    }
    if (arg0.bike.active)
    {
        if (!instance_exists(obj_ridechaser))
        {
            instance_create_depth(0, 0, 0, obj_ridechaser);
            obj_player.x = arg0.bike.x + 24;
            obj_player.y = arg0.bike.y;
        }
        var r = obj_ridechaser;
        r.coop_scroll = arg0.bike.scroll;
        r.coop_scroll_seen = current_time;
        r.ridechaser_moving = arg0.bike.scroll;
        r.ridechaser_speed = arg0.bike.speed;
        r.action = arg0.bike.action;
        r.ridechaser_type = arg0.bike.type;
        r.coop_rider_state = arg0.bike.mode;
        r.coop_rider_colliding = arg0.bike.colliding;
        if (!global.death)
        {
            if (arg0.bike.cinematic)
            {
                obj_player.x = arg0.bike.x + 24;
                obj_player.y = arg0.bike.y;
                obj_player.xspeed = 0;
                obj_player.yspeed = 0;
            }
            obj_player.player_state = arg0.bike.mode;
            obj_player.colliding = r.coop_rider_colliding;
        }
    }
    else if (instance_exists(obj_ridechaser))
    {
        instance_destroy(obj_ridechaser);
        if (!global.death)
        {
            obj_player.x = arg0.bike.x + 24;
            obj_player.y = arg0.bike.y;
            obj_player.xspeed = 0;
            obj_player.yspeed = 0;
        }
        if (!global.death)
        {
            obj_player.colliding = true;
        }
    }
    if (!arg0.bike.active && arg0.bike.cinematic && !global.death)
    {
        obj_player.x = arg0.bike.x + 24;
        obj_player.y = arg0.bike.y;
        obj_player.xspeed = 0;
        obj_player.yspeed = 0;
    }
}

function coop_client_ride_step()
{
    if (global.pause_screen || global.pause)
    {
        audio_stop_sound(snd_bike);
        exit;
    }
    if (variable_instance_exists(id, "coop_scroll_seen"))
    {
        ridechaser_moving = coop_scroll - (ridechaser_speed * clamp((current_time - coop_scroll_seen) / 16.6667, 0, 3));
        if (instance_exists(obj_background))
        {
            obj_background.bg_scrolling = ridechaser_moving / 40;
        }
    }
    if (!audio_is_playing(snd_bike))
    {
        scr_make_sound(snd_bike, 0.5, 1, true);
    }
}

function coop_client_platform_step()
{
    if (!variable_instance_exists(id, "coop_platform_seen") || global.pause)
    {
        exit;
    }
    exhaust = (coop_platform_vy < 0) ? spr_platform_exhaust_big : spr_platform_exhaust;
    var elapsed = clamp((current_time - coop_platform_seen) / 16.6667, 0, 3);
    var tx = coop_platform_x + (coop_platform_vx * elapsed);
    var ty = coop_platform_y + (coop_platform_vy * elapsed);
    var dx = tx - x;
    var dy = ty - y;
    if (abs(dx) > 64 || abs(dy) > 64)
    {
        x = tx;
        y = ty;
        exit;
    }
    scr_move_along_with_platform(dx, 0);
    x += dx;
    with (obj_player)
    {
        if (place_meeting(x, y + 1, other) && dy != 0)
        {
            y += dy;
            yspeed = 0;
            airborne = false;
        }
    }
    y += dy;
    if (dx != 0)
    {
        scr_platform_push_objects(dx, ceil(abs(dx)) * sign(dx), 0);
    }
    if (dy != 0)
    {
        scr_platform_push_objects(dy, ceil(abs(dy)) * sign(dy), 1);
    }
}

function coop_ride_ready()
{
    if (obj_player.movement)
    {
        return true;
    }
    return coop_enabled() && global.coop_role == 1 && obj_coop_net.connected && instance_exists(obj_coop_net.remote) && obj_coop_net.remote.coop_hp > 0 && obj_coop_net.remote.coop_movable;
}

function coop_ride_cinematic()
{
    if (global.life <= 0 || global.death)
    {
        return false;
    }
    if (instance_exists(obj_cutscene_heatnix_intro) || instance_exists(obj_cutscene_level_start_bike) || instance_exists(obj_cutscene_heatnix_escape))
    {
        return true;
    }
    var c = instance_find(obj_cutscene_heatnix_chase, 0);
    if (instance_exists(c) && c.action > 0)
    {
        return true;
    }
    var e = instance_find(obj_enemy_heatnix, 0);
    return instance_exists(e) && e.state == "Defeated";
}

function coop_armour_rows()
{
    if (global.playable_character.name == "Zero")
    {
        return [["ARMOUR", "zero_armour_black", "black_armour_get", "Black Zero", "black_armour_get", "Black Zero"]];
    }
    return [["HEAD", "x_armour_head", "blade_head_get", "Blade Head", "shadow_head_get", "Shadow Head"], ["BODY", "x_armour_chest", "blade_chest_get", "Blade Chest", "shadow_chest_get", "Shadow Chest"], ["ARMS", "x_armour_arm", "blade_arm_get", "Blade Arm", "shadow_arm_get", "Shadow Arm"], ["LEGS", "x_armour_leg", "blade_leg_get", "Blade Leg", "shadow_leg_get", "Shadow Leg"]];
}

function coop_armour_cycle(arg0, arg1)
{
    var choices = [0];
    if (variable_global_get(arg0[2]))
    {
        array_push(choices, arg0[3]);
    }
    if (arg0[5] != arg0[3] && variable_global_get(arg0[4]))
    {
        array_push(choices, arg0[5]);
    }
    var chosen = 0;
    for (var i = 0; i < array_length(choices); i++)
    {
        if (choices[i] == variable_global_get(arg0[1]))
        {
            chosen = i;
        }
    }
    variable_global_set(arg0[1], choices[(chosen + arg1 + array_length(choices)) % array_length(choices)]);
    global.playable_character = (global.playable_character.name == "X") ? Character_X() : Character_Zero();
    scr_make_sound(snd_menu_equip, 1, 1, false);
    coop_personal_save();
}
