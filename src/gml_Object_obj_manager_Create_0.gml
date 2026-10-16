global.coop_reward_type = "";
global.coop_role = 0;
global.coop_character = "X";
global.coop_host = "127.0.0.1";
global.coop_port = 17879;
global.tag_secret_completed = false;
global.tag_health_enabled = true;
global.tag_energy_enabled = true;
global.tag_health = [-1, -1];
global.tag_energy = [[], []];
global.tag_energy_capacity = [1, 1];
global.tag_auto_swap = false;
global.tag_deferred_blade = false;
global.tag_deferred_buster = false;
global.tag_secret_unlock = false;
global.tag_colonel_soul_claimed = false;
global.tag_returning = false;
global.tag_return_x = 208;
global.tag_return_y = 2217;
randomise();
save_slot = 0;
autosaving = false;
autosaving_alpha = 0;
global.game_completion = 0;
global.ui_scale = 5;
global.fps_display = false;
global.languages = ds_list_create();
ds_list_add(global.languages, "EN");
ds_list_add(global.languages, "SP");
ds_list_add(global.languages, "FR");
ds_list_add(global.languages, "BR");
ds_list_add(global.languages, "CHT");
ds_list_add(global.languages, "CHS");
ds_list_add(global.languages, "KR");
ds_list_add(global.languages, "JP");
global.locale = 0;
InitTranslations();
global.language_title = 0;
global.language_title = real(localtext("title_language"));
audio_group_load(audiogroup_music);
audio_group_load(audiogroup_sfx);
global.volume_master = 0.5;
global.volume_music = 1;
global.volume_effect = 1;
audio_group_set_gain(audiogroup_sfx, global.volume_effect * global.volume_master, 0);
audio_group_set_gain(audiogroup_music, global.volume_music * global.volume_master, 0);
current_area = -4;
global.pause = false;
global.pause_screen = false;
global.set_rendering = false;
global.indicators = false;
global.cutscene_skip = false;
global.lives_start = 2;
global.lives = global.lives_start;
global.lives_toggle = false;
global.gaichuuin_visability = false;
global.music_custom = false;
global.x4_charge_shot = false;
var result = gamepad_init_sdl();
if (result == 1)
{
    show_debug_message("SDL3 Gamepad System Initialized Successfully!");
}
else
{
    show_debug_message("Failed to initialize SDL3 Gamepad System.");
}
global.controller = false;
global.rapidfire = false;
global.autocharge = false;
global.commanddash = true;
event_user(2);
scr_get_input();
global.nightmare_souls = 0;
global.rescue_count = 0;
global.rescue_max = 0;
global.rescue_list = ds_list_create();
global.pickup_list = ds_list_create();
global.level_completed = false;
global.level_list = ds_list_create();
global.nightmare_progress = ds_list_create();
global.datalog_list = ds_list_create();
ds_list_add(global.datalog_list, "datalog_signas");
global.training = false;
global.special_room = "Stage Select";
global.hearttank = 0;
global.tank_cap = 28;
global.subtank_1 = -1;
global.subtank_2 = -1;
global.weapontank = -1;
global.powertank = 0;
global.black_zero = false;
global.blade_head_get = false;
global.blade_chest_get = false;
global.blade_arm_get = false;
global.blade_leg_get = false;
global.shadow_head_get = false;
global.shadow_chest_get = false;
global.shadow_arm_get = false;
global.shadow_leg_get = false;
global.black_armour_get = false;
global.x_armour_head = 0;
global.x_armour_chest = 0;
global.x_armour_arm = 0;
global.x_armour_leg = 0;
global.zero_armour_black = 0;
global.seen_boss_cutscene = -1;
global.current_level = -1;
global.give_weapon = "Nothing";
global.playtime = 0;
global.ng_cycle = 0;
global.ng_cycle_max = 0;
global.zero_unlock = false;
scr_player_animation_setup();
global.playable_character = Character_X();
global.weapon_choice = 0;
base_weapon_ammo_max = 48;
global.weapon_disable_list = ds_list_create();
global.weapon_list = ds_list_create();
for (var i = 0; i < 11; i++)
{
    global.weapon[i] = 
    {
        type: 0,
        ammo_usage: 0,
        ammo: 0,
        charge_cost: 1
    };
}
scr_weapon_get("Default", true);
global.event_list_size = 50;
for (var i = 0; i < global.event_list_size; i++)
{
    global.event[i] = 0;
}
global.parts_list = ds_list_create();
global.parts_amount = 1;
global.parts_equipped = ds_list_create();
global.parts_owned = ds_list_create();
global.parts_store = ds_list_create();
global.result_display = 1;
global.result_timer = 0;
global.result_timer_minute = 0;
global.result_damage = 0;
global.result_kill = ds_list_create();
global.result_kill_change = 0;
global.result_store = ds_list_create();
result_disable = false;
for (var p = 1; p <= parameter_count(); p++)
{
    if (parameter_string(p) == "--host-ip" && p < parameter_count())
    {
        global.coop_host = parameter_string(++p);
    }
    else if (parameter_string(p) == "--port" && p < parameter_count())
    {
        global.coop_port = clamp(real(parameter_string(++p)), 1024, 65535);
    }
}
if (!instance_exists(obj_coop_net))
{
    instance_create_depth(0, 0, -9999, obj_coop_net);
}
coop_demo_tick = 0;
coop_demo_age = 0;
global.coop_buddy = false;
global.coop_smoke = false;
for (var p = 1; p <= parameter_count(); p++)
{
    if (parameter_string(p) == "--buddy")
    {
        global.coop_buddy = false;
    }
    if (parameter_string(p) == "--smoke")
    {
        global.coop_smoke = true;
    }
}
coop_demo_dead = 0;
global.coop_preview_active = global.coop_role == 2;
global.coop_campaign_active = false;
forest_tick = 0;
global.coop_buddy = false;
global.coop_campaign_active = false;
global.coop_preview_active = false;
global.coop_smoke = false;
global.coop_test = false;
global.coop_quiet = false;
for (var q = 1; q <= parameter_count(); q++)
{
    if (parameter_string(q) == "--quick-test")
    {
        global.coop_test = true;
        global.coop_role = 1;
        global.coop_character = "X";
    }
    if (parameter_string(q) == "--host-ip")
    {
        global.coop_role = 2;
        global.coop_character = "Zero";
    }
    if (parameter_string(q) == "--quiet")
    {
        global.coop_quiet = true;
    }
    if (parameter_string(q) == "--buddy")
    {
        global.coop_buddy = true;
    }
}
if (global.coop_role > 0)
{
    with (obj_coop_net)
    {
        instance_destroy();
    }
    global.coop_campaign_active = true;
    instance_create_depth(0, 0, -9999, obj_coop_net);
}
if (global.coop_quiet)
{
    audio_master_gain(0);
}
coop_lobby_music = -1;
for (var l = 1; l <= parameter_count(); l++)
{
    if (parameter_string(l) == "--hunter" && l < parameter_count())
    {
        var name = parameter_string(++l);
        if (name == "X" || name == "Zero")
        {
            global.coop_character = name;
        }
    }
}
coop_lobby_fade = 0;
coop_lobby_gain = -1;
