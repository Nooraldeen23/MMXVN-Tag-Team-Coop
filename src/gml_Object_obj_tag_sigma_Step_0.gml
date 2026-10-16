if (coop_client() && object_index != obj_coop_foe)
{
    visible = false;
    exit;
}
if (global.pause || global.death || !instance_exists(obj_player))
{
    exit;
}
if (sig_phase == 2 && !sig_enraged && life > 0 && life <= (lifemax * 0.5) && !sig_death)
{
    sig_enraged = true;
    with (obj_tag_secret_arena)
    {
        secret_spikes_active = true;
    }
    sig_air = false;
    sig_vy = 0;
    y = 544;
    boss_iframes = 0;
    isHit = false;
    with (obj_tag_sigma_wave)
    {
        instance_destroy();
    }
    with (obj_tag_sigma_cannon)
    {
        instance_destroy();
    }
    with (obj_tag_sigma_ring)
    {
        instance_destroy();
    }
    if (sig_audio_charge != -1)
    {
        audio_stop_sound(sig_audio_charge);
    }
    if (sig_audio_laser != -1)
    {
        audio_stop_sound(sig_audio_laser);
    }
    tagteam_sigma_enter(id, "p2_enrage", "fire_prepare");
    scr_make_sound(snd_turtloid_thunder, 0.85, 1, false);
}
if (!global.pause)
{
    sig_electric_clock++;
}
if (life <= 0 && !sig_death)
{
    sig_death = true;
    life = 1;
    invul = true;
    damage = 0;
    with (obj_tag_sigma_orb)
    {
        instance_destroy();
    }
    with (obj_tag_sigma_laser)
    {
        instance_destroy();
    }
    with (obj_tag_sigma_wave)
    {
        instance_destroy();
    }
    with (obj_tag_sigma_lance)
    {
        instance_destroy();
    }
    with (obj_tag_sigma_cannon)
    {
        instance_destroy();
    }
    with (obj_tag_sigma_ring)
    {
        instance_destroy();
    }
    if (sig_audio_charge != -1)
    {
        audio_stop_sound(sig_audio_charge);
    }
    if (sig_audio_laser != -1)
    {
        audio_stop_sound(sig_audio_laser);
    }
    tagteam_sigma_enter(id, "defeat", "death");
    sig_death_voice = tagteam_sigma_sfx("death", 0.85);
    with (obj_tag_secret_arena)
    {
        secret_death_voice = other.sig_death_voice;
    }
}
if (!sig_death)
{
    event_inherited();
}
xspeed = 0;
yspeed = 0;
weight = 0;
image_speed = 0;
sig_timer++;
var fast_warp = sig_state == "vanish" || sig_state == "appear";
var animtime = sig_timer;
var fr = 0;
if (variable_struct_exists(sig_anim, "loop") && sig_anim.loop)
{
    animtime = sig_timer % sig_anim.duration;
}
if (fast_warp)
{
    animtime = floor((sig_timer / 12) * sig_anim.duration);
}
for (var i = 0; i < array_length(sig_anim.ticks); i++)
{
    if (animtime < sig_anim.ticks[i])
    {
        fr = i;
        break;
    }
    animtime -= sig_anim.ticks[i];
    fr = i;
}
if (fast_warp)
{
    fr = min(sprite_get_number(sprite_index) - 1, floor((sig_timer / 12) * sprite_get_number(sprite_index)));
}
image_index = fr;
sig_anim_done = sig_timer >= (fast_warp ? 12 : sig_anim.duration);
image_xscale = -sig_face;
invul = sig_state == "intro_descend" || sig_state == "intro_land" || sig_state == "vanish" || sig_state == "hidden" || sig_state == "appear" || sig_state == "defeat" || sig_state == "transform" || sig_state == "p2_arrive" || sig_state == "p2_arrive_finish" || sig_state == "p2_arrive_settle" || sig_state == "p2_descend" || sig_state == "p2_warpout" || sig_state == "p2_warphidden" || sig_state == "p2_enrage";
damage = invul ? 0 : ((sig_phase == 2) ? 8 : 5);
if (sig_state == "p2_center" || sig_state == "p2_cprepare" || sig_state == "p2_cstart" || sig_state == "p2_cfire")
{
    damage = 0;
}
switch (sig_state)
{
    case "intro_descend":
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("warp_in");
        }
        var descend = clamp((sig_timer - 10) / 28, 0, 1);
        y = lerp(240, sig_intro_floor, 1 - power(1 - descend, 2));
        image_alpha = clamp((sig_timer - 10) / 10, 0, 1);
        if (sig_timer >= 38)
        {
            y = sig_intro_floor;
            tagteam_sigma_enter(id, "intro_land", "land");
            tagteam_sigma_sfx("heavy", 0.75);
        }
        break;
    case "intro_land":
        y = sig_intro_floor;
        if (sig_timer >= max(24, sig_anim.duration))
        {
            sig_dialogue = tagteam_secret_conversation("Sigma");
            tagteam_sigma_enter(id, "question", "idle");
        }
        break;
    case "question":
        invul = true;
        damage = 0;
        if (!instance_exists(sig_dialogue))
        {
            tagteam_secret_music(false);
            obj_player.movement = true;
            obj_player.invul = false;
            global.hud_toggle = true;
            tagteam_sigma_enter(id, "recover", "idle");
        }
        break;
    case "silence":
        invul = true;
        damage = 0;
        if (!instance_exists(sig_dialogue))
        {
            obj_player.movement = true;
            obj_player.invul = false;
            global.hud_toggle = true;
            tagteam_sigma_enter(id, "recover", "idle");
        }
        break;
    case "recover":
        y = 544;
        sig_face = (obj_player.x < x) ? -1 : 1;
        if (sig_timer >= ((life < (lifemax / 2)) ? 28 : 38))
        {
            sig_attack = (sig_attack + 1) % 4;
            sig_origin_x = x;
            sig_target_x = clamp(obj_player.x, 88, 360);
            if (sig_attack == 0)
            {
                tagteam_sigma_enter(id, "prepare_combo", "dash_prepare");
            }
            if (sig_attack == 1)
            {
                tagteam_sigma_enter(id, "prepare_low", "low_dash_prepare");
            }
            if (sig_attack == 2)
            {
                tagteam_sigma_enter(id, "vanish", "appear_end");
            }
            if (sig_attack == 3)
            {
                sig_aim = point_direction(x, y - 48, obj_player.x, obj_player.y - 10);
                tagteam_sigma_enter(id, "orb_prepare", "eye_start");
            }
        }
        break;
    case "prepare_combo":
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("charge");
        }
        if (sig_timer >= max(sig_anim.duration, 30))
        {
            tagteam_sigma_enter(id, "dash_in", "dash_start");
        }
        break;
    case "dash_in":
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("dash");
        }
        x = clamp(x + (sig_face * 4.4), 88, 360);
        if (sig_anim_done || abs(obj_player.x - x) < 75)
        {
            tagteam_sigma_enter(id, "slash_one", "dash_slash_1");
        }
        break;
    case "slash_one":
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("slash");
        }
        if (sig_anim_done)
        {
            tagteam_sigma_enter(id, "combo_pause", "dash_slash_1_end");
        }
        break;
    case "combo_pause":
        if (sig_timer >= 22)
        {
            sig_face = (obj_player.x < x) ? -1 : 1;
            tagteam_sigma_enter(id, "dash_two", "dash_start_2");
        }
        break;
    case "dash_two":
        x = clamp(x + (sig_face * 3.8), 88, 360);
        if (sig_timer >= 14)
        {
            tagteam_sigma_enter(id, "slash_two", "dash_slash_2");
        }
        break;
    case "slash_two":
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("slash");
        }
        if (sig_anim_done)
        {
            tagteam_sigma_enter(id, "slash_recover", "dash_slash_2_end");
        }
        break;
    case "slash_recover":
        if (sig_anim_done)
        {
            tagteam_sigma_enter(id, "recover", "idle");
        }
        break;
    case "prepare_low":
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("charge");
        }
        if (sig_timer >= max(30, sig_anim.duration))
        {
            tagteam_sigma_enter(id, "low_dash", "low_dash");
        }
        break;
    case "low_dash":
        x = clamp(x + (sig_face * 4.8), 88, 360);
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("slash");
        }
        if (sig_timer >= 28 || x <= 88 || x >= 360)
        {
            tagteam_sigma_enter(id, "low_pause", "low_dash_pause");
        }
        break;
    case "low_pause":
        if (sig_anim_done)
        {
            sig_face = (obj_player.x < x) ? -1 : 1;
            tagteam_sigma_enter(id, "rise_prepare", "upward_start");
        }
        break;
    case "rise_prepare":
        if (sig_anim_done)
        {
            tagteam_sigma_enter(id, "rise", "upward");
        }
        break;
    case "rise":
        y = 544 - (sin(pi * min(1, sig_timer / 42)) * 100);
        x = clamp(x + (sig_face * 1.6), 88, 360);
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("rise");
        }
        if (sig_timer >= 18)
        {
            tagteam_sigma_enter(id, "fall", "upward_end");
        }
        break;
    case "fall":
        y = 544 - (sin(pi * min(1, (sig_timer + 18) / 42)) * 100);
        x = clamp(x + (sig_face * 1.2), 88, 360);
        if (sig_timer >= 24)
        {
            y = 544;
            tagteam_sigma_enter(id, "landing", "land");
        }
        break;
    case "vanish":
        image_index = max(0, sprite_get_number(sprite_index) - 1 - fr);
        image_alpha = clamp(1 - (sig_timer / 12), 0, 1);
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("warp_out");
        }
        if (sig_anim_done)
        {
            sig_target_x = clamp(obj_player.x + ((obj_player.x < 224) ? 78 : -78), 88, 360);
            tagteam_sigma_enter(id, "hidden", "idle");
        }
        break;
    case "hidden":
        image_alpha = 0;
        if (sig_timer >= 8)
        {
            x = sig_target_x;
            y = 436;
            sig_face = (obj_player.x < x) ? -1 : 1;
            tagteam_sigma_enter(id, "appear", "appear_end");
        }
        break;
    case "appear":
        image_alpha = clamp(sig_timer / 5, 0, 1);
        y = min(544, y + min(18, 9 + sig_timer));
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("warp_in");
        }
        if (sig_timer >= 5)
        {
            tagteam_sigma_enter(id, "drop", "downward_loop");
        }
        break;
    case "drop_prepare":
        tagteam_sigma_enter(id, "drop", "downward_loop");
        break;
    case "drop":
        y = min(544, y + 18);
        image_alpha = 1;
        if (sig_timer == 1)
        {
            tagteam_sigma_sfx("rise");
        }
        if (y >= 544)
        {
            tagteam_sigma_enter(id, "drop_land", "downward_land");
            tagteam_sigma_sfx("heavy");
            tagteam_sigma_shot(x, 532, 0, 3.5);
            tagteam_sigma_shot(x, 532, 180, 3.5);
        }
        break;
    case "drop_land":
        if (sig_anim_done)
        {
            tagteam_sigma_enter(id, "recover", "idle");
        }
        break;
    case "landing":
        if (sig_anim_done)
        {
            tagteam_sigma_enter(id, "recover", "idle");
        }
        break;
    case "orb_prepare":
        if (sig_timer >= max(30, sig_anim.duration))
        {
            tagteam_sigma_enter(id, "orb_fire", "eye_loop");
        }
        break;
    case "orb_fire":
        if (sig_timer == 1 || sig_timer == 24)
        {
            tagteam_sigma_sfx("wave");
            for (var j = -1; j <= 1; j++)
            {
                tagteam_sigma_shot(x + (sig_face * 18), y - 48, sig_aim + (j * 18), 3.6);
            }
        }
        if (sig_timer >= 40)
        {
            tagteam_sigma_enter(id, "orb_end", "eye_end");
        }
        break;
    case "orb_end":
        if (sig_anim_done)
        {
            tagteam_sigma_enter(id, "recover", "idle");
        }
        break;
    case "defeat":
        image_alpha = 1;
        damage = 0;
        if ((sig_timer % 12) == 0)
        {
            var fx = instance_create_layer(x + random_range(-20, 20), y - random_range(8, 60), "Explosions", obj_explosion);
            fx.sprite_index = spr_explosion_player;
            fx.image_speed = 0.35;
            fx.tag_sigma_owner = id;
            fx.image_xscale = 0.75;
            fx.image_yscale = 0.75;
            if ((sig_timer % 24) == 0)
            {
                tagteam_sigma_sfx("burst", 0.45);
            }
        }
        if (sig_timer >= 96)
        {
            if (sig_phase == 1)
            {
                global.tag_secret_unlock = true;
                scr_part_storestock();
                with (obj_manager)
                {
                    save_slot = 0;
                    event_user(0);
                }
                with (obj_tag_secret_arena)
                {
                    secret_ambush_pending = true;
                    secret_reward = instance_create_layer(clamp(other.x, 100, 348), 510, "Instances", obj_tag_sigma_reward);
                    secret_reward.reward_bait = true;
                    secret_reward.pickup_power = 0;
                }
            }
            else
            {
                global.tag_secret_unlock = true;
                scr_part_storestock();
                with (obj_tag_secret_arena)
                {
                    secret_victory = true;
                    secret_timer = 0;
                    secret_reward = instance_create_layer(clamp(other.x, 100, 348), 510, "Instances", obj_tag_sigma_reward);
                }
                with (obj_manager)
                {
                    save_slot = 0;
                    event_user(0);
                }
            }
            instance_destroy();
            exit;
        }
        break;
}
var cutting = (sig_state == "slash_one" || sig_state == "slash_two") && sig_timer >= 5 && sig_timer <= 20;
cutting = cutting || (sig_state == "low_dash" && sig_timer >= 7) || (sig_state == "rise" && sig_timer <= 18) || sig_state == "drop";
if (cutting && !obj_player.invul && !obj_player.invul_contact && !obj_player.hurt)
{
    var reach = (sig_state == "rise") ? 62 : 83;
    var sy = y - ((sig_state == "low_dash") ? 12 : 38);
    var sx = x + (sig_face * 38);
    if (abs(obj_player.x - sx) < ((reach / 2) + 9) && abs(obj_player.y - 12 - sy) < ((sig_state == "rise") ? 42 : 24))
    {
        var hit = instance_create_layer(obj_player.x, obj_player.y - 12, "Projectiles", obj_tag_sigma_orb);
        hit.speed = 0;
        hit.damage = 7;
        hit.expiry = 1;
        hit.image_alpha = 0;
    }
}
var body_frame = clamp(floor(image_index), 0, sprite_get_number(sprite_index) - 1);
var body_mask = asset_get_index(sprite_get_name(sprite_index) + "_body_" + string(body_frame));
if (body_mask != -1)
{
    mask_index = body_mask;
}
