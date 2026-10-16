if (coop_client())
{
    visible = false;
    exit;
}
if (!reward_ready || global.pause || pickup_delay || global.life <= 0 || auto_pickup == "Appear" || soul_steal != 0)
{
    exit;
}
if (reward_bait)
{
    with (obj_tag_secret_arena)
    {
        secret_ambush_pending = false;
        secret_second_started = true;
        if (secret_death_voice != -1)
        {
            audio_stop_sound(secret_death_voice);
        }
        if (secret_music != -1)
        {
            audio_stop_sound(secret_music);
        }
        secret_music = -1;
        global.music = "Off";
        secret_music_asset = -1;
        secret_boss = instance_create_layer(clamp(other.x + ((other.x < 224) ? 92 : -92), 116, 332), 240, "Instances", obj_tag_colonel);
        var flash = instance_create_layer(other.x, other.y, "Explosions", obj_tag_sigma_fx);
        flash.sprite_index = spr_pickup_soul_mega_appear;
        flash.fx_frame = 0;
        flash.fx_lifetime = 18;
        flash.image_xscale = 1;
        flash.image_yscale = 1;
        tagteam_sigma_sfx("transform", 0.8);
    }
    instance_destroy();
    exit;
}
var souls_before = global.nightmare_souls;
sprite_index = spr_pickup_soul_virus;
event_inherited();
if (global.nightmare_souls == (souls_before + 500))
{
    global.tag_colonel_soul_claimed = true;
    with (obj_tag_secret_arena)
    {
        secret_reward_collected = true;
        secret_timer = 0;
    }
    with (obj_manager)
    {
        save_slot = 0;
        event_user(0);
    }
}
