if (tag_state > 0)
{
    var tag_palette = (global.playable_character.name == "X") ? 4 : (global.black_armour_get ? 1 : 0);
    pal_swap_set(global.playable_character.visual.palette, tag_palette, false);
    draw_self();
    if (global.playable_character.name == "X")
    {
        scr_draw_armour();
    }
    pal_swap_reset();
    if (tag_state > 0)
    {
        var tag_old_color = draw_get_color();
        var tag_old_alpha = draw_get_alpha();
        var tag_progress = clamp((tag_state == 2) ? 1 : ((tag_state == 1) ? (tag_timer / tag_duration) : (1 - (tag_timer / tag_duration))), 0, 1);
        var tag_ease = tag_progress * tag_progress * (3 - (2 * tag_progress));
        var tag_beam_character = (tag_state == 2) ? tag_to : global.playable_character.name;
        var tag_color = (tag_beam_character == "X") ? make_color_rgb(80, 200, 255) : make_color_rgb(255, 95, 115);
        var tag_width = 1 + (3 * tag_ease);
        var tag_sky_y = min(camera_get_view_y(view_camera[0]) - 16, y - 48);
        var tag_descent = (tag_state == 2) ? clamp(tag_timer / 5, 0, 1) : 1;
        var tag_front_y = lerp(tag_sky_y, y + 2, tag_descent);
        var tag_segment_height = (tag_front_y - tag_sky_y) / 16;
        gpu_set_blendmode(bm_add);
        draw_set_color(tag_color);
        for (var tg = 4; tg >= 1; tg--)
        {
            draw_set_alpha(0.025 * tag_ease);
            draw_rectangle(x - tag_width - tg, tag_sky_y, x + tag_width + tg, tag_front_y, false);
        }
        for (var tb = 0; tb < 16; tb++)
        {
            var tag_segment_y = tag_sky_y + (tb * tag_segment_height);
            var tag_segment_alpha = 0.65 + (0.35 * (tb / 15));
            draw_set_color(tag_color);
            draw_set_alpha(0.38 * tag_ease * tag_segment_alpha);
            draw_rectangle(x - tag_width, tag_segment_y, x + tag_width, tag_segment_y + tag_segment_height, false);
            draw_set_color(c_white);
            draw_set_alpha(0.65 * tag_ease * tag_segment_alpha);
            draw_rectangle(x - 0.8, tag_segment_y, x + 0.8, tag_segment_y + tag_segment_height, false);
        }
        if (tag_state == 2 && tag_descent < 1)
        {
            draw_set_color(c_white);
            draw_set_alpha(0.6);
            draw_rectangle(x - tag_width, tag_front_y - 1, x + tag_width, tag_front_y + 1, false);
        }
        draw_set_color(tag_color);
        draw_set_alpha(0.5 * tag_ease * tag_descent);
        if (tag_descent >= 1)
        {
            for (var ts = 0; ts < 3; ts++)
            {
                var ta = (tag_timer * 9) + (ts * 120);
                draw_circle(x + lengthdir_x(5 + (tag_ease * 3), ta), (y - 10) + lengthdir_y(7, ta), 0.65, false);
            }
            draw_set_alpha(0.3 * tag_ease);
            draw_ellipse(x - (11 * tag_ease), (y + 2) - (2 * tag_ease), x + (11 * tag_ease), y + 2 + (2 * tag_ease), true);
        }
        gpu_set_blendmode(bm_normal);
        draw_set_color(tag_old_color);
        draw_set_alpha(tag_old_alpha);
    }
    exit;
}
event_user(0);
if (global.life > 0)
{
    if (ds_list_find_index(global.parts_equipped, 11) != -1)
    {
        scr_get_part_effect(11, "Visual");
    }
    if (ds_list_find_index(global.parts_equipped, 13) != -1)
    {
        scr_get_part_effect(13, "Visual");
    }
}
if (flicker == true || (flicker_weapon_swap == true && global.playable_character.name == "X"))
{
    gpu_set_fog(true, #D3E8F8, 0, 0);
    if (player_state == UnknownEnum.Value_4)
    {
        draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, image_blend, image_alpha);
    }
    else if (player_state == UnknownEnum.Value_5)
    {
        scr_mech_weapon(mech_weapon);
        draw_sprite_ext(gun_sprite, gun_subimage, x + shootpos_x + shot_fired, y + shootpos_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
        draw_self();
        var mech_head = asset_get_index(sprite_get_name(sprite_index) + global.playable_character.action.mech);
        if (global.playable_character.name == "X")
        {
            if (global.x_armour_head == "Shadow Head")
            {
                mech_head = asset_get_index(sprite_get_name(sprite_index) + "_x_shadowhead");
            }
        }
        if (mech_head != -1)
        {
            draw_sprite_ext(mech_head, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
        }
    }
    else
    {
        draw_self();
    }
    scr_draw_armour();
    gpu_set_fog(false, #D3E8F8, 0, 0);
    flicker_weapon_swap = false;
}
else
{
    palette = 0;
    if (global.playable_character.name == "X")
    {
        palette = 4;
        if (global.weapon_choice > 0)
        {
            palette = 5 + global.weapon_choice;
        }
        else if (shooting > 10)
        {
            palette = 1;
        }
    }
    else if (global.playable_character.name == "Zero")
    {
        palette = 0;
        if (global.black_armour_get == true)
        {
            palette = 1;
        }
        if (global.set_rendering == true)
        {
            palette = 17;
        }
    }
    if (player_state != UnknownEnum.Value_5)
    {
        pal_swap_set(global.playable_character.visual.palette, palette, false);
        if (shooting_charge_flicker == true)
        {
            if (shooting_charge >= shooting_charge_lvl_2 || special_charge >= shooting_charge_lvl_2)
            {
                pal_swap_set(global.playable_character.visual.palette, 3, false);
            }
            else if (shooting_charge >= shooting_charge_lvl_1 || special_charge >= shooting_charge_lvl_1)
            {
                pal_swap_set(global.playable_character.visual.palette, 2, false);
            }
        }
        flicker_palette = choose(33, 35 + global.weapon_choice, 35 + global.weapon_choice, 35 + global.weapon_choice, 35 + global.weapon_choice, 35 + global.weapon_choice, 35 + global.weapon_choice, 35 + global.weapon_choice, 35 + global.weapon_choice);
        flicker_palette_2 = choose(50, 32, 50);
        if (shooting_charge_flicker == true && global.playable_character.name == "X" && global.input_shoot && global.blade_arm_get == true)
        {
            if (shooting_charge >= shooting_charge_lvl_2 || special_charge >= shooting_charge_lvl_2)
            {
                pal_swap_set(global.playable_character.visual.palette, flicker_palette_2, false);
            }
            else if (shooting_charge >= shooting_charge_lvl_1 || special_charge >= shooting_charge_lvl_1)
            {
                pal_swap_set(global.playable_character.visual.palette, 2, false);
            }
        }
        if (shooting_charge_flicker == true && global.playable_character.name == "X" && global.input_special && global.blade_arm_get == true)
        {
            if (shooting_charge >= shooting_charge_lvl_2 || special_charge >= shooting_charge_lvl_2)
            {
                pal_swap_set(global.playable_character.visual.palette, flicker_palette, false);
            }
            else if (shooting_charge >= shooting_charge_lvl_1 || special_charge >= shooting_charge_lvl_1)
            {
                pal_swap_set(global.playable_character.visual.palette, flicker_palette_2, false);
            }
        }
        if (shooting_charge_flicker == true && global.playable_character.name == "Zero" && global.black_armour_get == true)
        {
            if (shooting_charge >= shooting_charge_lvl_2 || special_charge >= shooting_charge_lvl_2)
            {
                pal_swap_set(global.playable_character.visual.palette, 20, false);
            }
            else if (shooting_charge >= shooting_charge_lvl_1 || special_charge >= shooting_charge_lvl_1)
            {
                pal_swap_set(global.playable_character.visual.palette, 19, false);
            }
        }
        if (player_state == UnknownEnum.Value_4)
        {
            draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, image_blend, image_alpha);
        }
        else
        {
            draw_self();
        }
        scr_draw_armour();
        pal_swap_reset();
        image_blend = coop_client() ? c_white : c_white;
        if (slowed > 0)
        {
            image_blend = #C858C0;
            draw_sprite(spr_bullet_powder, global.animate / 5, x - 3, y - 15);
            draw_sprite(spr_bullet_powder, global.animate / 5, x + 8, y - 2);
            draw_sprite(spr_bullet_powder, global.animate / 5, x - 5, y + 10);
        }
        if (smokebomb_invul > 0)
        {
            image_blend = c_gray;
            if (smokebomb_flicker == true)
            {
                image_blend = c_ltgray;
            }
        }
    }
    else
    {
        pal_swap_set(spr_mech_palette, mech_weapon, false);
        scr_mech_weapon(mech_weapon);
        if (mech_weapon == 2)
        {
            with (obj_bullet_default)
            {
                if (sprite_index == spr_bullet_homingtorpedo && villainy == 0)
                {
                    obj_player.gun_subimage++;
                }
            }
        }
        draw_sprite_ext(gun_sprite, gun_subimage, (x + shootpos_x) - (mech_recoil * image_xscale), y + shootpos_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
        draw_self();
        pal_swap_reset();
        pal_swap_set(global.playable_character.visual.palette, palette, false);
        scr_draw_armour();
        var mech_head = asset_get_index(sprite_get_name(sprite_index) + global.playable_character.action.mech);
        if (global.playable_character.name == "X")
        {
            if (global.x_armour_head == "Shadow Head")
            {
                mech_head = asset_get_index(sprite_get_name(sprite_index) + "_x_shadowhead");
            }
        }
        if (mech_head != -1)
        {
            draw_sprite_ext(mech_head, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
        }
        pal_swap_reset();
    }
}
var charge_offset_y = 0;
var charge_sprite_palette = spr_effect_charging_palette;
var charge_sprite = 0;
blue_color = 5;
flicker_color = choose(2, 5 + global.weapon_choice, 5 + global.weapon_choice, 5 + global.weapon_choice, 5 + global.weapon_choice, 5 + global.weapon_choice, 5 + global.weapon_choice, 5 + global.weapon_choice, 5 + global.weapon_choice);
flicker_color_2 = choose(5, 1, 5);
flicker_color_3 = choose(5, 20, 5);
if (airdash_state > 0)
{
    charge_offset_y = -6;
}
if (global.playable_character.name == "X")
{
    charge_sprite = 1;
    if (global.weapon_choice > 0)
    {
        charge_sprite = 5 + global.weapon_choice;
    }
}
if (global.playable_character.name == "Zero" && global.black_armour_get == true)
{
    pal_swap_set(spr_effect_charging_palette, 17, false);
}
else
{
    pal_swap_set(spr_effect_charging_palette, 15, false);
}
if (global.playable_character.name == "X" && (global.input_shoot || global.autocharge == true) && shooting_charge >= shooting_charge_lvl_1)
{
    pal_swap_set(spr_effect_charging_palette, blue_color, false);
}
if (global.playable_character.name == "X" && (global.input_shoot || global.autocharge == true) && shooting_charge_lvl_2 && global.blade_arm_get == true)
{
    pal_swap_set(spr_effect_charging_palette, flicker_color_3, false);
}
if (global.playable_character.name == "X" && (global.input_shoot || global.autocharge == true) && shooting_charge_lvl_2)
{
    pal_swap_set(spr_effect_charging_palette, flicker_color_2, false);
}
if (global.playable_character.name == "X" && global.input_special && shooting_charge >= shooting_charge_lvl_1)
{
    pal_swap_set(spr_effect_charging_palette, blue_color, false);
}
if (global.playable_character.name == "X" && global.input_special && shooting_charge_lvl_2 && global.blade_arm_get == true)
{
    pal_swap_set(spr_effect_charging_palette, flicker_color, false);
}
if ((shooting_charge >= shooting_charge_lvl_2 && global.x4_charge_shot == false) || (special_charge >= shooting_charge_lvl_2 && global.x4_charge_shot == false))
{
    draw_sprite(spr_effect_charging_2, global.animate / 2, x, y + charge_offset_y);
}
if ((shooting_charge >= shooting_charge_lvl_1 && global.x4_charge_shot == false) || (special_charge >= shooting_charge_lvl_1 && global.x4_charge_shot == false))
{
    draw_sprite(spr_effect_charging, global.animate / 2, x, y + charge_offset_y);
}
if ((shooting_charge >= shooting_charge_lvl_2 && global.x4_charge_shot == true) || (special_charge >= shooting_charge_lvl_2 && global.x4_charge_shot == true))
{
    draw_set_alpha(0.65);
    draw_sprite(spr_effect_charge_2_x4, global.animate / 1.5, x, y + charge_offset_y);
    draw_set_alpha(1);
}
if ((shooting_charge >= shooting_charge_lvl_1 && global.x4_charge_shot == true) || (special_charge >= shooting_charge_lvl_1 && global.x4_charge_shot == true))
{
    draw_sprite(spr_effect_charge_1_x4, global.animate / 2, x, y + charge_offset_y);
}
if (global.playable_character.name == "X")
{
    pal_swap_set(spr_effect_charging_palette, 2, false);
}
if (machdash_hold > 5 && global.x4_charge_shot == false)
{
    if (machdash_hold == 6 && global.x4_charge_shot == false)
    {
        scr_make_sound(snd_player_x_machcharge_fadeout, 1, 1.25, false);
    }
    if (machdash_hold >= machdash_holdmax && global.x4_charge_shot == false)
    {
        draw_sprite(spr_effect_charging_2, global.animate / 1.5, x, y + charge_offset_y);
    }
    draw_sprite(spr_effect_charging, global.animate / 1.5, x, y + charge_offset_y);
}
else if (machdash_hold > 5 && global.x4_charge_shot == true)
{
    if (machdash_hold == 6 && global.x4_charge_shot == true)
    {
        scr_make_sound(snd_player_x_machcharge_fadeout, 1, 1.25, false);
    }
    if (machdash_hold >= machdash_holdmax && global.x4_charge_shot == true)
    {
        draw_set_alpha(0.75);
    }
    if (machdash_hold >= machdash_holdmax && global.x4_charge_shot == true)
    {
        draw_sprite(spr_effect_charge_2_x4, global.animate / 1.5, x, y + charge_offset_y);
    }
    draw_set_alpha(1);
    draw_sprite(spr_effect_charge_1_x4, global.animate / 1.5, x, y + charge_offset_y);
}
pal_swap_reset();
if (coop_enabled() && instance_exists(obj_coop_net) && obj_coop_net.connected && (obj_coop_net.tick % 2) == 0 && coop_play_room())
{
    coop_send(coop_packet("op", "player", "room", room_get_name(room), "actor", coop_pack_player(id), "shots", coop_pack_shots(global.coop_role)));
}

enum UnknownEnum
{
    Value_4 = 4,
    Value_5
}
