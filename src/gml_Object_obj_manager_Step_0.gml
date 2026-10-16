global.volume_music = clamp(global.volume_music, 0, 1);
global.volume_master = clamp(global.volume_master, 0, 1);
global.volume_effect = clamp(global.volume_effect, 0, 1);
if (!instance_exists(obj_menu_paused))
{
    instance_create_depth(x, y, 0, obj_menu_paused);
}
gamepad_update_sdl();
audio_group_set_gain(audiogroup_sfx, global.volume_effect * global.volume_master, 0);
audio_group_set_gain(audiogroup_music, global.volume_music * global.volume_master, 0);
global.playtime++;
if (global.result_kill_change > 0)
{
    global.result_kill_change--;
}
if (global.result_timer_minute > 0)
{
    global.result_timer_minute--;
}
if ((global.result_timer % 3600) == 0 && global.result_timer > 0)
{
    global.result_timer_minute = 60;
}
if (room == rm_skip_title)
{
    room_goto_next();
}
if (global.ng_cycle > global.ng_cycle_max)
{
    global.ng_cycle_max = global.ng_cycle;
}
coop_demo_tick++;
if (global.coop_role == 1 && global.coop_preview_active && coop_demo_tick == 100)
{
    global.pause = false;
    global.pause_screen = false;
    global.cutscene_skip = true;
    global.zero_unlock = true;
    global.level_completed = false;
    room_goto(rm_tag_sigma);
}
if (global.coop_preview_active && room == rm_tag_sigma && instance_exists(obj_player))
{
    if (!global.pause)
    {
        coop_demo_age++;
    }
    with (obj_tag_sigma)
    {
        instance_destroy();
    }
    with (obj_tag_colonel)
    {
        instance_destroy();
    }
    with (obj_tag_sigma_reward)
    {
        instance_destroy();
    }
    with (obj_warning)
    {
        instance_destroy();
    }
    with (obj_dialogue)
    {
        instance_destroy();
    }
    with (obj_cutscene_level_start)
    {
        instance_destroy();
    }
    if (instance_exists(obj_tag_secret_arena))
    {
        obj_tag_secret_arena.secret_intro_state = 2;
    }
    global.hud_toggle = true;
    if (coop_demo_age == 30)
    {
        global.pause = false;
        global.life = global.lifemax;
        obj_player.x = (global.coop_role == 1) ? 170 : 260;
        obj_player.y = 544;
        obj_player.movement = true;
        obj_player.animation_lock = false;
        obj_player.player_state = 0;
        obj_player.image_alpha = 1;
    }
    if (coop_demo_age > 30 && !global.pause && !global.pause_screen && coop_demo_dead == 0)
    {
        obj_player.movement = true;
        obj_player.animation_lock = false;
    }
    if (global.life <= 0 && coop_demo_dead == 0)
    {
        coop_demo_dead = 75;
        coop_dead_x = obj_player.x;
        coop_dead_y = obj_player.y;
        global.death = true;
        obj_player.movement = false;
        obj_player.movement_freeze = true;
        obj_player.image_alpha = 0;
        obj_player.xspeed = 0;
        obj_player.yspeed = 0;
        var ring = global.playable_character.visual.death_ring;
        coop_death_fx(coop_dead_x, coop_dead_y, ring);
        coop_send(coop_packet("op", "death_fx", "x", coop_dead_x, "y", coop_dead_y, "sprite", sprite_get_name(ring)));
        coop_log("DEMO_DEATH x=" + string(coop_dead_x) + " y=" + string(coop_dead_y));
    }
    if (coop_demo_dead > 0)
    {
        coop_demo_dead--;
        obj_player.x = coop_dead_x;
        obj_player.y = coop_dead_y;
        obj_player.xspeed = 0;
        obj_player.yspeed = 0;
        obj_player.image_alpha = 0;
        obj_player.movement = false;
        obj_player.movement_freeze = true;
        if (coop_demo_dead == 0)
        {
            global.death = false;
            global.life = global.lifemax;
            obj_game.death_animation = 0;
            obj_game.alarm[0] = -1;
            obj_player.x = (global.coop_role == 1) ? 170 : 260;
            obj_player.y = 544;
            obj_player.recovery = 1;
            obj_player.alarm[1] = 180;
            obj_player.alarm[2] = 1;
            obj_player.invul = false;
            obj_player.hurt = false;
            obj_player.movement = true;
            obj_player.movement_freeze = false;
            obj_player.image_alpha = 1;
            obj_player.animation_lock = false;
            obj_player.player_state = 0;
            coop_log("DEMO_RESPAWN");
        }
    }
    if (global.coop_role == 1 && coop_demo_age > 90 && (coop_demo_age % 240) == 0 && instance_number(obj_enemy_parent) < 3)
    {
        var foe = instance_create_layer(choose(105, 340), 500, "Instances", obj_enemy_met_fly);
        foe.life = 24;
        foe.lifemax = 24;
        foe.damage = 5;
        foe.drop_pickup = false;
        foe.despawn = false;
        coop_log("DEMO_ENEMY_SPAWN");
    }
}
if (global.coop_smoke && coop_demo_tick == 600)
{
    coop_log("DEMO_SMOKE connected=" + string(obj_coop_net.connected) + " remote=" + string(instance_exists(obj_coop_net.remote)) + " char=" + global.playable_character.name + " hp=" + string(global.life));
    surface_save(application_surface, "demo-smoke.png");
    game_end();
}
forest_tick++;
if (global.coop_role == 1 && global.coop_campaign_active && instance_exists(obj_coop_net) && obj_coop_net.connected && room == rm_title)
{
    forest_tick = 120;
    global.pause = false;
    global.pause_screen = false;
    global.zero_unlock = true;
    global.cutscene_skip = true;
    global.level_completed = false;
    room_goto(rm_stage_select);
}
if (global.coop_test && room == rm_yammark && forest_tick == 300)
{
    with (obj_cutscene_level_start)
    {
        instance_destroy();
    }
    with (obj_ready)
    {
        instance_destroy();
    }
    global.pause = false;
    global.pause_screen = false;
    global.pause_screen_state = 0;
    global.hud_toggle = true;
    global.death = false;
    with (obj_player)
    {
        movement = true;
        movement_freeze = false;
        animation_lock = false;
        image_alpha = 1;
        player_state = 0;
        image_index = 0;
    }
    coop_log("FOREST_CONTROLS_UNLOCKED");
}
if (global.coop_quiet)
{
    audio_master_gain(0);
}
if (room == rm_title && variable_global_exists("pause_menu_sub") && (global.pause_menu_sub == "Co-op" || (instance_exists(obj_menu_paused) && obj_menu_paused.coop_controls_return)))
{
    if (global.music != "Off" && is_real(global.music))
    {
        audio_stop_sound(global.music);
    }
    global.music = "Off";
    if (coop_lobby_music < 0 || !audio_is_playing(coop_lobby_music))
    {
        audio_stop_sound(snd_ambience_nightmarestorm);
        coop_lobby_music = audio_play_sound(snd_ambience_nightmarestorm, 10, true, 0);
        coop_lobby_fade = 0;
        coop_lobby_gain = -1;
        audio_sound_gain(coop_lobby_music, 0, 0);
        coop_log("LOBBY_STORM_START");
    }
    coop_lobby_fade = min(1, coop_lobby_fade + 0.011111111111111112);
    var target = 2 * clamp(global.volume_effect, 0, 1) * clamp(global.volume_master, 0, 1) * (coop_lobby_fade * coop_lobby_fade * (3 - (2 * coop_lobby_fade)));
    if (abs(target - coop_lobby_gain) > 0.0001)
    {
        audio_sound_gain(coop_lobby_music, target, 16);
        coop_lobby_gain = target;
    }
    if (global.pause_menu_sub == "Co-op" && instance_exists(obj_menu_paused))
    {
        with (obj_menu_paused)
        {
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
    }
}
else if (coop_lobby_music >= 0)
{
    audio_stop_sound(coop_lobby_music);
    coop_lobby_music = -1;
    coop_lobby_fade = 0;
    coop_lobby_gain = -1;
    if (room != rm_title)
    {
        audio_stop_sound(snd_thundercrack);
    }
    if (room == rm_title)
    {
        global.music = snd_music_title;
    }
    else if (global.music == "Off" && coop_play_room())
    {
        global.music = "Level";
    }
    coop_log("LOBBY_STORM_STOP");
}
