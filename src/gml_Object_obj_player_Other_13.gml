shot_fired = false;
if (sprite_index == global.playable_character.action.climb_finish)
{
    exit;
}
if (global.playable_character.name == "X")
{
    ultimate_buster_check = false;
    if (ds_list_find_index(global.parts_equipped, 10) != -1)
    {
        scr_get_part_effect(10, false);
    }
    if (global.x_armour_arm == 0)
    {
        ultimate_buster_check = false;
    }
    var is_saber = false;
    var saber_check = false;
    if (!scr_current_sprite_is([spr_player_x_saber, spr_player_x_saber_jump, spr_player_x_saber_walljump, spr_player_x_saber_landing]))
    {
        saber_check = true;
    }
    event_user(6);
    switch (global.weapon[global.weapon_choice].type)
    {
        case "X-Saber":
            if (global.input_special_pressed && saber_check == true && ultimate_buster_check == false)
            {
                bullet = instance_create_layer(x, y, "Projectiles", obj_bullet_saber);
                bullet.image_xscale = image_xscale;
                bullet.damage = 6;
                bullet.melee_frames = 6;
                if (global.x_armour_arm == "Blade Arm")
                {
                    bullet.palette = 3;
                    scr_make_sound(snd_shoot_saber_x, 1, 1.1, false);
                }
                else
                {
                    scr_make_sound(snd_shoot_saber_x, 1, 1, false);
                }
                scr_player_voicelines("Weapon");
                attack_action = UnknownEnum.Value_1;
                if (wall_slide == true)
                {
                    bullet.sprite_index = spr_bullet_x_saber_wall;
                    if (global.x_armour_arm == "Blade Arm")
                    {
                        bullet.sprite_index = spr_bullet_x_saber_blade_wall;
                    }
                }
                else if (airborne == false)
                {
                    xspeed = 0;
                    dash = false;
                    attack_priority = 1;
                    bullet.sprite_index = spr_bullet_x_saber;
                    if (global.x_armour_arm == "Blade Arm")
                    {
                        bullet.sprite_index = spr_bullet_x_saber_blade;
                    }
                }
                else
                {
                    wall_jump = false;
                    bullet.sprite_index = spr_bullet_x_saber_jump;
                    if (global.x_armour_arm == "Blade Arm")
                    {
                        bullet.sprite_index = spr_bullet_x_saber_blade_jump;
                    }
                }
                with (bullet)
                {
                    if (ds_list_find_index(global.parts_equipped, 14) != -1)
                    {
                        scr_get_part_effect(14, false);
                    }
                    if (ds_list_find_index(global.parts_equipped, 3) != -1)
                    {
                        scr_get_part_effect(3, false);
                    }
                    if (ds_list_find_index(global.parts_equipped, 17) != -1)
                    {
                        scr_get_part_effect(17, "Saber");
                    }
                    if (ds_list_find_index(global.parts_equipped, 21) != -1)
                    {
                        scr_get_part_effect(21, "Saber");
                    }
                }
                shot_fired = true;
                is_saber = true;
            }
            if ((global.input_special_released || global.input_special_pressed) && saber_check == true && x_charge_saber == 0)
            {
                shooting_charged = false;
                if (special_charge > shooting_charge_lvl_2 || ultimate_buster_check == true)
                {
                    bullet = instance_create_layer(x, y, "Projectiles", obj_bullet_charged_blade);
                    bullet.image_xscale = image_xscale;
                    bullet.damage = 10;
                    bullet.melee_frames = 3;
                    alarm[0] = 25;
                    bullet.palette = 3;
                    scr_make_sound(snd_shoot_saber_x, 1, 1.1, false);
                    scr_player_voicelines("Weapon");
                    attack_action = UnknownEnum.Value_1;
                    if (airborne == true && wall_slide == false)
                    {
                        attack_priority = 3;
                        xspeed = 0;
                        yspeed = 0;
                        weight = 0;
                        x_charge_saber = 1;
                    }
                    if (wall_slide == true)
                    {
                        bullet.sprite_index = spr_bullet_x_saber_wall;
                        if (global.x_armour_arm == "Blade Arm")
                        {
                            bullet.sprite_index = spr_bullet_x_saber_blade_wall_charged;
                        }
                    }
                    else if (airborne == false)
                    {
                        xspeed = 0;
                        dash = false;
                        attack_priority = 1;
                        bullet.sprite_index = spr_bullet_x_saber;
                        if (global.x_armour_arm == "Blade Arm")
                        {
                            bullet.sprite_index = spr_bullet_x_saber_blade_charged;
                        }
                    }
                    else
                    {
                        wall_jump = false;
                        bullet.sprite_index = spr_bullet_x_saber_jump;
                        if (global.x_armour_arm == "Blade Arm")
                        {
                            bullet.sprite_index = spr_bullet_x_saber_blade_jump_charged;
                        }
                    }
                    with (bullet)
                    {
                        if (ds_list_find_index(global.parts_equipped, 14) != -1)
                        {
                            scr_get_part_effect(14, false);
                        }
                        if (ds_list_find_index(global.parts_equipped, 3) != -1)
                        {
                            scr_get_part_effect(3, false);
                        }
                        if (ds_list_find_index(global.parts_equipped, 17) != -1)
                        {
                            scr_get_part_effect(17, "Saber");
                        }
                        if (ds_list_find_index(global.parts_equipped, 21) != -1)
                        {
                            scr_get_part_effect(21, "Saber");
                        }
                    }
                    shot_fired = true;
                    is_saber = true;
                    if (ds_list_find_index(global.parts_equipped, 10) != -1)
                    {
                        scr_get_part_effect(10, "Delay");
                    }
                }
            }
            break;
        case "Yammar Option":
            if (global.input_special_pressed && global.weapon[global.weapon_choice].ammo >= global.weapon[global.weapon_choice].ammo_usage && ultimate_buster_check == false && attack_action != UnknownEnum.Value_8)
            {
                special_state = -1;
                attack_action = UnknownEnum.Value_8;
                attack_priority = 3;
                shot_fired = true;
                global.weapon[global.weapon_choice].ammo -= global.weapon[global.weapon_choice].ammo_usage;
            }
            bullet_limit_special = 2;
            if (ds_list_find_index(global.parts_equipped, 1) != -1)
            {
                scr_get_part_effect(1, "Yammar Option Charged");
            }
            with (obj_player_yammar_charged)
            {
                obj_player.bullet_limit_special--;
            }
            if ((global.input_special_released || global.input_special_pressed) && bullet_limit_special > 0 && global.weapon[global.weapon_choice].charge_cost <= global.weapon[global.weapon_choice].ammo)
            {
                shooting_charged = false;
                if (special_charge > shooting_charge_lvl_2 || ultimate_buster_check == true)
                {
                    bullet = instance_create_layer(x + shootpos_x + (5 * image_xscale * wall_slide_reverse), y + shootpos_y, "Projectiles", obj_player_yammar_charged);
                    bullet.image_xscale = image_xscale * wall_slide_reverse;
                    bullet.damage = 9;
                    scr_make_sound(snd_shoot_mid, 1, 1, false);
                    global.weapon[global.weapon_choice].ammo -= global.weapon[global.weapon_choice].charge_cost;
                    if (instance_number(obj_player_yammar_charged) > 1)
                    {
                        with (obj_player_yammar_charged)
                        {
                            offset_x = random_range(-15, 15);
                            offset_y = random_range(0, 20);
                        }
                    }
                    effect = instance_create_layer(bullet.x, bullet.y, "Explosions", obj_particle_muzzle_player);
                    effect.sprite_index = spr_effect_muzzle_x_charge_1;
                    effect.x_pos = shootpos_x;
                    effect.y_pos = shootpos_y;
                    effect.image_xscale = image_xscale * wall_slide_reverse;
                    shot_fired = true;
                    shooting_charged = true;
                    shooting_charged = UnknownEnum.Value_2;
                    shooting_lock = true;
                    alarm[0] = 15;
                    if (ds_list_find_index(global.parts_equipped, 10) != -1)
                    {
                        scr_get_part_effect(10, "Delay");
                    }
                }
            }
            break;
        case "Meteor Rain":
            if (global.input_special_pressed && global.weapon[global.weapon_choice].ammo >= global.weapon[global.weapon_choice].ammo_usage && ultimate_buster_check == false)
            {
                bullet_limit_special = 1;
                if (ds_list_find_index(global.parts_equipped, 1) != -1)
                {
                    scr_get_part_effect(1, "Meteor Rain");
                }
                with (obj_bullet_meteor_rain)
                {
                    if (villainy == 0)
                    {
                        obj_player.bullet_limit_special--;
                    }
                }
                if (bullet_limit_special > 0)
                {
                    bullet = instance_create_layer(x + shootpos_x, y + shootpos_y, "Projectiles", obj_bullet_meteor_rain);
                    bullet.damage = 3;
                    bullet.direction = 90 - (90 * image_xscale * wall_slide_reverse);
                    if (global.input_up)
                    {
                        bullet.direction = 90;
                    }
                    else if (global.input_down)
                    {
                        bullet.rise_turnspeed = 3;
                    }
                    scr_make_sound(snd_shoot_meteorrain, 1, 1, false);
                    bullet.special = true;
                    bullet.special_type = global.weapon[global.weapon_choice].type;
                    shot_fired = true;
                    attack_action = UnknownEnum.Value_6;
                    global.weapon[global.weapon_choice].ammo -= global.weapon[global.weapon_choice].ammo_usage;
                }
            }
            bullet_limit_special = 1;
            with (obj_bullet_meteor_rain_charged)
            {
                if (villainy == 0)
                {
                    obj_player.bullet_limit_special--;
                }
            }
            if ((global.input_special_released || global.input_special_pressed) && bullet_limit_special > 0 && global.weapon[global.weapon_choice].charge_cost <= global.weapon[global.weapon_choice].ammo)
            {
                shooting_charged = false;
                if (special_charge > shooting_charge_lvl_2 || ultimate_buster_check == true)
                {
                    special_state = -1;
                    attack_action = UnknownEnum.Value_8;
                    attack_priority = 3;
                    scr_player_voicelines("Charge Shot");
                    global.weapon[global.weapon_choice].ammo -= global.weapon[global.weapon_choice].charge_cost;
                    shot_fired = true;
                    shooting_charged = true;
                    shooting_lock = true;
                    alarm[0] = 15;
                    if (ds_list_find_index(global.parts_equipped, 10) != -1)
                    {
                        scr_get_part_effect(10, "Delay");
                    }
                }
            }
            break;
        case "Magma Blade":
            if (crouch == false)
            {
                if (global.input_special_pressed && saber_check == true && global.weapon[global.weapon_choice].ammo >= global.weapon[global.weapon_choice].ammo_usage && ultimate_buster_check == false)
                {
                    bullet_limit_special = 2;
                    if (ds_list_find_index(global.parts_equipped, 1) != -1)
                    {
                        scr_get_part_effect(1, "Magma Blade");
                    }
                    with (obj_bullet_default)
                    {
                        if (villainy == 0 && (sprite_index == spr_bullet_magmablade || sprite_index == spr_bullet_magmablade_spawn))
                        {
                            obj_player.bullet_limit_special--;
                        }
                    }
                    if (bullet_limit_special > 0)
                    {
                        bullet = instance_create_layer(x, y, "Projectiles", obj_bullet_saber);
                        bullet.image_xscale = image_xscale;
                        bullet.damage = 4;
                        bullet.melee_frames = 6;
                        bullet.special = true;
                        bullet.special_type = global.weapon[global.weapon_choice].type;
                        scr_player_voicelines("Weapon");
                        attack_action = UnknownEnum.Value_1;
                        if (airborne == true && wall_slide == false)
                        {
                            attack_priority = 3;
                            xspeed = 0;
                            yspeed = 0;
                            weight = 0;
                        }
                        if (wall_slide == true)
                        {
                            bullet.sprite_index = spr_bullet_x_saber_fire_wall;
                        }
                        else if (airborne == false)
                        {
                            attack_priority = 1;
                            bullet.sprite_index = spr_bullet_x_saber_fire;
                            xspeed = 0;
                            dash = false;
                        }
                        else
                        {
                            wall_jump = false;
                            bullet.sprite_index = spr_bullet_x_saber_fire_jump;
                        }
                        bullet.image_speed = 0.75;
                        bullet.palette_sprite = spr_bullet_saber_fire_palette;
                        if (underwater == true)
                        {
                            bullet.palette = 1;
                            bullet.image_alpha = 0.65;
                            scr_make_sound(snd_shoot_magmablade, 1, 0.5, false);
                        }
                        else
                        {
                            scr_make_sound(snd_shoot_magmablade, 1, 1, false);
                        }
                        global.weapon[global.weapon_choice].ammo -= global.weapon[global.weapon_choice].ammo_usage;
                        shot_fired = true;
                    }
                }
                if ((global.input_special_released || global.input_special_pressed) && global.weapon[global.weapon_choice].charge_cost <= global.weapon[global.weapon_choice].ammo && saber_check == true)
                {
                    shooting_charged = false;
                    if (special_charge > shooting_charge_lvl_2 || ultimate_buster_check == true)
                    {
                        bullet = instance_create_layer(x, y, "Projectiles", obj_bullet_saber);
                        bullet.image_xscale = image_xscale;
                        bullet.damage = 5;
                        bullet.melee_frames = 6;
                        bullet.special = true;
                        bullet.special_type = global.weapon[global.weapon_choice].type;
                        scr_player_voicelines("Weapon");
                        attack_action = UnknownEnum.Value_1;
                        if (airborne == true && wall_slide == false)
                        {
                            attack_priority = 3;
                            xspeed = 0;
                            yspeed = 0;
                            weight = 0;
                        }
                        if (wall_slide == true)
                        {
                            bullet.sprite_index = spr_bullet_x_saber_fire_wall;
                        }
                        else if (airborne == false)
                        {
                            attack_priority = 1;
                            bullet.sprite_index = spr_bullet_x_saber_fire;
                            xspeed = 0;
                            dash = false;
                        }
                        else
                        {
                            wall_jump = false;
                            bullet.sprite_index = spr_bullet_x_saber_fire_jump;
                        }
                        bullet.image_speed = 0.75;
                        bullet.palette_sprite = spr_bullet_saber_fire_palette;
                        bullet.palette = 3;
                        if (underwater == true)
                        {
                            bullet.palette = 1;
                            bullet.image_alpha = 0.65;
                            scr_make_sound(snd_shoot_magmablade, 1, 0.5, false);
                        }
                        else
                        {
                            scr_make_sound(snd_heatnix_screech, 1, 1, false);
                            scr_make_sound(snd_heatnix_flare, 1, 1, false);
                        }
                        global.weapon[global.weapon_choice].ammo -= global.weapon[global.weapon_choice].charge_cost;
                        shot_fired = true;
                        shooting_charged = true;
                        shooting_charged = UnknownEnum.Value_2;
                        shooting_lock = true;
                        alarm[0] = 15;
                        if (ds_list_find_index(global.parts_equipped, 10) != -1)
                        {
                            scr_get_part_effect(10, "Delay");
                        }
                    }
                }
            }
            break;
        case "Ray Arrow":
            if (global.input_special_pressed && global.weapon[global.weapon_choice].ammo >= global.weapon[global.weapon_choice].ammo_usage && ultimate_buster_check == false)
            {
                bullet_limit_special = 3;
                if (ds_list_find_index(global.parts_equipped, 1) != -1)
                {
                    scr_get_part_effect(1, "Ray Arrow");
                }
                with (obj_bullet_rayarrow)
                {
                    if (villainy == 0)
                    {
                        obj_player.bullet_limit_special--;
                    }
                }
                if (bullet_limit_special > 0)
                {
                    bullet = instance_create_layer(x + shootpos_x, y + shootpos_y, "Projectiles", obj_bullet_rayarrow);
                    bullet.image_xscale = image_xscale * wall_slide_reverse;
                    bullet.speed = 12 * bullet.image_xscale;
                    bullet.sprite_index = spr_bullet_rayarrow;
                    bullet.damage = 4;
                    bullet.special = true;
                    bullet.special_type = global.weapon[global.weapon_choice].type;
                    shot_fired = true;
                    global.weapon[global.weapon_choice].ammo -= global.weapon[global.weapon_choice].ammo_usage;
                    scr_make_sound(snd_illumina_stars, 1, 1, false);
                    effect = instance_create_layer(bullet.x, bullet.y, "Explosions", obj_particle_muzzle_player);
                    effect.sprite_index = spr_effect_muzzle_rayarrow;
                    effect.x_pos = shootpos_x;
                    effect.y_pos = shootpos_y;
                    effect.image_xscale = image_xscale * wall_slide_reverse;
                    attack_action = UnknownEnum.Value_6;
                    if (sprite_index == spr_player_x_idle_shoot_charge)
                    {
                        sprite_index = spr_player_x_idle_shoot;
                    }
                    else if (sprite_index == spr_player_x_crouch_shot_charged)
                    {
                        sprite_index = spr_player_x_crouch_shooting;
                    }
                }
            }
            if ((global.input_special_released || global.input_special_pressed) && global.weapon[global.weapon_choice].charge_cost <= global.weapon[global.weapon_choice].ammo)
            {
                shooting_charged = false;
                if (special_charge > shooting_charge_lvl_2 || ultimate_buster_check == true)
                {
                    for (var i = 0; i < 3; i++)
                    {
                        bullet = instance_create_layer(x + shootpos_x + (10 * image_xscale * wall_slide_reverse), y + shootpos_y, "Projectiles", obj_bullet_rayarrow_charged);
                        bullet.shoot_direction = 90 - (90 * image_xscale * wall_slide_reverse);
                        bullet.speed = 0.5 * image_xscale * wall_slide_reverse;
                        bullet.damage = 6;
                        bullet.special = true;
                        bullet.special_type = global.weapon[global.weapon_choice].type;
                        bullet.passive = true;
                        switch (i)
                        {
                            case 0:
                                bullet.direction = 0;
                                with (bullet)
                                {
                                    alarm[0] = 35;
                                }
                                break;
                                break;
                            case 1:
                                bullet.direction = 110;
                                with (bullet)
                                {
                                    alarm[0] = 45;
                                }
                                break;
                                break;
                            case 2:
                                bullet.direction = 290;
                                with (bullet)
                                {
                                    alarm[0] = 55;
                                }
                                break;
                                break;
                        }
                    }
                    scr_make_sound(snd_mijinion_bubbles, 1, 1, false);
                    global.weapon[global.weapon_choice].ammo -= global.weapon[global.weapon_choice].charge_cost;
                    effect = instance_create_layer(bullet.x, bullet.y, "Explosions", obj_particle_muzzle_player);
                    effect.sprite_index = spr_effect_muzzle_rayarrow;
                    effect.x_pos = shootpos_x;
                    effect.y_pos = shootpos_y;
                    effect.image_xscale = image_xscale * wall_slide_reverse;
                    shot_fired = true;
                    shooting_charged = true;
                    shooting_charged = UnknownEnum.Value_2;
                    shooting_lock = true;
                    alarm[0] = 15;
                    if (ds_list_find_index(global.parts_equipped, 10) != -1)
                    {
                        scr_get_part_effect(10, "Delay");
                    }
                }
            }
            break;
        case "Rising Fire":
            if (global.input_special_pressed && global.weapon[global.weapon_choice].ammo >= global.weapon[global.weapon_choice].ammo_usage && ultimate_buster_check == false)
            {
                bullet_limit_special = 1;
                if (ds_list_find_index(global.parts_equipped, 1) != -1)
                {
                    scr_get_part_effect(1, "Rising Fire");
                }
                with (obj_bullet_default)
                {
                    if (villainy == 0)
                    {
                        obj_player.bullet_limit_special--;
                    }
                }
                if (bullet_limit_special > 0)
                {
                    bullet = instance_create_layer(x, y, "Projectiles", obj_bullet_default);
                    bullet.special = true;
                    bullet.special_type = global.weapon[global.weapon_choice].type;
                    bullet.direction = 90;
                    bullet.speed = 5;
                    bullet.damage = 15;
                    bullet.sprite_index = spr_effect_rising_fire;
                    bullet.phasing = true;
                    bullet.afterimage_toggle = true;
                    bullet.afterimage_blend = 255;
                    bullet.afterimage_fade = 0.125;
                    scr_make_sound(snd_nightmarezero_buster, 1, 1, false);
                    scr_make_sound(snd_dragoon_flames, 1, 1, false);
                    effect = instance_create_layer(bullet.x, bullet.y, "Explosions", obj_explosion);
                    effect.sprite_index = spr_bullet_rising_fire_giga_effect;
                    attack_action = UnknownEnum.Value_8;
                    scr_make_sound(snd_x_rising_fire, 1, 1, false);
                    global.weapon[global.weapon_choice].ammo -= global.weapon[global.weapon_choice].ammo_usage;
                    shot_fired = true;
                }
            }
            bullet_limit_special = 1;
            with (obj_bullet_dragoon_shoryuken_movable)
            {
                if (villainy == 0)
                {
                    obj_player.bullet_limit_special--;
                }
            }
            if ((global.input_special_released || global.input_special_pressed) && bullet_limit_special > 0 && global.weapon[global.weapon_choice].charge_cost <= global.weapon[global.weapon_choice].ammo)
            {
                shooting_charged = false;
                if (special_charge > shooting_charge_lvl_2 || ultimate_buster_check == true)
                {
                    attack_action = UnknownEnum.Value_8;
                    attack_priority = 1;
                    scr_make_sound(snd_x_x5_boss_charge_attack, 1, 1, false);
                    scr_make_sound(snd_dragoon_flames, 1, 1, false);
                    global.weapon[global.weapon_choice].ammo -= global.weapon[global.weapon_choice].charge_cost;
                    shot_fired = true;
                    shooting_charged = true;
                    x_rising_shoryuken = 1;
                    invul = true;
                    alarm[0] = 15;
                    if (ds_list_find_index(global.parts_equipped, 10) != -1)
                    {
                        scr_get_part_effect(10, "Delay");
                    }
                }
            }
            break;
    }
    if (shot_fired == true)
    {
        shooting_charge_flicker = false;
        special_charge = 0;
        shooting = 15;
        if (is_saber == true)
        {
            shooting = 1;
        }
        if (global.weapon[global.weapon_choice].type != "Yammar Option")
        {
            with (obj_player_yammar)
            {
                event_user(10);
            }
        }
    }
}
else if (global.playable_character.name == "Zero")
{
    ultimate_buster_check = false;
    if (ds_list_find_index(global.parts_equipped, 9) != -1)
    {
        buster_plus_enabled = 1;
    }
    if (ds_list_find_index(global.parts_equipped, 10) != -1)
    {
        scr_get_part_effect(10, false);
    }
    if (ds_list_find_index(global.parts_equipped, 100) != -1)
    {
        scr_get_part_effect(100, false);
    }
    if (ds_list_find_index(global.parts_equipped, 101) != -1)
    {
        scr_get_part_effect(101, false);
    }
    if ((attack_action == UnknownEnum.Value_0 || attack_action == UnknownEnum.Value_5 || attack_action == UnknownEnum.Value_4) && wall_slide == false && shooting_charge == 0)
    {
        var special_check = false;
        var charging = false;
        if (player_state == UnknownEnum.Value_0)
        {
            if ((global.input_special || global.input_special_released) && global.input_down && (global.weapon[6].type != 0 && ds_list_find_index(global.weapon_disable_list, 6) == -1) && airborne == false)
            {
                bullet_limit_special = 1;
                if (ds_list_find_index(global.parts_equipped, 1) != -1)
                {
                    scr_get_part_effect(1, "Meteor Rain");
                }
                with (obj_bullet_ensuizan)
                {
                    obj_player.bullet_limit_special--;
                }
                if (zero_technique == 0 || zero_technique == "Ensuizan")
                {
                    if (global.weapon[6].ammo >= global.weapon[6].ammo_usage && bullet_limit_special > 0)
                    {
                        charging = true;
                    }
                    zero_technique = "Ensuizan";
                    if (global.input_special_released)
                    {
                        special_check = zero_technique;
                    }
                }
            }
            else if (((global.input_giga || global.input_giga_released) && global.input_up && (global.weapon[9].type != 0 && ds_list_find_index(global.weapon_disable_list, 9) == -1) && global.weapon[9].ammo >= global.weapon[9].ammo_usage && zero_ryuenjin == 0) || ((global.input_giga || global.input_giga_released) && global.input_down && (global.weapon[9].type != 0 && ds_list_find_index(global.weapon_disable_list, 9) == -1) && global.weapon[9].ammo >= global.weapon[9].ammo_usage && kongou_kokuretsu > 0))
            {
                special_check = "Ryuenjin";
            }
            else if ((global.input_giga || global.input_giga_released) && (global.weapon[8].type != 0 && ds_list_find_index(global.weapon_disable_list, 8) == -1) && airborne == false && global.weapon[8].ammo >= global.weapon[8].ammo_usage)
            {
                if (zero_technique == 0 || zero_technique == "Rekkoha")
                {
                    if (global.weapon[8].ammo >= global.weapon[8].charge_cost)
                    {
                        charging = true;
                    }
                    zero_technique = "Rekkoha";
                    if (global.input_giga_released)
                    {
                        special_check = zero_technique;
                    }
                    if (ultimate_buster_check == true && global.weapon[8].ammo < global.weapon[8].charge_cost)
                    {
                        special_check = false;
                        charging = false;
                    }
                }
            }
            else if (global.input_special_pressed && super_buster == 0)
            {
                special_check = "Z-Buster";
                attack_priority = 0;
            }
            else if (global.input_special_pressed && super_buster > 0 && buster_plus_enabled == 0)
            {
                special_check = "Z-Super Buster";
                attack_priority = 0;
            }
            else if (global.input_special_pressed && super_buster > 0 && buster_plus_enabled > 0)
            {
                special_check = "Z-Ring Buster";
                attack_priority = 0;
            }
        }
        else if (global.input_special_pressed && super_buster == 0)
        {
            special_check = "Z-Buster";
            attack_priority = 0;
        }
        else if (global.input_special_pressed && super_buster > 0 && buster_plus_enabled == 0)
        {
            special_check = "Z-Super Buster";
            attack_priority = 0;
        }
        else if (global.input_special_pressed && super_buster > 0 && buster_plus_enabled > 0)
        {
            special_check = "Z-Ring Buster";
            attack_priority = 0;
        }
        if (charging == true)
        {
            attack_priority = 1;
            attack_action = UnknownEnum.Value_4;
            dash = false;
            if (hurt == false)
            {
                xspeed = 0;
            }
            special_charge += 2;
            if (special_charge == shooting_charge_lvl_1)
            {
                scr_make_sound(snd_player_x_charge_fadeout, 1, 1.5, false);
            }
        }
        else
        {
            special_charge = 0;
        }
        if (special_check != false)
        {
            switch (special_check)
            {
                case "Rekkoha":
                    attack_action = UnknownEnum.Value_9;
                    dash = false;
                    if (hurt == false)
                    {
                        xspeed = 0;
                    }
                    zero_attack = true;
                    attack_priority = 1;
                    global.weapon_choice = 8;
                    if (special_charge >= shooting_charge_lvl_2 || (ultimate_buster_check == true && special_charge > 0))
                    {
                        scr_make_sound(snd_player_zero_talk_special_2, 1, 1, false);
                        change_sprite(spr_manager, spr_player_zero_giga_charged, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        global.weapon[8].ammo -= global.weapon[8].charge_cost;
                    }
                    else if (ultimate_buster_check == false)
                    {
                        scr_make_sound(snd_player_zero_talk_special_3, 1, 1, false);
                        change_sprite(spr_manager, spr_player_zero_giga, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        global.weapon[8].ammo -= global.weapon[8].ammo_usage;
                    }
                    break;
                case "Ensuizan":
                    if (hurt == false)
                    {
                        xspeed = 0;
                    }
                    attack_action = UnknownEnum.Value_9;
                    attack_priority = 1;
                    if (special_charge >= shooting_charge_lvl_2 || (ultimate_buster_check == true && special_charge > 0))
                    {
                        zero_attack = true;
                        scr_make_sound(snd_player_zero_talk_special, 1, 1, false);
                        global.weapon_choice = 6;
                        global.weapon[6].ammo -= global.weapon[6].ammo_usage;
                        change_sprite(spr_manager, spr_player_zero_ensuizan_charged, UnknownEnum.Value_0, UnknownEnum.Value_1);
                    }
                    else if (ultimate_buster_check == false)
                    {
                        bullet = instance_create_layer(x, y, "Projectiles", obj_bullet_saber);
                        bullet.image_xscale = image_xscale;
                        scr_make_sound(snd_shoot_saber_zero, 1, 0.9, false);
                        scr_make_sound(snd_splash, 1, 1, false);
                        scr_make_sound(snd_player_zero_talk_slash_3, 1, 1, false);
                        bullet.damage = 6;
                        bullet.melee_frames = 2;
                        bullet.sprite_index = spr_bullet_zero_saber_ensuizan;
                        bullet.special = true;
                        bullet.special_type = "Meteor Rain";
                        change_sprite(spr_manager, spr_player_zero_saber_ensuizan, UnknownEnum.Value_0, UnknownEnum.Value_1);
                    }
                    break;
                case "Z-Buster":
                    bullet_limit_special = 1;
                    if (ds_list_find_index(global.parts_equipped, 1) != -1)
                    {
                        scr_get_part_effect(1, "Meteor Rain");
                    }
                    with (obj_bullet_default)
                    {
                        if (sprite_index == spr_bullet_player_zero || sprite_index == spr_bullet_player_zero_plus)
                        {
                            obj_player.bullet_limit_special--;
                        }
                    }
                    if (bullet_limit_special > 0)
                    {
                        attack_action = UnknownEnum.Value_3;
                        zero_attack = true;
                        if (player_state == UnknownEnum.Value_1)
                        {
                            attack_priority = 1;
                            change_sprite(spr_manager, spr_player_zero_buster_climb, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else if (airborne == true)
                        {
                            change_sprite(spr_manager, spr_player_zero_buster_airborne, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else if (dash == true)
                        {
                            change_sprite(spr_manager, spr_player_zero_dash_buster, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else if (dash == true && airborne == true && airdash_point > 0 && global.input_dash)
                        {
                            change_sprite(spr_manager, spr_player_zero_dash_buster_airdash, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else
                        {
                            change_sprite(spr_manager, spr_player_zero_buster, UnknownEnum.Value_0, UnknownEnum.Value_1);
                            crouch = false;
                            dash = false;
                            xspeed = 0;
                            attack_priority = 1;
                        }
                    }
                    break;
                case "Z-Super Buster":
                    bullet_limit_special = 1;
                    if (ds_list_find_index(global.parts_equipped, 1) != -1)
                    {
                        scr_get_part_effect(1, "Meteor Rain");
                    }
                    with (obj_bullet_default)
                    {
                        if (sprite_index == spr_bullet_nightmarezero_buster)
                        {
                            obj_player.bullet_limit_special--;
                        }
                    }
                    if (bullet_limit_special > 0)
                    {
                        attack_action = UnknownEnum.Value_3;
                        zero_attack = true;
                        if (player_state == UnknownEnum.Value_1)
                        {
                            attack_priority = 1;
                            change_sprite(spr_manager, spr_player_zero_buster_climb, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else if (airborne == true)
                        {
                            change_sprite(spr_manager, spr_player_zero_buster_airborne, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else if (dash == true)
                        {
                            change_sprite(spr_manager, spr_player_zero_dash_buster, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else if (dash == true && airborne == true && airdash_point > 0 && global.input_dash)
                        {
                            change_sprite(spr_manager, spr_player_zero_dash_buster_airdash, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else
                        {
                            change_sprite(spr_manager, spr_player_zero_x6_buster_stand, UnknownEnum.Value_0, UnknownEnum.Value_1);
                            crouch = false;
                            dash = false;
                            xspeed = 0;
                            attack_priority = 1;
                        }
                    }
                    break;
                case "Z-Ring Buster":
                    bullet_limit_special = 2;
                    if (ds_list_find_index(global.parts_equipped, 1) != -1)
                    {
                        scr_get_part_effect(1, "Meteor Rain");
                    }
                    if (ds_list_find_index(global.parts_equipped, 4) != -1)
                    {
                        bullet_limit_special = 4;
                    }
                    with (obj_bullet_default)
                    {
                        if (sprite_index == spr_awakenedzero_ring_shoot)
                        {
                            obj_player.bullet_limit_special--;
                        }
                    }
                    if (bullet_limit_special > 0)
                    {
                        attack_action = UnknownEnum.Value_3;
                        zero_attack = true;
                        if (player_state == UnknownEnum.Value_1)
                        {
                            attack_priority = 1;
                            change_sprite(spr_manager, spr_player_zero_buster_climb, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else if (airborne == true)
                        {
                            change_sprite(spr_manager, spr_player_zero_buster_airborne, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else if (dash == true)
                        {
                            change_sprite(spr_manager, spr_player_zero_dash_buster, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else if (dash == true && airborne == true && airdash_point > 0 && global.input_dash)
                        {
                            change_sprite(spr_manager, spr_player_zero_dash_buster_airdash, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        }
                        else
                        {
                            change_sprite(spr_manager, spr_player_zero_x6_buster_stand, UnknownEnum.Value_0, UnknownEnum.Value_1);
                            crouch = false;
                            dash = false;
                            xspeed = 0;
                            attack_priority = 1;
                        }
                    }
                    break;
                case "Ryuenjin":
                    attack_action = UnknownEnum.Value_9;
                    attack_priority = 2;
                    zero_attack = true;
                    zero_ryuenjin = 1;
                    if (hurt == false)
                    {
                        xspeed = 0;
                    }
                    if (global.input_up)
                    {
                        scr_make_sound(snd_dragoon_flames, 1, 1, false);
                        change_sprite(spr_manager, spr_player_zero_ryuenjin, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        scr_make_sound(snd_player_zero_talk_special_2, 1, 1, false);
                        attack_action = UnknownEnum.Value_9;
                        global.weapon_choice = 9;
                        global.weapon[9].ammo -= global.weapon[9].ammo_usage;
                    }
                    if (global.input_down && kongou_kokuretsu > 0 && global.weapon[9].ammo > 12)
                    {
                        scr_make_sound(snd_player_zero_talk_special_3, 1, 1, false);
                        change_sprite(spr_manager, spr_player_zero_fire_giga, UnknownEnum.Value_0, UnknownEnum.Value_1);
                        global.weapon_choice = 9;
                        global.weapon[9].ammo -= 12;
                        attack_action = UnknownEnum.Value_9;
                        attack_priority = 1;
                        zero_attack = true;
                    }
                    break;
            }
        }
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
    Value_8 = 8,
    Value_9
}
