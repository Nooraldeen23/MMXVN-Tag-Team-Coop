if (coop_client() && object_index != obj_coop_foe)
{
    visible = false;
    exit;
}

function tagteam_colonel_try_rage(arg0)
{
    with (arg0)
    {
        if (col_dead || col_enraged || life <= 0)
        {
            return false;
        }
        if (life <= (lifemax * 0.5))
        {
            col_rage_pending = true;
        }
        var safe_state = col_state == "idle" || col_state == "saber_prepare" || col_state == "saber_cut" || col_state == "dash_cut" || col_state == "recover" || col_state == "crush_relocate" || col_state == "jump_prepare" || col_state == "crush_cut" || col_state == "thunder_prepare" || col_state == "thunder_raise" || col_state == "thunder_hold" || col_state == "thunder_slam" || col_state == "thunder_discharge" || col_state == "thunder_end" || col_state == "dash_windup" || col_state == "charge_dash";
        if (!col_rage_pending || !safe_state || abs(y - col_floor) > 2)
        {
            return false;
        }
        col_rage_pending = false;
        col_enraged = true;
        col_vy = 0;
        y = col_floor;
        image_alpha = 1;
        invul = true;
        damage = 0;
        col_speed = 1.35;
        col_damage_scale = 1.15;
        damage_store = 7 * col_damage_scale;
        with (obj_tag_colonel_wave)
        {
            instance_destroy();
        }
        with (obj_tag_colonel_bolt)
        {
            instance_destroy();
        }
        tagteam_colonel_state(id, "rage");
        tagteam_colonel_pose(id, "thunder", 0);
        tagteam_colonel_sfx("charge", 0.85);
        return true;
    }
    return false;
}

