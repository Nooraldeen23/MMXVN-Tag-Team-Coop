if (coop_enabled() && instance_exists(obj_coop_net) && obj_coop_net.spectating)
{
    image_alpha = 0;
    movement = false;
    movement_freeze = true;
    xspeed = 0;
    yspeed = 0;
    exit;
}
if (!coop_enabled() && room == rm_turtloid && !instance_exists(obj_tag_secret_entrance))
{
    instance_create_depth(0, 0, -50, obj_tag_secret_entrance);
}
tagteam_rescue_tick();
var tag_button_click = global.hud_toggle && !global.pause_screen && player_state != 5 && mouse_check_button_pressed(mb_left) && point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 2 * global.ui_scale, (display_get_gui_height() / 2) - (41 * global.ui_scale), 18 * global.ui_scale, (display_get_gui_height() / 2) - (5 * global.ui_scale));
tagteam_ensure_pools();
var tag_requested = keyboard_check_pressed(global.tag_swap_key) || (global.controller && gamepad_button_check_pressed_sdl(0, global.tag_swap_pad)) || tag_button_click;
if (coop_enabled())
{
    tag_requested = false;
    global.tag_auto_swap = false;
}
if (!global.pause)
{
    if (tag_state == 0 && tag_requested && !global.zero_unlock && global.hud_toggle && global.life > 0 && !global.death && player_state == 0 && !instance_exists(obj_dialogue) && !instance_exists(obj_comic_parent) && (!instance_exists(obj_cutscene_level_start) || obj_cutscene_level_start.action >= 4))
    {
        scr_make_sound(snd_menu_denied, 1, 1, false);
    }
    if (tag_cooldown > 0)
    {
        tag_cooldown--;
    }
    if (tag_state == 0 && (global.tag_auto_swap || tag_requested) && tagteam_partner_alive() && global.zero_unlock && tag_cooldown == 0 && global.hud_toggle && global.life > 0 && !global.death && movement && !animation_lock && !hurt && !invul && !invul_bullet && !invul_contact && player_state == 0 && !instance_exists(obj_dialogue) && !instance_exists(obj_comic_parent) && (!instance_exists(obj_cutscene_level_start) || obj_cutscene_level_start.action >= 4))
    {
        tag_x = x;
        tag_y = y;
        tag_face = image_xscale;
        tag_saved_xspeed = xspeed;
        tag_saved_yspeed = yspeed;
        tag_saved_weight = weight;
        tag_saved_airlock = airdash_lock;
        tag_saved_invul = invul;
        tag_saved_invul_bullet = invul_bullet;
        tag_saved_invul_contact = invul_contact;
        tag_saved_movement = movement;
        tag_to = (global.playable_character.name == "Zero") ? "X" : "Zero";
        tag_state = 1;
        tag_timer = 0;
        tag_duration = max(12, sprite_get_number(global.playable_character.action.warp_out));
        dash = false;
        dash_ground = false;
        dash_air = false;
        airdash_state = 0;
        machdash_hold = 0;
        alarm[4] = -1;
        attack_action = 0;
        attack_priority = 0;
        combo_state = 0;
        combo_timer = 0;
        shooting = 0;
        shooting_charge = 0;
        special_charge = 0;
        shooting_charged = false;
        shooting_charge_flicker = false;
        shooting_lock = false;
        special_state = -1;
        zero_ryuenjin = 0;
        x_rising_shoryuken = 0;
        crouch = false;
        wall_slide = false;
        wall_jump = false;
        flicker_weapon_swap = false;
        movement = false;
        movement_freeze = true;
        animation_lock = true;
        invul = true;
        invul_bullet = true;
        invul_contact = true;
        xspeed = 0;
        yspeed = 0;
        weight = 0;
        image_alpha = 1;
        image_angle = 0;
        sprite_index = global.playable_character.action.warp_out;
        image_index = 0;
        image_speed = 0;
        audio_stop_sound(snd_player_x_charge_fadeout);
        audio_stop_sound(snd_player_x_machcharge_fadeout);
        with (obj_bullet_saber)
        {
            if (villainy == 0)
            {
                instance_destroy();
            }
        }
        scr_make_sound(global.playable_character.sound.warp_out, 1, 1, false);
    }
    if (tag_state > 0)
    {
        x = tag_x;
        y = tag_y;
        xspeed = 0;
        yspeed = 0;
        weight = 0;
        movement = false;
        movement_freeze = true;
        animation_lock = true;
        invul = true;
        invul_bullet = true;
        invul_contact = true;
        image_speed = 0;
        image_xscale = tag_face;
        tag_timer++;
        if (tag_state == 1)
        {
            image_index = min(image_number - 1, floor((tag_timer * image_number) / tag_duration));
            if (tag_timer >= tag_duration)
            {
                tag_state = 2;
                tag_timer = 0;
                image_alpha = 0;
            }
        }
        else if (tag_state == 2)
        {
            if (tag_timer >= 6)
            {
                tagteam_capture_actor();
                var tag_ammo = [];
                for (var ti = 0; ti < array_length(global.weapon); ti++)
                {
                    array_push(tag_ammo, global.weapon[ti].ammo);
                }
                var tag_choice = global.weapon_choice;
                var tag_give_weapon = global.give_weapon;
                global.playable_character = (tag_to == "X") ? Character_X() : Character_Zero();
                scr_weapon_get("Default", false);
                for (var ti = 0; ti < ds_list_size(global.weapon_list); ti++)
                {
                    scr_weapon_get(ds_list_find_value(global.weapon_list, ti), false);
                }
                for (var ti = 0; ti < min(array_length(global.weapon), array_length(tag_ammo)); ti++)
                {
                    global.weapon[ti].ammo = tag_ammo[ti];
                }
                global.weapon_choice = tag_choice;
                global.give_weapon = tag_give_weapon;
                tagteam_restore_actor();
                spr_manager = new sprite_manager(id);
                scr_setup_player_sprites();
                air_dash_part = ((global.playable_character.name == "Zero" && global.black_armour_get) || ds_list_find_index(global.parts_equipped, 37) != -1) ? 1 : 0;
                tag_state = 3;
                tag_timer = 0;
                sprite_index = global.playable_character.action.warp_in;
                image_index = 0;
                image_speed = 0;
                image_alpha = 1;
                tag_duration = max(16, sprite_get_number(sprite_index));
                scr_make_sound(global.playable_character.sound.warp_in, 1, 1, false);
            }
        }
        else if (tag_state == 3)
        {
            image_index = min(image_number - 1, floor((tag_timer * image_number) / tag_duration));
            if (tag_timer >= tag_duration)
            {
                tag_state = 0;
                tag_timer = 0;
                tag_cooldown = 20;
                animation_lock = false;
                movement_freeze = false;
                movement = tag_saved_movement;
                invul = tag_saved_invul;
                invul_bullet = tag_saved_invul_bullet;
                invul_contact = tag_saved_invul_contact;
                tagteam_finish_rescue();
                weight = 0.3;
                xspeed = tag_saved_xspeed;
                yspeed = airborne ? tag_saved_yspeed : 0;
                airdash_lock = tag_saved_airlock;
                image_alpha = 1;
                image_angle = 0;
                change_sprite(spr_manager, airborne ? global.playable_character.action.falling : global.playable_character.action.idle, 0, 0, true);
            }
        }
        exit;
    }
}
if (global.playable_character.name == "Zero")
{
    air_dash_part = (global.black_armour_get || ds_list_find_index(global.parts_equipped, 37) != -1) ? 1 : 0;
}
if (global.pause == true)
{
    exit;
}
event_inherited();
if (shooting > 0)
{
    shooting--;
}
if (combo_timer > 0 && scr_sprite_finished(spr_manager, [spr_player_zero_saber, spr_player_zero_saber_2, spr_player_zero_saber_3, spr_player_zero_saber_crouch, spr_player_zero_saber_jump, spr_player_zero_saber_landing, spr_player_zero_saber_jump_double, spr_player_zero_saber_walljump, spr_player_zero_saber_climb, spr_player_zero_upattack, spr_player_zero_ryuenjin]))
{
    combo_timer--;
}
if (combo_timer == 0 && combo_state < 3)
{
    combo_state = 0;
}
if (hurt == true)
{
    combo_state = 0;
}
if (global.death == false && animation_lock == false)
{
    if (attack_action == UnknownEnum.Value_1 && scr_sprite_finished(spr_manager, [spr_player_x_saber, spr_player_x_saber_jump, spr_player_x_saber_walljump, spr_player_x_saber_landing]))
    {
        attack_action = UnknownEnum.Value_0;
    }
    if (attack_action == UnknownEnum.Value_2 && scr_sprite_finished(spr_manager, [spr_player_zero_saber, spr_player_zero_saber_2, spr_player_zero_saber_3, spr_player_zero_saber_crouch, spr_player_zero_saber_jump, spr_player_zero_saber_landing, spr_player_zero_saber_jump_double, spr_player_zero_saber_walljump, spr_player_zero_saber_climb, spr_player_zero_upattack, spr_player_zero_ryuenjin]))
    {
        if (crouch == false)
        {
            if (airborne == false)
            {
                change_sprite(spr_manager, spr_player_zero_holster);
            }
            if (combo_state == 3)
            {
                attack_action = UnknownEnum.Value_5;
            }
            else
            {
                attack_action = UnknownEnum.Value_0;
            }
        }
        else
        {
            change_sprite(spr_manager, spr_player_zero_holster_crouch);
            attack_action = UnknownEnum.Value_0;
        }
    }
    if (attack_action == UnknownEnum.Value_5 && scr_sprite_finished(spr_manager, spr_player_zero_holster))
    {
        combo_state = 0;
        attack_action = UnknownEnum.Value_0;
    }
    if ((attack_action == UnknownEnum.Value_6 || attack_action == UnknownEnum.Value_7) && scr_sprite_finished(spr_manager, spr_player_x_idle_shoot))
    {
        attack_action = UnknownEnum.Value_0;
    }
    if (attack_action == UnknownEnum.Value_4 && special_charge == 0)
    {
        attack_action = UnknownEnum.Value_0;
    }
    if (attack_action == UnknownEnum.Value_0)
    {
        zero_technique = 0;
        attack_priority = 0;
        if (combo_state >= 3)
        {
            combo_state = 0;
        }
    }
    image_speed = scr_sprite_is_reversed(spr_manager) ? -1 : 1;
    if (attack_action == UnknownEnum.Value_1 && global.weapon[global.weapon_choice].type == "Magma Blade")
    {
        image_speed = 0.75;
    }
    else if (attack_action == UnknownEnum.Value_1 && global.weapon[global.weapon_choice].type == "X-Saber" && global.x_armour_arm == "Blade Arm")
    {
        image_speed = 1.25;
    }
    if (movement == true)
    {
        if (smokebomb_invul > 0)
        {
            smokebomb_invul--;
            if ((smokebomb_invul % 2) == 0)
            {
                if (smokebomb_flicker == true)
                {
                    smokebomb_flicker = false;
                }
                else
                {
                    smokebomb_flicker = true;
                }
            }
        }
    }
    else
    {
        smokebomb_flicker = false;
    }
    var water_check = false;
    with (instance_place(x, y, obj_water))
    {
        water_check = true;
    }
    if (yspeed != 0)
    {
        if (underwater == false && water_check == true)
        {
            underwater = true;
            with (instance_place(x, y, obj_water))
            {
                effect = instance_create_depth(other.x, y, depth + 1, obj_explosion);
                effect.sprite_index = spr_water_splash;
                scr_make_sound(snd_splash, 1, 1, false);
            }
        }
        else if (underwater == true && water_check == false)
        {
            underwater = false;
            with (instance_place(x, y + 10, obj_water))
            {
                effect = instance_create_depth(other.x, y, depth + 1, obj_explosion);
                effect.sprite_index = spr_water_splash;
                scr_make_sound(snd_splash, 1, 1, false);
            }
        }
    }
    weight = 0.3;
    fall_speed = 6;
    if (underwater == true)
    {
        weight = 0.15;
        fall_speed = 3;
    }
    if (climbing == true || airdash_state > 0)
    {
        weight = 0;
    }
    if (attack_priority >= 3)
    {
        movement_freeze = true;
    }
    else
    {
        movement_freeze = false;
    }
    if (hurt == false && attack_priority < 3)
    {
        if (movement == true)
        {
            if (attack_priority == 0 || combo_state > 0 || attack_action == UnknownEnum.Value_4)
            {
                if (player_state != UnknownEnum.Value_5)
                {
                    if ((global.input_shoot || global.input_shoot_released) && (attack_action == UnknownEnum.Value_0 || attack_action == UnknownEnum.Value_2))
                    {
                        if (shooting_lock == false)
                        {
                            event_user(1);
                            rapid_firerate++;
                        }
                    }
                    if ((global.input_special || global.input_special_released) || ((global.input_giga || global.input_giga_released) && !global.input_shoot_pressed))
                    {
                        if (player_state == UnknownEnum.Value_0 || player_state == UnknownEnum.Value_1)
                        {
                            if (shooting_lock == false && !(global.weapon[global.weapon_choice].type == "X-Saber" && crouch == true))
                            {
                                event_user(3);
                            }
                        }
                    }
                    mech_activate = false;
                }
                else if ((global.input_shoot || global.input_shoot_released) && attack_action == UnknownEnum.Value_0)
                {
                    if (shooting_lock == false)
                    {
                        event_user(1);
                    }
                }
            }
            move_speed = 2;
            jump_height = 6.5;
            dash_speed = 4.5;
            dash_length = 30;
            if (ds_list_find_index(global.parts_equipped, 2) != -1)
            {
                scr_get_part_effect(2, false);
            }
            move_speed *= 10;
            floor(move_speed);
            move_speed /= 10;
            if (player_state == UnknownEnum.Value_4)
            {
                dash_speed *= 1.25;
                jump_height *= 1.1;
            }
            if (global.input_jump_pressed && airborne == false && (attack_action == UnknownEnum.Value_0 || attack_action == UnknownEnum.Value_5 || attack_action == UnknownEnum.Value_2) && sprite_index != global.playable_character.action.climb_finish)
            {
                attack_action = UnknownEnum.Value_0;
                yspeed -= jump_height;
                if (global.input_dash)
                {
                    dash = true;
                }
                if (player_state == UnknownEnum.Value_5)
                {
                    audio_stop_sound(snd_mech_dash);
                    scr_make_sound(snd_mech_jump, 1, 1, false);
                }
                else if (player_state == UnknownEnum.Value_4)
                {
                    audio_stop_sound(global.playable_character.sound.dash);
                    scr_make_sound(snd_bike_jump, 1, 1, false);
                }
                else
                {
                    audio_stop_sound(global.playable_character.sound.dash);
                    scr_make_sound(global.playable_character.sound.jump, 1, 1, false);
                    scr_player_voicelines("Jump");
                }
            }
            if (global.input_dash_pressed == true && airborne == false && dash == false && !walled && sprite_index != global.playable_character.action.climb_finish && !(attack_action == UnknownEnum.Value_4 || attack_action == UnknownEnum.Value_3 || attack_action == UnknownEnum.Value_9))
            {
                dash = true;
                dash_ground = true;
                alarm[4] = dash_length;
                if (global.input_left)
                {
                    image_xscale = -1;
                }
                else if (global.input_right)
                {
                    image_xscale = 1;
                }
                effect = instance_create_layer(x - (5 * image_xscale), y + 23, "Explosions", obj_explosion);
                effect.sprite_index = spr_effect_dash_trail;
                effect.image_xscale = image_xscale;
                if (player_state == UnknownEnum.Value_5)
                {
                    scr_make_sound(snd_mech_dash, 1, 1, false);
                    effect.y = y + 40;
                }
                else
                {
                    scr_make_sound(global.playable_character.sound.dash, 1, 1, false);
                }
            }
            if (player_state != UnknownEnum.Value_1)
            {
                if (airdash_state == 0 && attack_priority == 0)
                {
                    if (wall_jump == true)
                    {
                        if (dash == true)
                        {
                            xspeed = dash_speed * -image_xscale;
                        }
                        else
                        {
                            xspeed = move_speed * -image_xscale;
                        }
                    }
                    else if (dash == true)
                    {
                        if (airborne == true)
                        {
                            alarm[4] = 1;
                            dash_ground = false;
                            if (global.input_left)
                            {
                                xspeed = -dash_speed;
                                image_xscale = -1;
                            }
                            else if (global.input_right)
                            {
                                xspeed = dash_speed;
                                image_xscale = 1;
                            }
                            else
                            {
                                xspeed = 0;
                            }
                        }
                        else if (airborne == true && air_dash_part > 0)
                        {
                            alarm[4] = 1;
                            dash_ground = false;
                            if (global.input_left)
                            {
                                xspeed = -dash_speed;
                                image_xscale = -1;
                            }
                            else if (global.input_right)
                            {
                                xspeed = dash_speed;
                                image_xscale = 1;
                            }
                            else
                            {
                                xspeed = 0;
                            }
                        }
                        else if (dash_ground == true)
                        {
                            xspeed = dash_speed * image_xscale;
                            if (!global.input_dash)
                            {
                                alarm[4] = 1;
                            }
                            if (global.input_left && image_xscale == 1)
                            {
                                alarm[4] = 1;
                            }
                            if (global.input_right && image_xscale == -1)
                            {
                                alarm[4] = 1;
                            }
                        }
                    }
                    else if (global.input_left)
                    {
                        xspeed = -move_speed;
                        image_xscale = -1;
                    }
                    else if (global.input_right)
                    {
                        xspeed = move_speed;
                        image_xscale = 1;
                    }
                    else
                    {
                        xspeed = 0;
                    }
                }
            }
            else
            {
                crouch = false;
            }
            if (airborne == false)
            {
                wall_slide = false;
                if (!(attack_action == UnknownEnum.Value_4 || attack_action == UnknownEnum.Value_3 || attack_action == UnknownEnum.Value_9))
                {
                    if (global.input_down && dash == false)
                    {
                        if (crouch == false)
                        {
                            attack_action = UnknownEnum.Value_0;
                        }
                        xspeed = 0;
                        crouch = true;
                        if (combo_state > 1)
                        {
                            combo_state = 0;
                        }
                    }
                    else
                    {
                        if (crouch == true)
                        {
                            attack_action = UnknownEnum.Value_0;
                        }
                        crouch = false;
                    }
                }
            }
            else
            {
                if (place_meeting(x + (5 * image_xscale), y, obj_solid) && global.input_jump_pressed)
                {
                    scr_stop_wall(xspeed);
                }
                if (global.input_jump_released)
                {
                    if (yspeed < 0)
                    {
                        yspeed = 0;
                    }
                }
            }
            if (wall_turn == true && walled == false && movement_freeze == false)
            {
                image_xscale *= -1;
                wall_turn = false;
            }
            if (player_state == UnknownEnum.Value_5)
            {
                if (mech_weapon == 6)
                {
                    aiminglaser_center_x = x + (17 * image_xscale);
                    aiminglaser_center_y = y;
                    if (global.input_down && aiminglaser_orbit_angle > -90)
                    {
                        aiminglaser_orbit_angle -= 10;
                    }
                    else if (global.input_up && aiminglaser_orbit_angle < 90)
                    {
                        aiminglaser_orbit_angle += 10;
                    }
                    aiminglaser_x = lengthdir_x(aiminglaser_orbit * image_xscale, aiminglaser_orbit_angle) + aiminglaser_center_x;
                    aiminglaser_y = lengthdir_y(aiminglaser_orbit, aiminglaser_orbit_angle) + aiminglaser_center_y;
                    with (collision_line(x, y, aiminglaser_x, aiminglaser_y, obj_enemy_hostile, false, true))
                    {
                        if (aiminglaser_marked == 0 && life > 0 && invul == false)
                        {
                            aiminglaser_marked = 600;
                            aiminglaser_marked_colour = choose(65280, 65535, 255);
                            scr_make_sound(snd_shoot_aiminglaser, 1, 1, false);
                        }
                    }
                }
                if (mech_recoil > 0)
                {
                    mech_recoil--;
                }
                if (mech_firerate > 0)
                {
                    mech_firerate--;
                }
                if (((image_index > 2 && image_index < 3) || image_index > 7) && sprite_index == spr_mech_move)
                {
                    if (mech_step == false)
                    {
                        mech_step = true;
                        scr_make_sound(snd_mech_step, 0.5, 1, false);
                    }
                }
                else
                {
                    mech_step = false;
                }
                if (life_mech <= 0)
                {
                    player_state = UnknownEnum.Value_0;
                    obj_game.life_tick = global.life;
                    airdash_lock = 0;
                    flicker = false;
                    event_user(5);
                    instance_create_layer(x, y, "Explosions", obj_explosion);
                    repeat (10)
                    {
                        var range = 40;
                        var x_range = random_range(-range, range);
                        var y_range = random_range(-range, range);
                        instance_create_layer(x + x_range, y + y_range, "Explosions", obj_explosion);
                    }
                    scr_make_sound(snd_explosion_large, 1, 1, false);
                    for (var i = 0; i < 10; i++)
                    {
                        debris = instance_create_layer(x, y, "Explosions", obj_particle_debris);
                        debris.sprite_index = spr_mech_debris;
                        debris.image_index = i;
                        debris.palette_type = spr_mech_palette;
                        debris.palette = mech_weapon;
                    }
                }
            }
            else
            {
                mech_recoil = 0;
                mech_firerate = 0;
            }
            if (player_state == UnknownEnum.Value_0)
            {
                if (ds_list_find_index(global.parts_equipped, 37) != -1)
                {
                    scr_get_part_effect(37, false);
                }
                if (global.playable_character.name == "X")
                {
                    if (global.x_armour_leg != "Blade Leg" && airborne == true && global.input_dash_pressed && airdash_lock == false && air_dash_part > 0 && attack_priority == 0 && !walled && sprite_index != global.playable_character.action.climb_finish)
                    {
                        if (global.input_left && image_xscale == 1)
                        {
                            xspeed = dash_speed * image_xscale;
                            alarm[4] = 1;
                        }
                        if (global.input_right && image_xscale == -1)
                        {
                            xspeed = dash_speed * image_xscale;
                            alarm[4] = 1;
                        }
                        else
                        {
                            alarm[4] = 1;
                        }
                        airdash_state = 2;
                        airdash_point = 1;
                        dash = true;
                        dash_ground = true;
                        alarm[4] = dash_length;
                        xspeed = dash_speed * image_xscale;
                        yspeed = 0;
                        weight = 0;
                        airdash_lock = true;
                        scr_make_sound(global.playable_character.sound.dash, 1, 1, false);
                        if (place_meeting(x + xspeed, y + yspeed, obj_solid))
                        {
                            alarm[4] = 1;
                        }
                    }
                    if (airdash_state == 2 && global.x_armour_leg != "Blade Leg")
                    {
                        if ((global.input_left && image_xscale == 1) || (global.input_right && image_xscale == -1))
                        {
                            alarm[4] = 1;
                        }
                    }
                    if (global.x_armour_leg == "Blade Leg" && airborne == true && attack_priority == 0 && wall_slide == false)
                    {
                        switch (airdash_state)
                        {
                            case 0:
                                if (global.input_dash_pressed && airdash_lock == false)
                                {
                                    airdash_lock = true;
                                    shooting_lock = true;
                                    airdash_state = 1;
                                    shooting_charge_flicker = false;
                                }
                                break;
                            case 1:
                                if (global.input_dash)
                                {
                                    machdash_hold++;
                                    yspeed = 0;
                                    xspeed = 0;
                                    dash = false;
                                    if (global.input_left)
                                    {
                                        image_xscale = -1;
                                    }
                                    else if (global.input_right)
                                    {
                                        image_xscale = 1;
                                    }
                                }
                                if (global.input_dash_released)
                                {
                                    airdash_state = 2;
                                    alarm[4] = dash_length / 2;
                                    machdash_direction = -1;
                                    if (global.input_left)
                                    {
                                        image_xscale = -1;
                                        machdash_direction = 180;
                                    }
                                    else if (global.input_right)
                                    {
                                        image_xscale = 1;
                                        machdash_direction = 0;
                                    }
                                    else if (global.input_up)
                                    {
                                        machdash_direction = 90;
                                    }
                                    else if (global.input_down)
                                    {
                                        machdash_direction = 270;
                                    }
                                    else
                                    {
                                        alarm[4] = 1;
                                    }
                                }
                                if (machdash_hold > 180)
                                {
                                    alarm[4] = 1;
                                    airdash_state = 2;
                                }
                                break;
                            case 2:
                                if (dash == false)
                                {
                                    dash = true;
                                    machdash_invul = 12;
                                    event_user(4);
                                    machdash_hold = 0;
                                    scr_make_sound(global.playable_character.sound.dash, 1, 1, false);
                                }
                                if (machdash_invul != 0)
                                {
                                    machdash_invul--;
                                    invul_contact = true;
                                }
                                else
                                {
                                    invul_contact = false;
                                }
                                var mach_dash_speed = dash_speed * 2;
                                switch (machdash_direction)
                                {
                                    case 0:
                                        xspeed = mach_dash_speed;
                                        break;
                                    case 180:
                                        xspeed = -mach_dash_speed;
                                        break;
                                    case 90:
                                        yspeed = -mach_dash_speed;
                                        break;
                                    case 270:
                                        yspeed = mach_dash_speed;
                                        break;
                                }
                                switch (machdash_direction)
                                {
                                    case 0:
                                        if (!global.input_right)
                                        {
                                            alarm[4] = 1;
                                        }
                                        break;
                                    case 180:
                                        if (!global.input_left)
                                        {
                                            alarm[4] = 1;
                                        }
                                        break;
                                    case 90:
                                        if (!global.input_up)
                                        {
                                            alarm[4] = 1;
                                        }
                                        break;
                                    case 270:
                                        if (!global.input_down)
                                        {
                                            alarm[4] = 1;
                                        }
                                        break;
                                }
                                if ((global.animate % 3) == 0 && machdash_charged == true)
                                {
                                    effect = instance_create_depth(x, y + random_range(-10, 10), depth + 1, obj_explosion);
                                    effect.sprite_index = spr_effect_trail_charged;
                                    effect.image_alpha = image_alpha;
                                    effect.speed = xspeed / 4;
                                    if (machdash_direction == 90 || machdash_direction == 270)
                                    {
                                        effect.x = x + random_range(-10, 10);
                                        effect.y = y;
                                        effect.image_angle = 270;
                                        effect.direction = 270;
                                        effect.speed = yspeed / 4;
                                    }
                                }
                                if (place_meeting(x + xspeed, y + yspeed, obj_solid))
                                {
                                    alarm[4] = 1;
                                }
                                break;
                        }
                    }
                }
                else if (global.playable_character.name == "Zero")
                {
                    if (airborne == true && global.input_dash_pressed && airdash_lock == false && air_dash_part > 0 && attack_priority == 0 && !walled && sprite_index != global.playable_character.action.climb_finish)
                    {
                        if (global.input_left && image_xscale == 1)
                        {
                            xspeed = dash_speed * image_xscale;
                            alarm[4] = 1;
                        }
                        if (global.input_right && image_xscale == -1)
                        {
                            xspeed = dash_speed * image_xscale;
                            alarm[4] = 1;
                        }
                        else
                        {
                            alarm[4] = 1;
                        }
                        airdash_state = 2;
                        airdash_point = 1;
                        dash = true;
                        dash_ground = true;
                        alarm[4] = dash_length;
                        xspeed = dash_speed * image_xscale;
                        yspeed = 0;
                        weight = 0;
                        airdash_lock = true;
                        scr_make_sound(global.playable_character.sound.dash, 1, 1, false);
                        if (place_meeting(x + xspeed, y + yspeed, obj_solid))
                        {
                            alarm[4] = 1;
                        }
                    }
                    if (airdash_state == 2 && (global.input_shoot || global.input_giga))
                    {
                        airdash_state = 0;
                        airdash_lock = true;
                        alarm[4] = 1;
                    }
                    if (airdash_state == 2)
                    {
                        if ((global.input_left && image_xscale == 1) || (global.input_right && image_xscale == -1))
                        {
                            alarm[4] = 1;
                        }
                    }
                    if (airborne == true && global.input_jump_pressed && airdash_lock == false && wall_slide == false)
                    {
                        if (global.black_armour_get == true)
                        {
                            yspeed = -(jump_height / 1.05);
                        }
                        else
                        {
                            yspeed = -(jump_height / 1.25);
                        }
                        if (global.input_dash && dash == false)
                        {
                            dash = true;
                            scr_make_sound(global.playable_character.sound.dash, 1, 1, false);
                        }
                        attack_action = UnknownEnum.Value_0;
                        change_sprite(spr_manager, "zero_double_jump_falling", UnknownEnum.Value_0, UnknownEnum.Value_1);
                        scr_make_sound(global.playable_character.sound.jump, 1, 1, false);
                        scr_player_voicelines("Jump");
                        alarm[4] = 1;
                        airdash_lock = true;
                    }
                }
            }
            else
            {
                switch (player_state)
                {
                    case UnknownEnum.Value_4:
                        if (airborne == true && global.input_jump_pressed && airdash_lock == false)
                        {
                            yspeed = -jump_height;
                            if (global.input_dash)
                            {
                                dash = true;
                                scr_make_sound(global.playable_character.sound.dash, 1, 1, false);
                            }
                            scr_make_sound(snd_bike_doublejump, 1, 1, false);
                            effect = instance_create_depth(x, y, depth + 1, obj_explosion);
                            effect.sprite_index = spr_effect_bike_jump;
                            alarm[4] = 1;
                            airdash_lock = true;
                        }
                        break;
                    case UnknownEnum.Value_5:
                        if (airdash_state == 0)
                        {
                            if (airborne == true && global.input_dash_pressed && airdash_lock == false)
                            {
                                airdash_state = 2;
                                airdash_lock = true;
                                mech_hover = false;
                                dash = true;
                                scr_make_sound(snd_mech_airdash, 1, 1, false);
                                alarm[4] = dash_length;
                            }
                            if (airborne == true && global.input_jump_pressed && yspeed > 0)
                            {
                                mech_hover = true;
                                scr_make_sound(snd_mech_hover_start, 1, 1, false);
                            }
                            if (mech_hover == true)
                            {
                                yspeed = 0.5;
                                if (global.input_left)
                                {
                                    xspeed = -2;
                                }
                                else if (global.input_right)
                                {
                                    xspeed = 2;
                                }
                            }
                            if (!global.input_jump || hurt == true || airborne == false)
                            {
                                mech_hover = false;
                            }
                        }
                        else
                        {
                            xspeed = dash_speed * image_xscale;
                            yspeed = 0;
                            if (global.input_left && image_xscale == 1)
                            {
                                alarm[4] = 1;
                            }
                            if (global.input_right && image_xscale == -1)
                            {
                                alarm[4] = 1;
                            }
                            if (place_meeting(x + xspeed, y + yspeed, obj_solid))
                            {
                                alarm[4] = 1;
                            }
                        }
                        if (global.input_up && global.input_jump_pressed)
                        {
                            player_state = UnknownEnum.Value_0;
                            obj_game.life_tick = global.life;
                            airdash_lock = 0;
                            flicker = false;
                            event_user(5);
                            mech = instance_create_depth(x, y, depth + 1, obj_pickup_mech);
                            mech.image_xscale = image_xscale;
                            mech.life = life_mech;
                            mech.weapon = mech_weapon;
                            if (airborne == true)
                            {
                                mech.sprite_index = spr_mech_fall;
                            }
                            else
                            {
                                mech.image_speed = -1;
                                mech.image_index = mech.image_number - 1;
                            }
                            xspeed = 0;
                            yspeed = -jump_height;
                            y -= 5;
                            dash = false;
                            if (global.input_dash)
                            {
                                dash = true;
                            }
                            climbing_dismount = false;
                            scr_make_sound(snd_mech_deactivate, 1, 1, false);
                            scr_make_sound(global.playable_character.sound.jump, 1, 1, false);
                            scr_player_voicelines("Jump");
                        }
                        break;
                    case UnknownEnum.Value_2:
                        if (!scr_current_sprite_is(global.playable_character.action.climb_finish) || scr_sprite_finished(spr_manager, global.playable_character.action.climb_finish))
                        {
                            player_state = UnknownEnum.Value_0;
                        }
                        break;
                    case UnknownEnum.Value_3:
                        if (!scr_current_sprite_is(global.playable_character.action.climb_finish) || scr_sprite_finished(spr_manager, global.playable_character.action.climb_finish))
                        {
                            player_state = UnknownEnum.Value_1;
                            y += 41;
                            with (instance_place(x, y, obj_ladder))
                            {
                                if (down_update == true)
                                {
                                    obj_camera.y = obj_player.y;
                                }
                            }
                        }
                        yspeed = 0;
                        var obj = instance_place(x, y + 2, obj_ladder);
                        if (obj)
                        {
                            x = obj.x + 8;
                        }
                        break;
                    case UnknownEnum.Value_1:
                        dash = false;
                        if (global.input_up)
                        {
                            yspeed = -move_speed;
                        }
                        else if (global.input_down && place_meeting(x, y + move_speed, obj_ladder))
                        {
                            yspeed = move_speed;
                        }
                        else
                        {
                            yspeed = 0;
                        }
                        if (place_meeting(x, y, obj_ladder))
                        {
                            x = instance_place(x, y, obj_ladder).x + 8;
                        }
                        y = round(y);
                        if (shooting > 0 || attack_priority > 0)
                        {
                            yspeed = 0;
                        }
                        if (global.input_left)
                        {
                            image_xscale = -1;
                        }
                        else if (global.input_right)
                        {
                            image_xscale = 1;
                        }
                        if (!global.input_up && y > instance_place(x, y + (16 * other.image_yscale), obj_ladder))
                        {
                            player_state = UnknownEnum.Value_0;
                        }
                        var ladder = instance_place(x, y, obj_ladder);
                        var dif = ladder ? (y - ladder.bbox_top) : infinity;
                        if (global.input_up && dif < 32 && ladder.topless == false)
                        {
                            player_state = UnknownEnum.Value_2;
                            y = scr_snap_to_object(1, 1, ladder);
                            ladder.update();
                            yspeed = scr_move(16, 1);
                            yspeed = 1;
                            change_sprite(spr_manager, global.playable_character.action.climb_finish);
                            shooting = 0;
                            shooting_charged = 0;
                            with (obj_particle_muzzle_player)
                            {
                                instance_destroy();
                            }
                            with (instance_place(x, y + 40, obj_ladder))
                            {
                                if (up_update == true)
                                {
                                    obj_camera.y = obj_player.y;
                                }
                            }
                            if (dif < 16)
                            {
                                image_index = 1;
                            }
                        }
                        if (global.input_jump_pressed)
                        {
                            player_state = UnknownEnum.Value_0;
                            climbing_dismount = true;
                            if (!global.input_down)
                            {
                                yspeed = -jump_height;
                                if (global.input_dash)
                                {
                                    dash = true;
                                }
                                scr_make_sound(global.playable_character.sound.jump, 1, 1, false);
                                scr_player_voicelines("Jump");
                            }
                        }
                        if (attack_action == UnknownEnum.Value_1 || attack_action == UnknownEnum.Value_8)
                        {
                            player_state = UnknownEnum.Value_0;
                            climbing_dismount = true;
                        }
                        break;
                }
            }
            if (room != rm_weapon_get)
            {
                if (global.input_start_pressed && !instance_exists(obj_fade_out) && !instance_exists(obj_fade_in))
                {
                    global.pause_screen_state = 1;
                    global.pause = true;
                    fade = instance_create_depth(obj_camera.x, obj_camera.y, 0, obj_fade_out);
                    fade.fade_speed = global.pause_screen_speed;
                }
            }
            if (lowhealth_indicator == false && global.life <= 8)
            {
                lowhealth_indicator = true;
                scr_player_voicelines("Low Health");
            }
            else if (global.life >= global.lifemax)
            {
                lowhealth_indicator = false;
            }
        }
        else
        {
            mech_hover = false;
            event_user(5);
            crouch = false;
        }
    }
    else
    {
        mech_hover = false;
        smokebomb_invul = 0;
        event_user(5);
    }
    if (slowed > 0)
    {
        slowed--;
        xspeed /= 2;
    }
}
else
{
    smokebomb_invul = 0;
    event_user(5);
}
if (dash == true && (global.animate % 3) == 0 && global.death == false && player_state != UnknownEnum.Value_5)
{
    afterimage = instance_create_depth(x, y, depth + 10, obj_afterimage);
    afterimage.image_blend = global.playable_character.visual.afterimage;
    afterimage.sprite_index = sprite_index;
    afterimage.image_index = image_index;
    afterimage.image_xscale = image_xscale;
    afterimage.image_alpha = image_alpha;
    afterimage.player = true;
    if (player_state == UnknownEnum.Value_4)
    {
        afterimage.image_xscale = 1;
    }
    if (global.black_armour_get == true && global.playable_character.name == "Zero")
    {
        afterimage.image_blend = #7800FF;
    }
    if (x_rising_shoryuken >= 1 && global.playable_character.name == "X")
    {
        afterimage.image_blend = c_red;
    }
    if (palette == 17)
    {
        afterimage.image_blend = #DE4AAC;
    }
    if (smokebomb_invul > 0)
    {
        afterimage.image_blend = #1E1E1E;
    }
}
if (place_meeting(x, y + 1, obj_solid_slope))
{
    on_slope = true;
}
else
{
    on_slope = false;
}
if (sprite_index == spr_player_x_victory && image_index >= 2 && image_index < 3)
{
    scr_make_sound(snd_pose, 1, 1, false);
}
else if (sprite_index == spr_player_zero_victory && image_index >= 8 && image_index < 9)
{
    scr_make_sound(snd_pose, 1, 1, false);
}
if (global.x_armour_head != 0 || global.x_armour_chest != 0 || global.x_armour_arm != 0 || global.x_armour_leg != 0)
{
    if (sprite_index == spr_player_x_armour_up && image_index >= 4 && image_index < 5)
    {
        scr_make_sound(snd_pose, 1, 1, false);
    }
    if (sprite_index == spr_player_x_warp_in && image_index >= 14 && image_index < 15)
    {
        scr_make_sound(snd_pose, 1, 1, false);
    }
}
camera_zone = instance_place(x, y, obj_camera_freemove);
if (room != rm_weapon_get)
{
    if (attack_action == 0 && global.life > 0 && (player_state == UnknownEnum.Value_0 || player_state == UnknownEnum.Value_1) && image_alpha != 0)
    {
        if ((global.input_swap_left_pressed && global.input_swap_right) || (global.input_swap_left && global.input_swap_right_pressed))
        {
            global.weapon_choice = 0;
            flicker_weapon_swap = true;
            scr_make_sound(snd_menu_move, 1, 1, false);
        }
        else if (global.input_swap_left_pressed || global.input_swap_right_pressed)
        {
            if (global.input_swap_right_pressed)
            {
                for (var i = 1; i < 11; i++)
                {
                    if ((global.weapon_choice + i) > (array_length(global.weapon) - 1))
                    {
                        global.weapon_choice = 0;
                        flicker_weapon_swap = true;
                        scr_make_sound(snd_menu_move, 1, 1, false);
                        break;
                    }
                    else if (global.weapon[global.weapon_choice + i].type != 0)
                    {
                        global.weapon_choice = global.weapon_choice + i;
                        flicker_weapon_swap = true;
                        scr_make_sound(snd_menu_move, 1, 1, false);
                        break;
                    }
                }
            }
            else if (global.input_swap_left_pressed)
            {
                for (var i = 1; i < 11; i++)
                {
                    if (global.weapon_choice == 0)
                    {
                        for (var a = 1; a < 10; a++)
                        {
                            if (global.weapon[10 - a].type != 0)
                            {
                                global.weapon_choice = 10 - a;
                                flicker_weapon_swap = true;
                                scr_make_sound(snd_menu_move, 1, 1, false);
                                break;
                            }
                        }
                        break;
                    }
                    else if (global.weapon[global.weapon_choice - i].type != 0)
                    {
                        global.weapon_choice = global.weapon_choice - i;
                        flicker_weapon_swap = true;
                        scr_make_sound(snd_menu_move, 1, 1, false);
                        break;
                    }
                }
            }
        }
        if (global.controller == false)
        {
            if ((keyboard_key >= ord("0") && keyboard_key <= ord("9")) || (keyboard_key >= vk_numpad0 && keyboard_key <= vk_numpad9))
            {
                if (keyboard_check_pressed(keyboard_key))
                {
                    scr_keybinds();
                    var key_display = key[keyboard_key];
                    key_display = real(key_display);
                    if (global.weapon[key_display].type != 0 && global.weapon_choice != key_display)
                    {
                        global.weapon_choice = key_display;
                        flicker_weapon_swap = true;
                        scr_make_sound(snd_menu_move, 1, 1, false);
                    }
                    obj_game.wheel_state = 1;
                }
            }
        }
        else
        {
            var wheel_amount = 8;
            var haxis = gamepad_axis_value(0, gp_axisrh);
            var vaxis = gamepad_axis_value(0, gp_axisrv);
            var key_display = -1;
            if (haxis < (-obj_menu_paused.controller_deadzone / 2) || haxis > (obj_menu_paused.controller_deadzone / 2) || vaxis < (-obj_menu_paused.controller_deadzone / 2) || vaxis > (obj_menu_paused.controller_deadzone / 2))
            {
                var get_direction = -point_direction(0, 0, haxis, vaxis) + 90;
                if (get_direction <= 0)
                {
                    get_direction += 360;
                }
                key_display = round(get_direction / (360 / wheel_amount)) + 1;
                obj_game.wheel_state = 1;
            }
            if (gamepad_button_check_pressed(0, gp_stickr) && global.weapon_choice != 0)
            {
                key_display = 0;
                obj_game.wheel_state = 1;
            }
            for (var a = 0; a < wheel_amount; a++)
            {
                if (key_display > -1)
                {
                    if (global.weapon[key_display].type != 0 && global.weapon_choice != key_display)
                    {
                        global.weapon_choice = key_display;
                        flicker_weapon_swap = true;
                        scr_make_sound(snd_menu_move, 1, 1, false);
                    }
                }
            }
        }
    }
}
if (shooting_charge == 0 && special_charge == 0)
{
    audio_stop_sound(snd_player_x_charge_fadeout);
}
if (machdash_hold == 0)
{
    audio_stop_sound(snd_player_x_machcharge_fadeout);
}
if (hurt == false && global.death == false && attack_action != UnknownEnum.Value_8 && player_state != UnknownEnum.Value_5 && image_alpha != 0 && (shooting_lock == false || (shooting_lock == true && movement == false)) && (global.playable_character.name != "Zero" || player_state == UnknownEnum.Value_4))
{
    if (global.input_shoot || (global.autocharge == true && global.weapon_choice == 0))
    {
        if (special_charge == 0)
        {
            shooting_charge++;
        }
    }
    else
    {
        rapid_firerate = 0;
    }
    if (global.input_special)
    {
        if (global.weapon[global.weapon_choice].charge_cost <= global.weapon[global.weapon_choice].ammo && global.x_armour_arm != 0 && shooting_charge == 0)
        {
            special_charge++;
        }
    }
    if (shooting_charge == shooting_charge_lvl_1 || special_charge == shooting_charge_lvl_1)
    {
        scr_make_sound(snd_player_x_charge_fadeout, 1, 1, false);
    }
}
if (global.death == true || image_alpha == 0 || player_state == UnknownEnum.Value_5)
{
    shooting_charge_flicker = false;
    shooting_charge = 0;
    special_charge = 0;
    audio_stop_sound(snd_player_x_charge_fadeout);
}
else
{
    if ((global.animate % 2) == 0)
    {
        if (shooting_charge_flicker == false)
        {
            shooting_charge_flicker = true;
        }
        else
        {
            shooting_charge_flicker = false;
        }
    }
    if (!global.input_shoot && (global.autocharge == false || (global.playable_character.name == "Zero" && player_state != UnknownEnum.Value_4)))
    {
        shooting_charge = 0;
    }
    if (!global.input_special && !global.input_giga)
    {
        special_charge = 0;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9
}
