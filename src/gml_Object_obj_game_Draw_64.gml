if (global.hud_toggle == true)
{
    var x_pos = 20 * global.ui_scale;
    var y_pos = (display_get_gui_height() / 2) - (10 * global.ui_scale);
    var extend = global.lifemax - base_life;
    if (!variable_instance_exists(id, "coop_ammo_font"))
    {
        coop_ammo_font = font_add_sprite_ext(spr_hud_weapon_count, "0123456789", true, 0);
    }
    ammo_font = coop_ammo_font;
    draw_set_font(ammo_font);
    var hud_text_colour;
    if (obj_player.player_state != UnknownEnum.Value_5)
    {
        hud_text_colour = global.playable_character.visual.hud_colour;
        var hud_type = global.playable_character.visual.hud_type;
        if (global.black_armour_get == true && global.playable_character.name == "Zero")
        {
            hud_type = 5;
        }
        if (global.black_armour_get == true && global.playable_character.name == "Zero")
        {
            hud_text_colour = 8388736;
        }
        if (global.weapon_choice > 0)
        {
            hud_type++;
        }
        draw_sprite_ext(spr_hud_player, hud_type, x_pos, y_pos, global.ui_scale, global.ui_scale, 0, c_white, 1);
        draw_sprite_ext(spr_hud_player_extend, 0, x_pos, y_pos - (extend * global.ui_scale), global.ui_scale, global.ui_scale, 0, c_white, 1);
        if (hud_type == (global.playable_character.visual.hud_type + 1) || hud_type == 6)
        {
            draw_sprite_ext(spr_hud_player_extend, 1, x_pos, y_pos - (global.powertank * 12 * global.ui_scale), global.ui_scale, global.ui_scale, 0, c_white, 1);
        }
        if (global.lives_toggle == true)
        {
            draw_sprite_ext(spr_hud_player_lives, 0, x_pos, y_pos, global.ui_scale, global.ui_scale, 0, c_white, 1);
            draw_text_ext_transformed_color(x_pos - (10 * global.ui_scale), y_pos + (16 * global.ui_scale), global.lives, 10, 11 * global.ui_scale, global.ui_scale, global.ui_scale, 0, hud_text_colour, hud_text_colour, hud_text_colour, hud_text_colour, 1);
        }
        var bar_height = -(global.lifemax * global.ui_scale) - 1;
        var bar_start_y = y_pos;
        var bar_limit = global.life / global.lifemax;
        if (global.life > global.lifemax)
        {
            bar_limit = 1;
        }
        if (life_tick != global.life && life_tick > 0)
        {
            life_tick += ((global.life - life_tick) * 0.025);
        }
        if (life_tick > 0)
        {
            draw_rectangle_color(x_pos, bar_start_y, (x_pos + (3 * global.ui_scale)) - 1, bar_start_y + ((bar_height + global.ui_scale) * (life_tick / global.lifemax)), c_red, c_red, c_red, c_red, 0);
        }
        if (global.life > 0)
        {
            life_bar_colour = 65280;
            life_bar_colour_2 = 65535;
            if (ds_list_find_index(global.parts_equipped, 15) != -1)
            {
                scr_get_part_effect(15, "Visual");
            }
            draw_rectangle_color(x_pos, bar_start_y, (x_pos + (3 * global.ui_scale)) - 1, bar_start_y + (bar_height * bar_limit), life_bar_colour, life_bar_colour, life_bar_colour_2, life_bar_colour_2, 0);
        }
    }
    else
    {
        pal_swap_set(spr_mech_palette, obj_player.mech_weapon, false);
        draw_sprite_ext(spr_hud_player, 2, x_pos, y_pos, global.ui_scale, global.ui_scale, 0, c_white, 1);
        pal_swap_reset();
        var bar_height = -(28 * global.ui_scale) - 1;
        var bar_start_y = y_pos;
        var bar_limit = obj_player.life_mech / 28;
        if (obj_player.life_mech > 28)
        {
            bar_limit = 1;
        }
        if (life_tick != obj_player.life_mech && life_tick > 0)
        {
            life_tick += ((obj_player.life_mech - life_tick) * 0.025);
        }
        if (life_tick > 0)
        {
            draw_rectangle_color(x_pos, bar_start_y, (x_pos + (3 * global.ui_scale)) - 1, bar_start_y + ((bar_height + global.ui_scale) * (life_tick / 28)), c_red, c_red, c_red, c_red, 0);
        }
        if (obj_player.life_mech > 0)
        {
            draw_rectangle_color(x_pos, bar_start_y, (x_pos + (3 * global.ui_scale)) - 1, bar_start_y + (bar_height * bar_limit), c_lime, c_lime, c_yellow, c_yellow, 0);
        }
    }
    if (global.weapon_choice > 0 && obj_player.player_state != UnknownEnum.Value_5)
    {
        var bar_height = -((36 + (global.powertank * 12)) * global.ui_scale) - 1;
        var bar_start_y = y_pos;
        var bar_limit = global.weapon[global.weapon_choice].ammo / global.weapon_ammo_max;
        if (global.weapon[global.weapon_choice].ammo > global.weapon_ammo_max)
        {
            bar_limit = 1;
        }
        scr_weapon_menus(global.weapon[global.weapon_choice].type);
        if (global.weapon[global.weapon_choice].ammo > 0)
        {
            draw_rectangle_color(x_pos + (9 * global.ui_scale), bar_start_y, (x_pos + (12 * global.ui_scale)) - 1, bar_start_y + (bar_height * bar_limit), weapon_bar_colour_1, weapon_bar_colour_1, weapon_bar_colour_2, weapon_bar_colour_2, 0);
        }
        draw_sprite_ext(global.playable_character.visual.weapon_icon, global.weapon_choice, x_pos + (5 * global.ui_scale), y_pos + (7 * global.ui_scale), global.ui_scale, global.ui_scale, 0, c_white, 1);
        draw_set_halign(fa_center);
        var display_ammo = floor(global.weapon[global.weapon_choice].ammo / global.weapon[global.weapon_choice].ammo_usage);
        ultimate_buster_check = false;
        if (ds_list_find_index(global.parts_equipped, 10) != -1)
        {
            scr_get_part_effect(10, false);
        }
        if ((global.x_armour_arm == 0 && global.playable_character.name == "X") || (global.playable_character.name == "Zero" && global.weapon_choice != 8))
        {
            ultimate_buster_check = false;
        }
        if ((obj_player.special_charge > obj_player.shooting_charge_lvl_2 && global.input_special && global.playable_character.name == "X") || (global.playable_character.name == "Zero" && global.weapon_choice == 8 && obj_player.special_charge > obj_player.shooting_charge_lvl_2) || ultimate_buster_check == true)
        {
            display_ammo = floor(global.weapon[global.weapon_choice].ammo / global.weapon[global.weapon_choice].charge_cost);
        }
        draw_text_ext_transformed_color(x_pos + (8 * global.ui_scale), y_pos + (16 * global.ui_scale), display_ammo, 10, 11 * global.ui_scale, global.ui_scale, global.ui_scale, 0, 16777215, 16777215, weapon_ammo_colour, weapon_ammo_colour, 1);
        draw_set_halign(fa_left);
    }
    else
    {
        draw_set_halign(fa_center);
        if (obj_player.player_state == UnknownEnum.Value_5)
        {
            draw_text_ext_transformed_color(x_pos + (8 * global.ui_scale), y_pos + (16 * global.ui_scale), ceil(obj_player.life_mech), 10, 11 * global.ui_scale, global.ui_scale, global.ui_scale, 0, 16777215, 16777215, 16777215, 16777215, 1);
        }
        else
        {
            draw_text_ext_transformed_color(x_pos + (8 * global.ui_scale), y_pos + (16 * global.ui_scale), ceil(global.life), 10, 11 * global.ui_scale, global.ui_scale, global.ui_scale, 0, hud_text_colour, hud_text_colour, hud_text_colour, hud_text_colour, 1);
        }
        draw_set_halign(fa_left);
    }
    draw_set_font(global.fnt_game);
    var soul_x_pos = 10 * global.ui_scale;
    var soul_y_pos = (display_get_gui_height() - (5 * global.ui_scale)) + souls_y;
    draw_sprite_ext(spr_hud_souls, global.animate / 7, soul_x_pos, soul_y_pos, global.ui_scale, global.ui_scale, 0, c_white, 1);
    var soul_text = string_repeat("0", max(0, 5 - string_length(string(global.nightmare_souls)))) + string(global.nightmare_souls);
    var soul_text_colour = 16024640;
    draw_set_font(global.fnt_numbers);
    draw_text_transformed_color(soul_x_pos + (28 * global.ui_scale), soul_y_pos - (16 * global.ui_scale), soul_text, global.ui_scale, global.ui_scale, 0, soul_text_colour, soul_text_colour, soul_text_colour, soul_text_colour, 1);
    if (souls_timer > 0)
    {
        soul_text_colour = 16772244;
        draw_set_halign(fa_right);
        draw_text_transformed_color(soul_x_pos + (58 * global.ui_scale), soul_y_pos - (27 * global.ui_scale), "+" + string(souls_collected), global.ui_scale, global.ui_scale, 0, soul_text_colour, soul_text_colour, soul_text_colour, soul_text_colour, souls_alpha);
        draw_set_halign(fa_left);
    }
    draw_set_font(global.fnt_game);
    if (global.x_armour_chest == "Shadow Chest" && global.playable_character.name == "X")
    {
        if (obj_player.smokebomb_trigger == 3)
        {
            x_pos = 25 * global.ui_scale;
            y_pos = (display_get_gui_height() / 2) + (25 * global.ui_scale);
            draw_sprite_ext(spr_icon_shadowchest, 0, x_pos, y_pos, global.ui_scale, global.ui_scale, 0, c_white, 1);
        }
    }
}
if (global.hud_toggle && !global.pause_screen && instance_exists(obj_player) && obj_player.player_state != 5 && global.zero_unlock && !coop_enabled() && tagteam_separate_health_active() && global.tag_health[0] >= 0)
{
    var hs = global.ui_scale;
    var hx = 3 * hs;
    var hy = (display_get_gui_height() / 2) - (3 * hs);
    var standby = global.tag_health[1 - tagteam_actor_slot()];
    var hc = (global.playable_character.name == "X") ? make_color_rgb(235, 75, 95) : make_color_rgb(48, 164, 245);
    var saved_color = draw_get_color();
    var saved_alpha = draw_get_alpha();
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(28, 25, 35));
    draw_rectangle(hx - hs, hy - hs, hx + (15 * hs), hy + (2 * hs), false);
    draw_set_color((standby > 0) ? hc : c_gray);
    if (standby > 0)
    {
        draw_rectangle(hx, hy, hx + (14 * hs * clamp(standby / global.lifemax, 0, 1)), hy + hs, false);
    }
    draw_set_color(saved_color);
    draw_set_alpha(saved_alpha);
}
if (!coop_enabled())
{
    if (global.hud_toggle && !global.pause_screen && instance_exists(obj_player) && obj_player.player_state != 5)
    {
        var tt_font = draw_get_font();
        var tt_color = draw_get_color();
        var tt_alpha = draw_get_alpha();
        var tt_ha = draw_get_halign();
        var tt_va = draw_get_valign();
        var tt_s = global.ui_scale;
        var tt_x = 10 * tt_s;
        var tt_y = (display_get_gui_height() / 2) - (13 * tt_s);
        var tt_to_zero = global.playable_character.name == "X";
        var tt_available = global.zero_unlock && tagteam_partner_alive();
        var tt_icon = tt_to_zero ? (tt_available ? spr_pickup_lives_zero : spr_tag_zero_locked) : spr_pickup_lives_x;
        draw_set_alpha(1);
        draw_sprite_ext(tt_icon, 0, tt_x, tt_y, tt_s * 0.65, tt_s * 0.65, 0, c_white, 1);
        var tt_outline = tt_to_zero ? make_color_rgb(235, 75, 95) : make_color_rgb(48, 164, 245);
        var tt_key_name = global.controller ? scr_controllerbinds(global.tag_swap_pad) : tagteam_key_name(global.tag_swap_key);
        var tt_arrow_y = (display_get_gui_height() / 2) - (31 * tt_s);
        draw_set_alpha(0.9);
        draw_set_color(tt_available ? tt_outline : c_gray);
        draw_line_width(tt_x - (6 * tt_s), tt_arrow_y - (7 * tt_s), tt_x + (5 * tt_s), tt_arrow_y - (7 * tt_s), tt_s * 0.75);
        draw_triangle(tt_x + (7 * tt_s), tt_arrow_y - (7 * tt_s), tt_x + (4 * tt_s), tt_arrow_y - (9 * tt_s), tt_x + (4 * tt_s), tt_arrow_y - (5 * tt_s), false);
        draw_line_width(tt_x + (6 * tt_s), tt_arrow_y + (7 * tt_s), tt_x - (5 * tt_s), tt_arrow_y + (7 * tt_s), tt_s * 0.75);
        draw_triangle(tt_x - (7 * tt_s), tt_arrow_y + (7 * tt_s), tt_x - (4 * tt_s), tt_arrow_y + (5 * tt_s), tt_x - (4 * tt_s), tt_arrow_y + (9 * tt_s), false);
        draw_set_font(global.fnt_game);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_alpha(1);
        var tt_text_s = min(tt_s * global.font_scale * 0.55, (11 * tt_s) / max(1, string_width(tt_key_name)));
        var tt_font_origin = (global.locale >= 4 && global.locale <= 7) ? 0 : sprite_get_xoffset(spr_font_game);
        var tt_key_x = (tt_x - ((string_width(tt_key_name) * tt_text_s) / 2)) + (tt_font_origin * tt_text_s);
        var tt_key_y = tt_arrow_y - ((string_height(tt_key_name) * tt_text_s) / 2);
        scr_draw_text_outlined(tt_key_x, tt_key_y, tt_outline, 16777215, tt_key_name, tt_text_s);
        draw_set_font(tt_font);
        draw_set_color(tt_color);
        draw_set_alpha(tt_alpha);
        draw_set_halign(tt_ha);
        draw_set_valign(tt_va);
    }
}

enum UnknownEnum
{
    Value_5 = 5
}
