if (secret_music != -1)
{
    audio_sound_gain(secret_music, secret_music_native ? 1 : (global.volume_music * global.volume_master * 1.2), 0);
}
if (!global.pause)
{
    secret_clock++;
}
if (global.pause || !instance_exists(obj_player))
{
    exit;
}
tagteam_colonel_wall_step();
if (secret_intro_state == 0 && obj_player.movement && !global.death)
{
    obj_player.movement = false;
    obj_player.invul = true;
    secret_intro_state = 1;
    instance_create_depth(0, 0, 0, obj_warning);
}
if (secret_intro_state == 1 && !instance_exists(obj_warning))
{
    secret_intro_state = 2;
    secret_boss = instance_create_layer(336, 544, "Instances", obj_tag_sigma);
    if (is_real(global.music) && global.music != -1)
    {
        audio_stop_sound(global.music);
    }
    global.music = "Off";
    secret_music_asset = -1;
    secret_music = -1;
}
if (secret_victory && secret_reward_collected)
{
    secret_timer++;
    if (secret_timer >= 60 && !instance_exists(secret_exit))
    {
        secret_exit = instance_create_depth(0, 0, -1000, obj_fade_out);
        secret_exit.fade_speed = 0.04;
    }
    if (instance_exists(secret_exit) && secret_exit.alpha >= 1)
    {
        global.tag_returning = true;
        room_goto(rm_turtloid);
    }
}