if (!col_dead && !col_enraged && life > 0 && life <= (lifemax * 0.5))
{
    col_rage_pending = true;
}
if (global.pause || global.death || !instance_exists(obj_player))
{
    exit;
}
col_clock++;
if (col_dead)
{
    col_face = col_death_face;
}
if (life <= 0 && !col_dead)
{
    col_death_face = col_face;
    col_dead = true;
    col_rage_pending = false;
    life = 1;
    invul = true;
    damage = 0;
    with (obj_tag_colonel_wave)
    {
        instance_destroy();
    }
    with (obj_tag_colonel_bolt)
    {
        instance_destroy();
    }
    tagteam_colonel_state(id, "defeat");
    image_alpha = 1;
    y = col_floor;
    col_vy = 0;
    obj_player.invul = true;
    obj_player.movement = false;
    tagteam_colonel_sfx("land", 0.65);
}
if (!col_dead)
{
    event_inherited();
}
xspeed = 0;
yspeed = 0;
weight = 0;
mask_index = spr_tag_colonel_body;
tagteam_colonel_try_rage(id);
col_speed = col_enraged ? 1.35 : 1;
col_damage_scale = col_enraged ? 1.15 : 1;
var previous_tick = col_tick;
var cinematic = col_state == "arrival" || col_state == "land" || col_state == "question" || col_state == "silence" || col_state == "rage" || col_state == "battle_ready" || col_state == "defeat" || col_state == "aftermath" || col_state == "explosion";
col_tick += (cinematic ? 1 : col_speed);
invul = cinematic || col_state == "vanish" || col_state == "hidden" || col_state == "reappear";
damage = invul ? 0 : (7 * col_damage_scale);
damage_store = 7 * col_damage_scale;
switch (col_state)
{
    case "arrival":
        obj_player.movement = false;
        obj_player.xspeed = 0;
        obj_player.invul = true;
        if (col_tick == 1)
        {
            tagteam_colonel_sfx("warp", 0.9);
        }
        var descent = clamp((col_tick - 10) / 30, 0, 1);
        y = lerp(240, 544, descent * descent);
        image_alpha = clamp(col_tick / 12, 0, 1);
        tagteam_colonel_pose(id, "air", 8);
        if (col_tick >= 40)
        {
            y = 544;
            tagteam_colonel_state(id, "land");
            tagteam_colonel_sfx("land", 0.8);
        }
        break;
    case "land":
        tagteam_colonel_pose(id, "air", min(5, floor(col_tick / 3)));
        if (col_tick >= 24)
        {
            col_dialogue = tagteam_secret_conversation("Colonel");
            tagteam_colonel_state(id, "question");
        }
        break;
    case "question":
        if (!instance_exists(col_dialogue))
        {
            tagteam_secret_music(true);
            obj_player.movement = true;
            obj_player.invul = false;
            global.hud_toggle = true;
            tagteam_colonel_state(id, "battle_ready");
        }
        break;
    case "battle_ready":
        tagteam_colonel_pose(id, "ready", min(10, floor(col_tick / 3)));
        if (previous_tick < 30 && col_tick >= 30)
        {
            tagteam_colonel_sfx("slash", 0.7);
        }
        if (col_tick >= 36)
        {
            tagteam_colonel_state(id, "idle");
        }
        break;
    case "silence":
        if (!instance_exists(col_dialogue))
        {
            obj_player.movement = true;
            obj_player.invul = false;
            global.hud_toggle = true;
            tagteam_colonel_state(id, "idle");
        }
        break;
    case "idle":
        y = 544;
        if (abs(obj_player.x - x) > 18)
        {
            col_face = (obj_player.x < x) ? -1 : 1;
        }
        tagteam_colonel_pose(id, "idle", floor(col_tick / 8) % 6);
        if (col_tick >= col_idle_delay)
        {
            var move = tagteam_colonel_choose_attack(id);
            col_chain = irandom(2);
            col_target = clamp(obj_player.x, 106, 342);
            if (move == 0)
            {
                col_combo_limit = irandom_range(1, 3);
                col_combo_count = 0;
                col_combo_finish = irandom(9);
                tagteam_colonel_state(id, "saber_prepare");
            }
            else
            {
                col_after_warp = (move == 1) ? "dash_cut" : ((move == 2) ? "jump_prepare" : "thunder_prepare");
                if (move == 1)
                {
                    var side = choose(-1, 1);
                    col_warp_target = clamp(obj_player.x + (side * 80), 108, 340);
                    if (abs(col_warp_target - obj_player.x) < 44)
                    {
                        col_warp_target = clamp(obj_player.x - (side * 80), 108, 340);
                    }
                }
                if (move == 2)
                {
                    col_warp_target = (obj_player.x < 224) ? 340 : 108;
                }
                if (move == 3)
                {
                    col_warp_target = irandom_range(208, 240);
                }
                tagteam_colonel_state(id, "vanish");
            }
        }
        break;
    case "saber_prepare":
        tagteam_colonel_pose(id, (col_chain == 1) ? "low" : "slash", (col_chain == 1) ? min(1, floor(col_tick / 4)) : min(2, floor(col_tick / 3)));
        if (col_tick >= 9)
        {
            tagteam_colonel_state(id, "saber_cut");
        }
        break;
    case "saber_cut":
        tagteam_colonel_pose(id, (col_chain == 1) ? "low" : "slash", (col_chain == 1) ? min(6, 2 + floor(col_tick / 2)) : min(8, 2 + floor(col_tick / 2)));
        var release_tick = (col_chain == 1) ? 2 : 8;
        if (previous_tick < release_tick && col_tick >= release_tick)
        {
            tagteam_colonel_sfx("wave", 0.9);
            tagteam_colonel_wave(id, col_chain != 1);
        }
        if (col_tick >= release_tick && col_tick < (release_tick + 8))
        {
            tagteam_colonel_melee(id, col_chain == 1);
        }
        if (col_tick >= 18)
        {
            col_combo_count++;
            if (col_combo_count < col_combo_limit)
            {
                col_chain = irandom(2);
                tagteam_colonel_state(id, "saber_prepare");
            }
            else if (col_combo_finish < 5)
            {
                col_dash_limit = clamp(x + (col_face * 120), 108, 340);
                tagteam_colonel_state(id, "dash_windup");
            }
            else if (col_combo_finish < 8)
            {
                tagteam_colonel_state(id, "crush_cut");
            }
            else
            {
                tagteam_colonel_state(id, "recover");
            }
        }
        break;
    case "dash_windup":
        tagteam_colonel_pose(id, "low", 0);
        if (col_tick >= 7)
        {
            tagteam_colonel_sfx("dash", 0.7);
            tagteam_colonel_state(id, "charge_dash");
        }
        break;
    case "charge_dash":
        tagteam_colonel_pose(id, "low", min(6, floor(col_tick / 2)));
        if (col_tick <= 16)
        {
            x = (col_face > 0) ? min(col_dash_limit, x + (6.8 * col_speed)) : max(col_dash_limit, x - (6.8 * col_speed));
        }
        if (col_tick >= 3 && col_tick < 15)
        {
            tagteam_colonel_melee(id, true);
        }
        if (col_tick >= 20 || abs(x - col_dash_limit) < 1)
        {
            tagteam_colonel_state(id, "recover");
        }
        break;
    case "vanish":
        tagteam_colonel_pose(id, "dash", min(3, floor(col_tick / 4)));
        if (previous_tick == 0)
        {
            tagteam_colonel_sfx("dash", 0.7);
        }
        if (col_tick >= 16)
        {
            image_alpha = 0;
            tagteam_colonel_state(id, "hidden");
        }
        break;
    case "hidden":
        image_alpha = 0;
        if (col_tick >= 22)
        {
            x = col_warp_target;
            y = col_floor;
            col_face = (obj_player.x < x) ? -1 : 1;
            tagteam_colonel_state(id, "reappear");
            tagteam_colonel_sfx("warp", 0.75);
        }
        break;
    case "reappear":
        image_alpha = 1;
        tagteam_colonel_pose(id, "dash", 3 - min(3, floor(col_tick / 3)));
        if (col_tick >= 12)
        {
            tagteam_colonel_state(id, col_after_warp);
        }
        break;
    case "dash_cut":
        tagteam_colonel_pose(id, "low", min(6, floor(col_tick / 3)));
        if (previous_tick == 0)
        {
            tagteam_colonel_sfx("thrust", 0.8);
        }
        if (col_tick >= 3 && col_tick < 14)
        {
            tagteam_colonel_melee(id, true);
        }
        if (col_tick >= 18)
        {
            tagteam_colonel_pose(id, "low", 6);
            tagteam_colonel_state(id, "recover");
        }
        break;
    case "recover":
        if (col_tick >= col_recover_delay)
        {
            tagteam_colonel_state(id, "idle");
        }
        break;
    case "crush_relocate":
        invul = true;
        damage = 0;
        tagteam_colonel_pose(id, "dash", min(3, floor(col_tick / 4)));
        if (col_tick >= 16)
        {
            x = col_target;
            col_face = (obj_player.x < x) ? -1 : 1;
            tagteam_colonel_state(id, "jump_prepare");
        }
        break;
    case "jump_prepare":
        tagteam_colonel_pose(id, "air", 8);
        if (col_tick >= 9)
        {
            col_vy = -11.4;
            tagteam_colonel_state(id, "jump");
            tagteam_colonel_sfx("jump", 0.75);
        }
        break;
    case "jump":
        col_vy += (0.6 * col_speed);
        y += (col_vy * col_speed);
        tagteam_colonel_pose(id, "air", 8);
        if (col_vy > 0 && col_tick >= 26)
        {
            tagteam_colonel_state(id, "air_cut");
        }
        break;
    case "air_cut":
        col_vy += (0.6 * col_speed);
        y = min(544, y + (col_vy * col_speed));
        tagteam_colonel_pose(id, "air", 8);
        if (y >= 544)
        {
            tagteam_colonel_sfx("land", 0.7);
            tagteam_colonel_state(id, "crush_cut");
        }
        break;
    case "crush_cut":
        tagteam_colonel_pose(id, "low", min(6, floor(col_tick / 3)));
        if (previous_tick < 4 && col_tick >= 4)
        {
            tagteam_colonel_sfx("crush", 1);
        }
        if (previous_tick < 7 && col_tick >= 7)
        {
            tagteam_colonel_ground_wave(id);
        }
        if (col_tick >= 37)
        {
            tagteam_colonel_state(id, "recover");
        }
        break;
    case "thunder_prepare":
        tagteam_colonel_pose(id, "thunder", min(2, floor(col_tick / 4)));
        if (previous_tick == 0)
        {
            tagteam_colonel_sfx("electric", 0.85);
        }
        if (col_tick >= 12)
        {
            tagteam_colonel_state(id, "thunder_raise");
        }
        break;
    case "thunder_raise":
        tagteam_colonel_pose(id, "thunder", min(5, 3 + floor(col_tick / 4)));
        if (col_tick >= 12)
        {
            tagteam_colonel_sfx("charge", 0.55);
            tagteam_colonel_state(id, "thunder_hold");
        }
        break;
    case "thunder_hold":
        tagteam_colonel_pose(id, "thunder", 6 + (floor(col_tick / 4) % 2));
        if (col_tick >= 44)
        {
            tagteam_colonel_state(id, "thunder_slam");
        }
        break;
    case "thunder_slam":
        tagteam_colonel_pose(id, "air", min(7, floor(col_tick / 3)));
        if (previous_tick < 9 && col_tick >= 9)
        {
            tagteam_colonel_sfx("land", 0.4);
            tagteam_colonel_release_electric(id);
        }
        if (col_tick >= 26)
        {
            tagteam_colonel_floor_columns(id);
            tagteam_colonel_state(id, "thunder_discharge");
        }
        break;
    case "thunder_discharge":
        tagteam_colonel_pose(id, "air", 1 + (floor(col_tick / 4) % 5));
        if (col_tick >= 52)
        {
            tagteam_colonel_state(id, "thunder_end");
        }
        break;
    case "thunder_end":
        tagteam_colonel_pose(id, "air", 7);
        if (col_tick >= 12)
        {
            tagteam_colonel_state(id, "recover");
        }
        break;
    case "rage":
        damage = 0;
        if (col_tick < 24)
        {
            tagteam_colonel_pose(id, "thunder", min(5, floor(col_tick / 4)));
        }
        else
        {
            tagteam_colonel_pose(id, "thunder", 6 + (floor(col_tick / 5) % 2));
        }
        if (col_tick == 24)
        {
            tagteam_colonel_sfx("spark", 0.85);
            col_strike_flash = 1;
            tagteam_colonel_charge_walls(id);
        }
        if (col_tick >= 76)
        {
            tagteam_colonel_state(id, "idle");
        }
        break;
    case "defeat":
        damage = 0;
        image_alpha = 1;
        y = col_floor;
        tagteam_colonel_pose(id, "fallen", min(8, floor(col_tick / 3)));
        if (col_tick >= 40)
        {
            col_dialogue = -4;
            if (!obj_tag_secret_arena.secret_skip_dialogue)
            {
                col_dialogue = instance_create_depth(0, 0, -1000, obj_dialogue);
                col_dialogue.dialogue = "tag_colonel_after";
                col_dialogue.movement = false;
            }
            tagteam_colonel_state(id, "aftermath");
        }
        break;
    case "aftermath":
        image_alpha = 1;
        y = col_floor;
        tagteam_colonel_pose(id, "fallen", 8);
        if (!instance_exists(col_dialogue))
        {
            tagteam_colonel_state(id, "explosion");
            var death_voice = tagteam_colonel_sfx("death", 0.85);
            with (obj_tag_secret_arena)
            {
                secret_death_voice = death_voice;
            }
        }
        break;
    case "explosion":
        damage = 0;
        y = col_floor;
        tagteam_colonel_pose(id, "fallen", 8);
        image_alpha = clamp(1 - ((col_tick - 36) / 24), 0, 1);
        if ((col_tick % 8) == 1)
        {
            var boom = instance_create_layer(x + random_range(-25, 25), y - random_range(5, 25), "Explosions", obj_explosion);
            boom.sprite_index = spr_explosion_player;
            boom.image_speed = 0.5;
            boom.tag_sigma_owner = id;
            if ((col_tick % 16) == 1)
            {
                tagteam_sigma_sfx("burst", 0.35);
            }
        }
        if (col_tick >= 72)
        {
            global.tag_secret_completed = true;
            with (obj_manager)
            {
                save_slot = 0;
                event_user(0);
            }
            obj_player.movement = true;
            obj_player.invul = false;
            global.hud_toggle = true;
            with (obj_tag_secret_arena)
            {
                secret_victory = true;
                secret_timer = 0;
                if (global.tag_colonel_soul_claimed)
                {
                    secret_reward_collected = true;
                }
                else
                {
                    secret_reward = instance_create_layer(clamp(other.x, 100, 348), 510, "Instances", obj_tag_sigma_reward);
                }
            }
            instance_destroy();
            exit;
        }
        break;
}
tagteam_colonel_try_rage(id);
var hurt_frame = clamp(floor(image_index), 0, sprite_get_number(sprite_index) - 1);
var hurt_mask = asset_get_index(sprite_get_name(sprite_index) + "_body_" + string(hurt_frame));
if (hurt_mask != -1)
{
    mask_index = hurt_mask;
}
if (col_dead)
{
    col_face = col_death_face;
    image_xscale = -col_death_face;
}
