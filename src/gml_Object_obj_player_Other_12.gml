if (coop_client() && instance_exists(other) && recovery == 0 && !invul && movement && global.life > 0 && !global.pause)
{
    var source_name = object_get_name(other.object_index);
    if (variable_instance_exists(other, "coop_kind") && other.coop_kind >= 0)
    {
        source_name = object_get_name(other.coop_kind);
    }
    coop_log("DAMAGE_SOURCE " + source_name + " player=" + string(x) + "," + string(y) + " source=" + string(other.x) + "," + string(other.y) + " visible=" + string(other.visible) + " alpha=" + string(other.image_alpha) + " amount=" + string(other.damage));
}
knockback = set_knockback;
if (global.pause == true)
{
    exit;
}
if (global.life > 0 && invul == false && movement == true && smokebomb_invul == 0)
{
    if (recovery == 0 && other.damage > 0)
    {
        if (player_state == UnknownEnum.Value_5)
        {
            life_mech -= other.damage;
            alarm[3] = 10;
            recovery_time = base_recovery_time;
            scr_make_sound(snd_explosion_bullet, 1, 1, false);
            if (knockback > 0)
            {
                yspeed = 0;
                alarm[4] = 1;
            }
            knockback = 3;
            yspeed = -3;
            if (other.x > x)
            {
                xspeed = -knockback;
            }
            else
            {
                xspeed = knockback;
            }
            dash = false;
            recovery = 1;
            if (life_mech > 0)
            {
                hurt = true;
            }
        }
        else
        {
            if (ds_list_find_index(global.parts_equipped, 16) != -1)
            {
                scr_get_part_effect(16, false);
            }
            var ignore_damage = false;
            if (global.x_armour_chest == "Shadow Chest" && global.playable_character.name == "X")
            {
                if (smokebomb_trigger < 3)
                {
                    smokebomb_trigger++;
                }
                else
                {
                    smokebomb_trigger = 0;
                    smokebomb_invul = 150;
                    effect = instance_create_layer(x, y, "Explosions", obj_explosion);
                    effect.sprite_index = spr_effect_smokebomb;
                    repeat (4)
                    {
                        var range = 30;
                        var x_range = random_range(-range, range);
                        var y_range = random_range(-range, range);
                        effect = instance_create_layer(x + x_range, y + y_range, "Explosions", obj_explosion);
                        effect.sprite_index = spr_effect_smokebomb;
                    }
                    scr_make_sound(snd_smokebomb, 1, 1, false);
                    ignore_damage = true;
                }
            }
            if (ignore_damage == false && sprite_index != global.playable_character.action.climb_finish)
            {
                scr_defense_calculation();
                global.life = global.life - ceil(damage_taken);
                if (global.life > 0)
                {
                    alarm[3] = 30;
                    recovery_time = base_recovery_time;
                    scr_make_sound(snd_explosion_bullet, 1, 1, false);
                    scr_player_voicelines("Hurt");
                }
                else
                {
                    global.life = 0;
                }
                recovery = 1;
                hurt = true;
                global.result_damage++;
                if (knockback > 0)
                {
                    yspeed = 0;
                    alarm[4] = 1;
                    dash = false;
                    climbing = false;
                    attack_action = UnknownEnum.Value_0;
                    if (global.playable_character.name == "Zero")
                    {
                        shooting_charge = 0;
                        special_charge = 0;
                    }
                    if (player_state == UnknownEnum.Value_4)
                    {
                        if (global.life > 0)
                        {
                            alarm[3] = 5;
                        }
                    }
                    else
                    {
                        player_state = UnknownEnum.Value_0;
                        yspeed = -3;
                        if (other.x > x)
                        {
                            xspeed = -knockback;
                        }
                        else
                        {
                            xspeed = knockback;
                        }
                    }
                }
                else
                {
                    hurt = false;
                    alarm[1] = recovery_time;
                    alarm[2] = 1;
                }
            }
            if (ds_list_find_index(global.parts_equipped, 8) != -1)
            {
                scr_get_part_effect(8, false);
            }
            if (ds_list_find_index(global.parts_equipped, 12) != -1)
            {
                scr_get_part_effect(12, false);
            }
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_4 = 4,
    Value_5
}
