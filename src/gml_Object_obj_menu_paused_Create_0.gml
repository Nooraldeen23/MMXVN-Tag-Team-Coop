global.tag_swap_key = 70;
global.tag_swap_pad = 32780;
tag_binding_mode = 0;
version = "MMXVN_Beta_0.2.12(DRAGOON 1.1)";
arr_alarms = [];
arr_speed = [];
arr_animate = [];
arr_gravity = [];

add_alarm = function(arg0, arg1, arg2)
{
    array_push(arr_alarms, 
    {
        instance: arg0,
        index: arg1,
        value: arg2
    });
    arg0.alarm[arg1] = -1;
};

add_speed = function(arg0, arg1)
{
    array_push(arr_speed, 
    {
        instance: arg0,
        value: arg1
    });
    arg0.speed = 0;
};

add_animate = function(arg0, arg1)
{
    array_push(arr_animate, 
    {
        instance: arg0,
        value: arg1
    });
    arg0.image_speed = 0;
};

add_gravity = function(arg0, arg1)
{
    array_push(arr_gravity, 
    {
        instance: arg0,
        value: arg1
    });
    arg0.gravity = 0;
};

global.pause_healing = 0;
global.pause_delay = 0;
global.pause_screen = false;
global.pause_screen_state = 0;
global.pause_screen_speed = 0.1;
global.pause_menu = "Paused";
global.pause_menu_sub = "Options";
pause_animate = 0;
tank_animate = 0;
tank_filling = -1;
tank_filling_full = false;
unpause = false;
menu_description = "Nothing";
menu_title = "Nothing";
key_select = false;
rendering_command = 0;
save_flash = 0;
save_transition = false;
length = 0;
length_limit = 10;
scroll = 0;
text_change = 0;
text_scrolling = 0;
sparkle_fade = 0;
audio_sound_gain(snd_ambience_nightmarestorm, 0, 0);
title_state = 0;
title_white_alpha = 0;
title_eye_x = display_get_gui_width() / 2;
title_eye_y = display_get_gui_height() / 2;
title_thundercrack = 0;
title_thundercrack_delay = 120;
title_lightning_strike = 0;
title_lightning_delay = 180;
title_lightning = 
{
    _x: 0,
    _y: 0,
    alpha: 0,
    angle: 0,
    colour: 16777215
};
menu_state = "Weapons";
menu_length = 0;
menu_position = 0;
menu_position_sub = 0;
menu_position_horizontal = 0;
menu_tank[0] = global.subtank_1;
menu_tank[1] = global.subtank_2;
menu_tank[2] = global.weapontank;
text_scrolling = 0;
text_change = 0;
controller_toggle = true;
travelling = 0;
stageselect_state = 0;
stageselect_entrance = 7;
stageselect_bg_swap = 0;
stageselect_bg_static = 0.05;
if (room == rm_stage_select)
{
    alarm[2] = 15;
}
stageselect[0] = 
{
    position: 0,
    alpha: 1.1
};
stageselect[1] = 
{
    position: 3,
    alpha: 1.1
};
stageselect[2] = 
{
    position: 1,
    alpha: 1.1
};
stageselect[3] = 
{
    position: 4,
    alpha: 1.1
};
stageselect[4] = 
{
    position: 6,
    alpha: 1.1
};
stageselect[5] = 
{
    position: 2,
    alpha: 1.1
};
stageselect[6] = 
{
    position: 7,
    alpha: 1.1
};
stageselect[7] = 
{
    position: 5,
    alpha: 1.1
};
blink = 0;
alarm[0] = 1;
list = 0;
command = 0;
keyboard[0] = 38;
keyboard[1] = 37;
keyboard[2] = 40;
keyboard[3] = 39;
keyboard[4] = 65;
keyboard[5] = 90;
keyboard[6] = 83;
keyboard[7] = 88;
keyboard[8] = 86;
keyboard[9] = 81;
keyboard[10] = 69;
keyboard[11] = 13;
keyboard[12] = 8;
keyboard[13] = 38;
keyboard[14] = 37;
keyboard[15] = 40;
keyboard[16] = 39;
keyboard[17] = 65;
keyboard[18] = 90;
keyboard[19] = 83;
controller[0] = 32786;
controller[1] = 32785;
controller[2] = 32786;
controller[3] = 32785;
controller[4] = 32771;
controller[5] = 32769;
controller[6] = 32774;
controller[7] = 32773;
controller[8] = 32772;
controller[9] = 32775;
controller[10] = 32776;
controller[11] = 32778;
controller[12] = 32778;
controller[13] = 32781;
controller[14] = 32783;
controller[15] = 32782;
controller[16] = 32784;
controller[17] = 32770;
controller[18] = 32769;
controller[19] = 32771;
global.controller = true;
event_user(2);
jump_trigger = false;
key_select = false;
controller_deadzone = 0.7;
controller_toggle = true;
global.vsync = true;
window_mode = 0;
window_size = 3;
window_resolution = 0;
if (room == rm_stage_select || room == rm_title)
{
    global.pause = true;
    global.pause_screen = true;
    global.pause_menu = global.special_room;
    global.pause_screen_state = 1;
    if (global.pause_menu != "Stage Select")
    {
        stageselect_state = 2;
        stageselect_bg_swap = 1;
        stageselect_entrance = 0;
        alarm[0] = -1;
        alarm[2] = -1;
    }
    global.special_room = "Stage Select";
    if (room == rm_title)
    {
        global.pause_screen = false;
        global.pause_menu = "Options";
        global.pause_menu_sub = "Title";
    }
}
defaults = false;
save_import = 0;
save_file = 0;

function apply_video_settings()
{
    switch (window_mode)
    {
        case 0:
            window_set_fullscreen(false);
            window_set_showborder(true);
            window_set_size(global.view_width * window_size, global.view_height * window_size);
            if (window_size < 0 || window_size > 4)
            {
                window_size = 3;
            }
            break;
        case 1:
            window_set_fullscreen(false);
            window_set_showborder(false);
            window_set_size(display_get_width(), display_get_height());
            window_set_position(0, 0);
            break;
        case 2:
            window_set_fullscreen(true);
            break;
    }
}

if (file_exists("autosave_export.txt"))
{
    event_user(4);
}
else
{
    apply_video_settings();
}
coop_lobby_age = 0;
coop_lobby_row = 0;
coop_lobby_role = 1;
coop_lobby_char = "X";
coop_lobby_pulse = 0;
coop_lobby_blend = 0;
coop_lobby_cursor = 0;
coop_lobby_age = 0;
coop_lobby_row = 0;
coop_lobby_role = 1;
coop_lobby_char = "X";
coop_lobby_pulse = 0;
coop_lobby_blend = 0;
coop_lobby_cursor = 0;
coop_lobby_attack_x = -1;
coop_lobby_attack_zero = -1;
for (var hint = 1; hint <= parameter_count(); hint++)
{
    if (parameter_string(hint) == "--menu-join")
    {
        coop_lobby_role = 2;
    }
}
coop_controls_return = false;
coop_lobby_error = "";
