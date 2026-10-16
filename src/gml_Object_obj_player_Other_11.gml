shot_fired = false;
if (sprite_index == global.playable_character.action.climb_finish)
{
    exit;
}
if (player_state != UnknownEnum.Value_5)
{
    if (global.playable_character.name == "X" || player_state == UnknownEnum.Value_4)
    {
        ultimate_buster_check = false;
        if (ds_list_find_index(global.parts_equipped, 10) != -1)
        {
            scr_get_part_effect(10, false);
        }
        split_amount = 1;
        split_amount_count = 0;
        if (ds_list_find_index(global.parts_equipped, 4) != -1)
        {
            scr_get_part_effect(4, "Amount");
        }
        event_user(6);
        if ((global.input_shoot_released || global.input_shoot_pressed) && (shooting_charge > shooting_charge_lvl_1 || ultimate_buster_check == true))
        {
            shooting_charged = false;
            if (ds_list_find_index(global.parts_equipped, 102) != -1)
            {
                scr_get_part_effect(102, false);
            }
            if (shooting_charge > shooting_charge_lvl_2 || ultimate_buster_check == true)
            {
                var chargeshot_type = global.x_armour_arm;
                if (player_state == UnknownEnum.Value_4)
                {
                    chargeshot_type = 0;
                }
                switch (chargeshot_type)
                {
                    case "Blade Arm":
                        if (plasma_shot == 0)
                        {
                            bullet = instance_create_layer(x + shootpos_x + (5 * image_xscale * wall_slide_reverse), y + shootpos_y, "Projectiles", obj_bullet_bladeshot);
                            bullet.image_xscale = image_xscale * wall_slide_reverse;
                            bullet.speed = 10 * bullet.image_xscale;
                            bullet.sprite_index = spr_bullet_blade_spawn;
                            bullet.animation_next = spr_bullet_blade;
                            bullet.explosion = spr_explosion_player_blade;
                            bullet.damage = 16;
                            bullet.explosion_sound = snd_explosion_bullet;
                            scr_make_sound(snd_shoot_large, 1, 1, false);
                            scr_player_voicelines("Charge Shot");
                            with (bullet)
                            {
                                if (ds_list_find_index(global.parts_equipped, 7) != -1)
                                {
                                    scr_get_part_effect(7, false);
                                }
                                if (ds_list_find_index(global.parts_equipped, 9) != -1)
                                {
                                    scr_get_part_effect(9, false);
                                }
                                if (ds_list_find_index(global.parts_equipped, 17) != -1)
                                {
                                    scr_get_part_effect(17, "Buster");
                                }
                                if (ds_list_find_index(global.parts_equipped, 21) != -1)
                                {
                                    scr_get_part_effect(21, "Buster");
                                }
                            }
                            for (var i = 0; i < 2; i++)
                            {
                                effect = instance_create_layer(bullet.x, bullet.y, "Explosions", obj_particle_muzzle_player);
                                effect.sprite_index = spr_effect_muzzle_x_charge_2;
                                if (i == 0)
                                {
                                    effect.sprite_index = spr_effect_muzzle_x_charge_2_back;
                                    effect.depth = obj_player.depth + 10;
                                }
                                effect.x_pos = shootpos_x;
                                effect.y_pos = shootpos_y;
                                effect.image_xscale = image_xscale * wall_slide_reverse;
                                effect.image_alpha = bullet.image_alpha;
                            }
                        }
                        if (plasma_shot > 0)
                        {
                            bullet = instance_create_layer(x + shootpos_x + (5 * image_xscale * wall_slide_reverse), y + shootpos_y, "Projectiles", obj_bullet_plasmashot);
                            bullet.image_xscale = image_xscale * wall_slide_reverse;
                            bullet.speed = 10 * bullet.image_xscale;
                            bullet.sprite_index = spr_bullet_blade_spawn;
                            bullet.animation_next = spr_bullet_ultimate_plasma_shot;
                            bullet.explosion = spr_explosion_player_blade;
                            bullet.damage = 18;
                            bullet.explosion_sound = snd_explosion_bullet;
                            scr_make_sound(snd_shoot_large, 1, 1, false);
                            scr_player_voicelines("Charge Shot");
                            with (bullet)
                            {
                                if (ds_list_find_index(global.parts_equipped, 7) != -1)
                                {
                                    scr_get_part_effect(7, false);
                                }
                                if (ds_list_find_index(global.parts_equipped, 9) != -1)
                                {
                                    scr_get_part_effect(9, false);
                                }
                                if (ds_list_find_index(global.parts_equipped, 17) != -1)
                                {
                                    scr_get_part_effect(17, "Buster");
                                }
                                if (ds_list_find_index(global.parts_equipped, 21) != -1)
                                {
                                    scr_get_part_effect(21, "Buster");
                                }
                            }
                            for (var i = 0; i < 2; i++)
                            {
                                effect = instance_create_layer(bullet.x, bullet.y, "Explosions", obj_particle_muzzle_player);
                                effect.sprite_index = spr_effect_muzzle_x_charge_2;
                                if (i == 0)
                                {
                                    effect.sprite_index = spr_effect_muzzle_x_charge_2_back;
                                    effect.depth = obj_player.depth + 10;
                                }
                                effect.x_pos = shootpos_x;
                                effect.y_pos = shootpos_y;
                                effect.image_xscale = image_xscale * wall_slide_reverse;
                                effect.image_alpha = bullet.image_alpha;
                            }
                        }
                        break;
                    default:
                        bullet = instance_create_layer(x + shootpos_x + (5 * image_xscale * wall_slide_reverse), y + shootpos_y, "Projectiles", obj_bullet_charged);
                        bullet.image_xscale = image_xscale * wall_slide_reverse;
                        bullet.speed = 10 * bullet.image_xscale;
                        bullet.sprite_index = spr_bullet_player_charge_2_spawn;
                        bullet.animation_next = spr_bullet_player_charge_2;
                        bullet.explosion = spr_explosion_player_charge;
                        bullet.damage = 15;
                        bullet.explosion_sound = snd_explosion_bullet;
                        if (player_state == UnknownEnum.Value_4)
                        {
                            scr_make_sound(snd_bike_shoot_charge, 1, 1, false);
                        }
                        else
                        {
                            scr_make_sound(snd_shoot_large, 1, 1, false);
                        }
                        scr_player_voicelines("Charge Shot");
                        with (bullet)
                        {
                            if (ds_list_find_index(global.parts_equipped, 7) != -1)
                            {
                                scr_get_part_effect(7, false);
                            }
                            if (ds_list_find_index(global.parts_equipped, 9) != -1)
                            {
                                scr_get_part_effect(9, false);
                            }
                            if (ds_list_find_index(global.parts_equipped, 17) != -1)
                            {
                                scr_get_part_effect(17, "Buster");
                            }
                            if (ds_list_find_index(global.parts_equipped, 21) != -1)
                            {
                                scr_get_part_effect(21, "Buster");
                            }
                        }
                        for (var i = 0; i < 2; i++)
                        {
                            effect = instance_create_layer(bullet.x, bullet.y, "Explosions", obj_particle_muzzle_player);
                            effect.sprite_index = spr_effect_muzzle_x_charge_2;
                            if (i == 0)
                            {
                                effect.sprite_index = spr_effect_muzzle_x_charge_2_back;
                                effect.depth = obj_player.depth + 10;
                            }
                            effect.x_pos = shootpos_x;
                            effect.y_pos = shootpos_y;
                            effect.image_xscale = image_xscale * wall_slide_reverse;
                            effect.image_alpha = bullet.image_alpha;
                        }
                        break;
                }
                shot_fired = true;
                shooting_charged = true;
                shooting_charged = UnknownEnum.Value_2;
                shooting_lock = true;
                alarm[0] = 15;
                if (ds_list_find_index(global.parts_equipped, 10) != -1)
                {
                    scr_get_part_effect(10, "Delay");
                }
                if (player_state == UnknownEnum.Value_4)
                {
                    bullet.phasing = true;
                    bullet.image_xscale = 1;
                    bullet.sprite_index = spr_bullet_bike_charge_spawn;
                    bullet.animation_next = spr_bullet_bike_charge;
                    if (image_xscale == -1)
                    {
                        bullet.speed *= -1;
                    }
                    effect.image_xscale = 1;
                }
            }
            else if (shooting_charge > shooting_charge_lvl_1)
            {
                bullet = instance_create_layer(x + shootpos_x, y + shootpos_y, "Projectiles", obj_bullet_charged);
                bullet.image_xscale = image_xscale * wall_slide_reverse;
                bullet.speed = 8 * bullet.image_xscale;
                bullet.sprite_index = spr_bullet_player_charge_1;
                bullet.damage = 7;
                bullet.explosion_sound = snd_explosion_bullet;
                scr_make_sound(snd_shoot_mid, 1, 1, false);
                with (bullet)
                {
                    if (ds_list_find_index(global.parts_equipped, 7) != -1)
                    {
                        scr_get_part_effect(7, false);
                    }
                    if (ds_list_find_index(global.parts_equipped, 9) != -1)
                    {
                        scr_get_part_effect(9, false);
                    }
                    if (ds_list_find_index(global.parts_equipped, 17) != -1)
                    {
                        scr_get_part_effect(17, "Buster");
                    }
                    if (ds_list_find_index(global.parts_equipped, 21) != -1)
                    {
                        scr_get_part_effect(21, "Buster");
                    }
                }
                effect = instance_create_layer(bullet.x, bullet.y, "Explosions", obj_particle_muzzle_player);
                effect.sprite_index = spr_effect_muzzle_x_charge_1;
                effect.x_pos = shootpos_x;
                effect.y_pos = shootpos_y;
                effect.image_xscale = image_xscale * wall_slide_reverse;
                effect.image_alpha = bullet.image_alpha;
                shot_fired = true;
                shooting_charged = UnknownEnum.Value_1;
                shooting_lock = true;
                alarm[0] = 15;
                if (player_state == UnknownEnum.Value_4)
                {
                    bullet.phasing = true;
                    bullet.image_xscale = 1;
                    bullet.sprite_index = spr_bullet_bike_charge_mid;
                    if (image_xscale == -1)
                    {
                        bullet.speed *= -1;
                    }
                    effect.image_xscale = 1;
                    effect.sprite_index = spr_effect_muzzle_bike_charge;
                }
            }
        }
        else if ((global.input_shoot_pressed || (global.rapidfire == true && global.input_shoot && (rapid_firerate % 6) == 0)) && ultimate_buster_check == false)
        {
            bullet_limit = 3;
            if (ds_list_find_index(global.parts_equipped, 1) != -1)
            {
                scr_get_part_effect(1, "X-Buster");
            }
            with (obj_bullet_default)
            {
                if (sprite_index == spr_bullet_player_lemon || sprite_index == spr_bullet_bike || sprite_index == spr_bullet_player_lemon_plus)
                {
                    obj_player.bullet_limit--;
                }
            }
            if (bullet_limit > 0)
            {
                for (split_amount_count = 0; split_amount_count < split_amount; split_amount_count++)
                {
                    bullet = instance_create_layer(x + shootpos_x, y + shootpos_y, "Projectiles", obj_bullet_default);
                    bullet.image_xscale = image_xscale * wall_slide_reverse;
                    bullet.speed = 8 * bullet.image_xscale;
                    bullet.sprite_index = spr_bullet_player_lemon;
                    bullet.palette_type = spr_bullet_x_palette;
                    bullet.damage = 3;
                    with (bullet)
                    {
                        if (ds_list_find_index(global.parts_equipped, 19) != -1)
                        {
                            scr_get_part_effect(19, false);
                        }
                        if (ds_list_find_index(global.parts_equipped, 1) != -1)
                        {
                            scr_get_part_effect(1, "Set Colour");
                        }
                        if (ds_list_find_index(global.parts_equipped, 7) != -1)
                        {
                            scr_get_part_effect(7, false);
                        }
                        if (ds_list_find_index(global.parts_equipped, 9) != -1)
                        {
                            scr_get_part_effect(9, false);
                        }
                        if (ds_list_find_index(global.parts_equipped, 17) != -1)
                        {
                            scr_get_part_effect(17, "Buster");
                        }
                        if (ds_list_find_index(global.parts_equipped, 21) != -1)
                        {
                            scr_get_part_effect(21, "Buster");
                        }
                    }
                    if (ds_list_find_index(global.parts_equipped, 4) != -1)
                    {
                        scr_get_part_effect(4, 0);
                    }
                    bullet.explosion_sound = snd_explosion_bullet;
                    if (player_state == UnknownEnum.Value_4)
                    {
                        bullet.phasing = true;
                        bullet.image_xscale = 1;
                        bullet.sprite_index = spr_bullet_bike;
                        if (image_xscale == -1)
                        {
                            bullet.speed *= -1;
                        }
                    }
                }
                if (player_state == UnknownEnum.Value_4)
                {
                    scr_make_sound(snd_bike_shoot, 1, 1, false);
                }
                else
                {
                    scr_make_sound(snd_shoot_small, 1, 1, false);
                }
                effect = instance_create_layer(bullet.x, bullet.y, "Explosions", obj_particle_muzzle_player);
                effect.sprite_index = spr_effect_muzzle_x;
                effect.x_pos = shootpos_x;
                effect.y_pos = shootpos_y;
                effect.image_xscale = image_xscale * wall_slide_reverse;
                effect.image_alpha = bullet.image_alpha;
                with (effect)
                {
                    if (ds_list_find_index(global.parts_equipped, 19) != -1)
                    {
                        scr_get_part_effect(19, false);
                    }
                    if (ds_list_find_index(global.parts_equipped, 1) != -1)
                    {
                        scr_get_part_effect(1, "Set Colour");
                    }
                    if (ds_list_find_index(global.parts_equipped, 17) != -1)
                    {
                        scr_get_part_effect(17, "Set Colour");
                    }
                }
                if (player_state == UnknownEnum.Value_4)
                {
                    effect.image_xscale = 1;
                    effect.sprite_index = spr_effect_muzzle_bike;
                }
                shot_fired = true;
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
        if (shot_fired == true)
        {
            shooting_charge_flicker = false;
            shooting_charge = 0;
            special_charge = 0;
            shooting = 15;
            with (obj_player_yammar)
            {
                event_user(10);
            }
        }
    }
    else if (global.playable_character.name == "Zero")
    {
        ultimate_buster_check = false;
        if (ds_list_find_index(global.parts_equipped, 10) != -1)
        {
            scr_get_part_effect(10, false);
        }
        var is_saber = false;
        var saber_check = false;
        var charging = false;
        if (combo_state == 2)
        {
            if (global.input_shoot_pressed)
            {
                combo_buttoncheck = false;
            }
            if ((global.input_shoot || global.input_shoot_released) && airborne == false && combo_buttoncheck == false)
            {
                combo_timer = 10;
                if ((attack_action != UnknownEnum.Value_2 || ultimate_buster_check == true) && global.weapon[3].ammo >= global.weapon[3].ammo_usage && (global.weapon[3].type != 0 && ds_list_find_index(global.weapon_disable_list, 3) == -1))
                {
                    charging = true;
                    zero_technique = "Shoenzan";
                }
                if (global.input_shoot_released)
                {
                    saber_check = "Triple Combo";
                }
            }
        }
        else
        {
            combo_buttoncheck = false;
            if (global.input_shoot_pressed && airborne == false)
            {
                saber_check = "Triple Combo";
            }
            if (global.input_shoot_pressed && crouch == true)
            {
                saber_check = "Crouch";
            }
            if (global.input_shoot_pressed && airborne == true)
            {
                saber_check = "Airborne";
            }
            if (global.input_shoot_pressed && wall_slide == true)
            {
                saber_check = "Wall";
            }
            if (global.input_shoot_pressed && player_state == UnknownEnum.Value_1)
            {
                saber_check = "Climb";
            }
            if (global.input_shoot_pressed && global.input_up && airborne == false)
            {
                saber_check = "Upslash";
            }
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
            shooting_charge += 2;
            if (shooting_charge == shooting_charge_lvl_1)
            {
                scr_make_sound(snd_player_x_charge_fadeout, 1, 1.5, false);
            }
        }
        else
        {
            shooting_charge = 0;
        }
        if (saber_check != "Triple Combo" && saber_check != "Back" && scr_current_sprite_is([spr_player_zero_saber, spr_player_zero_saber_2, spr_player_zero_saber_3, spr_player_zero_saber_crouch, spr_player_zero_saber_jump, spr_player_zero_saber_landing, spr_player_zero_saber_jump_double, spr_player_zero_saber_walljump, spr_player_zero_saber_climb, spr_player_zero_upattack]))
        {
            saber_check = false;
        }
        if (combo_state < 3 && saber_check != false)
        {
            bullet = instance_create_layer(x, y, "Projectiles", obj_bullet_saber);
            bullet.image_xscale = image_xscale;
            attack_action = UnknownEnum.Value_2;
            if (global.black_armour_get == true)
            {
                bullet.palette = 11;
            }
            attack_priority = 1;
            switch (saber_check)
            {
                case "Triple Combo":
                    if (hurt == false)
                    {
                        xspeed = 0;
                    }
                    dash = false;
                    bullet.damage = 5;
                    bullet.melee_frames = 2;
                    bullet.sprite_index = spr_bullet_zero_saber;
                    if (combo_timer > 0)
                    {
                        if (combo_state == 0)
                        {
                            scr_make_sound(snd_shoot_saber_zero, 1, 1, false);
                            scr_player_voicelines("Combo 1");
                        }
                        else if (combo_state == 1)
                        {
                            bullet.damage = 5;
                            bullet.melee_frames = 2;
                            bullet.sprite_index = spr_bullet_zero_saber_2;
                            scr_make_sound(snd_shoot_saber_zero, 1, 0.9, false);
                            scr_player_voicelines("Combo 2");
                            combo_buttoncheck = true;
                        }
                        else if (combo_state == 2)
                        {
                            bullet.damage = 3;
                            bullet.melee_frames = 2;
                            bullet.sprite_index = spr_bullet_zero_saber_3;
                            bullet.guard_breaking = true;
                            var charged_shoenzan = false;
                            scr_make_sound(snd_shoot_saber_zero, 1, 1.1, false);
                            attack_priority = 2;
                            if (global.weapon[3].type != 0 && ds_list_find_index(global.weapon_disable_list, 3) == -1)
                            {
                                if (shooting_charge >= shooting_charge_lvl_2 || (ultimate_buster_check == true && shooting_charge > 0))
                                {
                                    bullet.special = true;
                                    bullet.melee_frames = 6;
                                    bullet.damage = 12;
                                    bullet.special_type = "Magma Blade";
                                    charged_shoenzan = true;
                                    scr_make_sound(snd_player_zero_talk_special_2, 1, 1, false);
                                    change_sprite(spr_manager, spr_player_zero_saber_shoenzan_charged, UnknownEnum.Value_0, UnknownEnum.Value_1);
                                    attack_action = UnknownEnum.Value_9;
                                    global.weapon_choice = 3;
                                    global.weapon[3].ammo -= global.weapon[3].ammo_usage;
                                    if (underwater == true)
                                    {
                                        bullet.sprite_index = spr_bullet_zero_saber_shoenzan_underwater;
                                        repeat (3)
                                        {
                                            effect = instance_create_depth(x + (random_range(30, 70) * image_xscale * wall_slide_reverse), y + random_range(-30, 30), depth - 15, obj_explosion);
                                            effect.sprite_index = spr_effect_bubbles;
                                        }
                                        scr_make_sound(snd_shoot_magmablade, 1, 0.5, false);
                                    }
                                    else
                                    {
                                        bullet.sprite_index = spr_bullet_zero_saber_shoenzan_charged;
                                        shake = instance_create_depth(0, 0, 0, obj_shake);
                                        scr_make_sound(snd_heatnix_magma, 1, 1, false);
                                        scr_make_sound(snd_heatnix_godbird, 1, 1, false);
                                    }
                                }
                                else if (ultimate_buster_check == false)
                                {
                                    if (underwater == true)
                                    {
                                        scr_make_sound(snd_shoot_magmablade, 1, 0.5, false);
                                        repeat (3)
                                        {
                                            effect = instance_create_depth(x + (random_range(30, 70) * image_xscale * wall_slide_reverse), y + random_range(-30, 30), depth - 15, obj_explosion);
                                            effect.sprite_index = spr_effect_bubbles;
                                        }
                                    }
                                    else
                                    {
                                        flame = instance_create_layer(x, y, "Projectiles", obj_bullet_shoenzan);
                                        flame.image_xscale = image_xscale;
                                        flame.damage = 5;
                                        flame.guard_breaking = true;
                                        scr_make_sound(snd_shoot_fire, 1, 1, false);
                                    }
                                }
                            }
                            if (charged_shoenzan == false)
                            {
                                scr_player_voicelines("Combo 3");
                            }
                        }
                    }
                    else
                    {
                        combo_state = 0;
                        scr_make_sound(snd_shoot_saber_zero, 1, 1, false);
                        scr_player_voicelines("Combo 1");
                    }
                    combo_timer = 10;
                    combo_state++;
                    break;
                case "Crouch":
                    if (global.black_armour_get == true)
                    {
                        bullet.palette = 11;
                    }
                    bullet.damage = 5;
                    if (combo_state > 0)
                    {
                        bullet.damage = 6;
                    }
                    bullet.melee_frames = 6;
                    bullet.sprite_index = spr_bullet_zero_saber_crouch;
                    combo_timer = 10;
                    scr_make_sound(snd_shoot_saber_zero, 1, 1, false);
                    scr_player_voicelines("Combo 1");
                    break;
                case "Airborne":
                    if (global.black_armour_get == true)
                    {
                        bullet.palette = 11;
                    }
                    bullet.melee_frames = 3;
                    if (airdash_lock == true)
                    {
                        bullet.sprite_index = spr_bullet_zero_saber_jump_double;
                        bullet.damage = 5;
                    }
                    else
                    {
                        bullet.sprite_index = spr_bullet_zero_saber_jump;
                        bullet.damage = 4;
                    }
                    scr_make_sound(snd_shoot_saber_zero, 1, 0.9, false);
                    attack_priority = 0;
                    break;
                case "Wall":
                    if (global.black_armour_get == true)
                    {
                        bullet.palette = 11;
                    }
                    bullet.damage = 5;
                    bullet.melee_frames = 6;
                    bullet.sprite_index = spr_bullet_zero_saber_walljump;
                    scr_make_sound(snd_shoot_saber_zero, 1, 1, false);
                    attack_priority = 0;
                    break;
                case "Climb":
                    if (global.black_armour_get == true)
                    {
                        bullet.palette = 11;
                    }
                    bullet.damage = 5;
                    bullet.melee_frames = 6;
                    bullet.sprite_index = spr_bullet_zero_saber_climb;
                    scr_make_sound(snd_shoot_saber_zero, 1, 1, false);
                    attack_priority = 1;
                    break;
                case "Upslash":
                    scr_make_sound(snd_shoot_saber_zero, 1, 1, false);
                    attack_action = UnknownEnum.Value_2;
                    change_sprite(spr_manager, spr_player_zero_upattack, UnknownEnum.Value_0, UnknownEnum.Value_1);
                    scr_player_voicelines("Combo 3");
                    attack_priority = 1;
                    combo_buttoncheck = true;
                    z_upslash = true;
                    break;
            }
            if (global.weapon[1].type != 0 && ds_list_find_index(global.weapon_disable_list, 1) == -1 && global.black_armour_get == true)
            {
                if (global.weapon[1].ammo >= global.weapon[1].ammo_usage && bullet.special == false)
                {
                    bullet.palette = 2;
                    bullet.yammar_marking = 0.5;
                    if (ultimate_buster_check == true)
                    {
                        bullet.yammar_marking = 1.1;
                    }
                    if (saber_check == "Airborne" && airdash_lock == true)
                    {
                        bullet.yammar_marking /= 1.7;
                    }
                }
            }
            else if (global.weapon[1].type != 0 && ds_list_find_index(global.weapon_disable_list, 1) == -1)
            {
                if (global.weapon[1].ammo >= global.weapon[1].ammo_usage && bullet.special == false)
                {
                    bullet.palette = 6;
                    bullet.yammar_marking = 0.3;
                    if (ultimate_buster_check == true)
                    {
                        bullet.yammar_marking = 0.9;
                    }
                    if (saber_check == "Airborne" && airdash_lock == true)
                    {
                        bullet.yammar_marking /= 1.5;
                    }
                }
            }
            if (global.set_rendering == true)
            {
                bullet.palette = 9;
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
            if (saber_check == "Triple Combo" && (global.weapon[3].type != 0 && ds_list_find_index(global.weapon_disable_list, 3) == -1) && combo_state == 3 && !(ultimate_buster_check == true && shooting_charge == 0))
            {
                if (underwater == true)
                {
                    bullet.palette = 8;
                }
                else
                {
                    bullet.palette = 7;
                }
            }
            is_saber = true;
        }
    }
}
else
{
    switch (mech_weapon)
    {
        case 1:
            if (global.input_shoot_pressed)
            {
                bullet_limit = 1;
                if (ds_list_find_index(global.parts_equipped, 1) != -1)
                {
                    scr_get_part_effect(1, "Ride Armour 2");
                }
                with (obj_bullet_default)
                {
                    if (sprite_index == spr_bullet_shotgunice && villainy == 0)
                    {
                        obj_player.bullet_limit--;
                    }
                }
                if (bullet_limit > 0)
                {
                    bullet = instance_create_layer(x + shootpos_x + (-4 * image_xscale), y + shootpos_y + 1, "Projectiles", obj_bullet_shotgunice);
                    bullet.damage = 6;
                    bullet.image_xscale = image_xscale;
                    bullet.speed = 9 * image_xscale;
                    bullet.sprite_index = spr_bullet_shotgunice;
                    bullet.explosion = spr_bullet_shotgunice_end;
                    bullet.animation_loop = false;
                    bullet.special = true;
                    scr_make_sound(snd_shoot_shotgunice, 1, 1, false);
                    mech_recoil = 3;
                }
            }
            break;
        case 2:
            if (global.input_shoot_pressed)
            {
                bullet_limit = 3;
                with (obj_bullet_default)
                {
                    if (sprite_index == spr_bullet_homingtorpedo && villainy == 0)
                    {
                        obj_player.bullet_limit--;
                    }
                }
                if (bullet_limit > 0)
                {
                    bullet = instance_create_layer(x + shootpos_x + (9 * image_xscale), y + shootpos_y, "Projectiles", obj_bullet_missile);
                    bullet.damage = 4;
                    bullet.direction = image_angle;
                    bullet.image_xscale = image_xscale;
                    bullet.speed = 6 * image_xscale;
                    bullet.sprite_index = spr_bullet_homingtorpedo;
                    bullet.explosive = false;
                    bullet.explosion = spr_explosion_death;
                    bullet.explosion_sound = snd_shoot_homingtorpedo_explode;
                    bullet.target = instance_nearest(x, y, obj_enemy_hostile);
                    bullet.tracking_start = 15;
                    bullet.special = true;
                    scr_make_sound(snd_shoot_homingtorpedo, 1, 1, false);
                    mech_recoil = 3;
                }
            }
            break;
        case 3:
            if (global.input_shoot_pressed)
            {
                if (mech_firerate == 0)
                {
                    bullet = instance_create_layer(x + shootpos_x + (2 * image_xscale), y + shootpos_y + 2, "Projectiles", obj_bullet_stormtornado);
                    bullet.damage = 7;
                    bullet.direction = image_angle;
                    bullet.image_xscale = image_xscale;
                    bullet.speed = 1 * image_xscale;
                    bullet.sprite_index = spr_bullet_tornado_spawn;
                    bullet.animation_next = spr_bullet_tornado;
                    bullet.special = true;
                    scr_make_sound(snd_shoot_stormtornado, 1, 1, false);
                    mech_recoil = 10;
                    mech_firerate = 120;
                }
            }
            break;
        case 4:
            if (global.input_shoot_pressed)
            {
                bullet_limit = 1;
                if (ds_list_find_index(global.parts_equipped, 1) != -1)
                {
                    scr_get_part_effect(1, "Ride Armour 2");
                }
                with (obj_bullet_default)
                {
                    if ((sprite_index == spr_bullet_sting || sprite_index == spr_bullet_sting_spawn) && villainy == 0)
                    {
                        obj_player.bullet_limit--;
                    }
                }
                if (bullet_limit > 0)
                {
                    bullet = instance_create_layer(x + shootpos_x + (-2 * image_xscale), y + shootpos_y + 1, "Projectiles", obj_bullet_chameleonsting);
                    bullet.damage = 7;
                    bullet.image_xscale = image_xscale;
                    bullet.speed = 8 * image_xscale;
                    bullet.sprite_index = spr_bullet_sting;
                    bullet.explosion = spr_explosion_projectile;
                    bullet.special = true;
                    scr_make_sound(snd_shoot_chameleonsting, 1, 1, false);
                    mech_recoil = 5;
                }
            }
            break;
        case 5:
            if (global.input_shoot_pressed)
            {
                bullet_limit = 3;
                if (ds_list_find_index(global.parts_equipped, 1) != -1)
                {
                    scr_get_part_effect(1, "Ride Armour 5");
                }
                with (obj_bullet_default)
                {
                    if (object_index == obj_bullet_electricspark && villainy == 0)
                    {
                        obj_player.bullet_limit--;
                    }
                }
                if (bullet_limit > 0)
                {
                    bullet = instance_create_layer(x + shootpos_x + (-2 * image_xscale), y + shootpos_y + 1, "Projectiles", obj_bullet_electricspark);
                    bullet.damage = 6;
                    bullet.image_xscale = image_xscale;
                    bullet.speed = 6 * image_xscale;
                    bullet.special = true;
                    bullet.explosion = 0;
                    scr_make_sound(snd_shoot_electricspark, 1, 1, false);
                    mech_recoil = 3;
                }
            }
            break;
        case 6:
            var hit = false;
            var laser = -4;
            if (global.input_shoot)
            {
                with (obj_enemy_hostile)
                {
                    if (aiminglaser_marked > 0)
                    {
                        bullet = instance_create_layer(x, y, "Projectiles", obj_bullet_default);
                        bullet.damage = 6;
                        bullet.image_alpha = 0;
                        bullet.tick = true;
                        bullet.special = true;
                        hit = true;
                        laser = bullet;
                    }
                }
                if (laser != -4 && instance_exists(laser))
                {
                    with (obj_bullet_default)
                    {
                        if (villainy == 2 && breakable == true)
                        {
                            if (collision_line(obj_player.aiminglaser_center_x, obj_player.aiminglaser_center_y, laser.x, laser.y, self, false, false))
                            {
                                alarm[9] = 1;
                            }
                        }
                    }
                }
                shot_fired = true;
            }
            if (hit == true && mech_recoil == 0)
            {
                mech_recoil = 4;
            }
            break;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_4 = 4,
    Value_5,
    Value_9 = 9
}
