if (room == rm_title && global.pause_menu_sub == "Co-op")
{
    if (!variable_instance_exists(id, "coop_lobby_age"))
    {
        coop_lobby_age = 0;
        coop_lobby_row = 0;
        coop_lobby_role = 1;
        coop_lobby_char = "X";
        coop_lobby_pulse = 0;
        coop_lobby_blend = 0;
        coop_lobby_cursor = 0;
    }
    var sc = min(global.ui_scale, max(1, floor(display_get_gui_height() / 290)));
    var cx = display_get_gui_width() / 2;
    var cy = display_get_gui_height() / 2;
    var oldf = draw_get_font();
    var oldh = draw_get_halign();
    var oldc = draw_get_color();
    var olda = draw_get_alpha();
    var enter = 1 - power(1 - min(1, coop_lobby_age / 30), 3);
    var panel_y = cy + ((1 - enter) * 18 * sc);
    var blue = make_color_rgb(62, 194, 255);
    var red = make_color_rgb(255, 80, 135);
    var violet = make_color_rgb(145, 91, 218);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(5, 8, 22));
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_sprite_tiled_ext(spr_pause_grid, 0, coop_lobby_age * 0.12 * sc, -coop_lobby_age * 0.07 * sc, sc, sc, violet, 0.16 * enter);
    draw_sprite_ext(spr_stageselect_gradient, 0, cx, 0, display_get_gui_width() / 320, display_get_gui_height() / 270, 0, violet, 0.32 * enter);
    draw_sprite_ext(spr_stageselect_gradient, 0, cx, display_get_gui_height(), display_get_gui_width() / 320, -display_get_gui_height() / 270, 0, blue, 0.2 * enter);
    for (var j = 0; j < 16; j++)
    {
        var star_x = cx + (sin(j * 7.3) * 205 * sc);
        var star_y = panel_y + (((((j * 31) + (coop_lobby_age * 0.15)) % 266) - 133) * sc);
        draw_sprite_ext(spr_shiny_sparkle, floor((coop_lobby_age / 8) + j) % sprite_get_number(spr_shiny_sparkle), star_x, star_y, sc * 0.4, sc * 0.4, 0, ((j % 2) == 0) ? blue : violet, 0.24 * enter);
    }
    draw_set_alpha(0.93 * enter);
    draw_set_color(make_color_rgb(8, 15, 35));
    draw_rectangle(cx - (192 * sc), panel_y - (133 * sc), cx + (192 * sc), panel_y + (142 * sc), false);
    draw_set_alpha(enter);
    draw_set_color(make_color_rgb(62, 68, 107));
    draw_rectangle(cx - (192 * sc), panel_y - (133 * sc), cx + (192 * sc), panel_y + (142 * sc), true);
    draw_set_color(blue);
    draw_rectangle(cx - (192 * sc), panel_y - (133 * sc), cx - (88 * sc), panel_y - (131 * sc), false);
    draw_set_color(red);
    draw_rectangle(cx + (88 * sc), panel_y - (133 * sc), cx + (192 * sc), panel_y - (131 * sc), false);
    draw_set_font(global.fnt_game);
    draw_set_halign(fa_center);
    draw_sprite_ext(spr_coop_title_menu, 1, cx, panel_y - (145 * sc), sc * 1.25, sc * 1.25, 0, c_white, enter);
    scr_draw_text_outlined(cx, panel_y - (96 * sc), 0, make_color_rgb(141, 157, 192), "CHOOSE YOUR HUNTER", sc * 0.65 * global.font_scale);
    for (var i = 0; i < 2; i++)
    {
        var px = cx + ((-1 + (2 * i)) * 83 * sc);
        var character = (i == 0) ? "X" : "Zero";
        var strength = (i == 0) ? (1 - coop_lobby_blend) : coop_lobby_blend;
        var tint = (i == 0) ? blue : red;
        var top = panel_y - (79 * sc);
        var card_y = top + (55 * sc);
        draw_set_alpha(enter);
        draw_set_color(merge_color(make_color_rgb(11, 19, 40), tint, 0.09 + (0.12 * strength)));
        draw_rectangle(px - (68 * sc), top, px + (68 * sc), top + (111 * sc), false);
        draw_set_color(merge_color(make_color_rgb(47, 55, 84), tint, 0.3 + (0.7 * strength)));
        draw_rectangle(px - (68 * sc), top, px + (68 * sc), top + (111 * sc), true);
        var card_left = px - (67 * sc);
        var card_right = px + (67 * sc);
        var card_top = top + sc;
        var card_bottom = top + (108 * sc);
        var tile_scale = sc * 0.55;
        var tile_size = 26 * tile_scale;
        var drift_x = (coop_lobby_age * ((i == 0) ? 0.1 : -0.07) * sc) % tile_size;
        var drift_y = (coop_lobby_age * ((i == 0) ? 0.04 : -0.11) * sc) % tile_size;
        draw_set_alpha(1);
        var tx = (card_left - tile_size) + drift_x;
        while (tx < card_right)
        {
            var ty = (card_top - tile_size) + drift_y;
            while (ty < card_bottom)
            {
                var clip_left = max(card_left, tx);
                var clip_top = max(card_top, ty);
                var clip_right = min(card_right, tx + tile_size);
                var clip_bottom = min(card_bottom, ty + tile_size);
                if (clip_right > clip_left && clip_bottom > clip_top)
                {
                    draw_sprite_part_ext(spr_pause_grid, 0, (clip_left - tx) / tile_scale, (clip_top - ty) / tile_scale, (clip_right - clip_left) / tile_scale, (clip_bottom - clip_top) / tile_scale, clip_left, clip_top, tile_scale, tile_scale, tint, (0.2 + (0.19 * strength)) * enter);
                }
                ty += tile_size;
            }
            tx += tile_size;
        }
        draw_sprite_ext(spr_stageselect_gradient, 0, px, card_bottom, (134 * sc) / 320, (-107 * sc) / 135, 0, (i == 0) ? blue : violet, (0.24 + (0.16 * strength)) * enter);
        if (i == 0)
        {
            var scan_y = card_top + (((coop_lobby_age * 0.35) % 106) * sc);
            draw_set_alpha(0.13 * strength * enter);
            draw_set_color(blue);
            draw_rectangle(card_left, scan_y, card_right, min(card_bottom, scan_y + sc), false);
        }
        else
        {
            for (var ember = 0; ember < 9; ember++)
            {
                var ex = px + (sin(ember * 8.4) * 55 * sc);
                var ey = card_bottom - ((((ember * 13) + (coop_lobby_age * 0.27)) % 98) * sc);
                draw_sprite_ext(spr_shiny_sparkle, floor((coop_lobby_age / 7) + ember) % sprite_get_number(spr_shiny_sparkle), ex, ey, sc * 0.3, sc * 0.3, 0, ((ember % 2) == 0) ? red : violet, (0.12 + (0.24 * strength)) * enter);
            }
        }
        draw_set_alpha(enter);
        var weapon_backdrop = (i == 0) ? spr_coop_buster_backdrop : spr_coop_saber_backdrop;
        var weapon_scale = min((124 * sc) / sprite_get_width(weapon_backdrop), (104 * sc) / sprite_get_height(weapon_backdrop));
        draw_sprite_ext(weapon_backdrop, 0, px, top + (54 * sc), weapon_scale, weapon_scale, 0, (i == 0) ? c_white : make_color_rgb(255, 50, 35), (0.1 + (0.05 * strength)) * enter);
        var actor_scale = max(1, floor(sc * 1.5));
        var foot_y = top + (95 * sc);
        var anchor_x = px + (((i == 0) ? -13 : 12) * sc);
        var anchor_y = foot_y - (22 * actor_scale);
        var facing = (i == 0) ? 1 : -1;
        var action_age = (i == 0) ? coop_lobby_attack_x : coop_lobby_attack_zero;
        var body = (i == 0) ? spr_player_x_idle : spr_player_zero_idle;
        var body_frame = floor((coop_lobby_age * 5) / 60) % sprite_get_number(body);
        var action_frame = -1;
        if (i == 1 && action_age >= 0 && action_age < 18)
        {
            body = spr_player_zero_saber;
            action_frame = min(sprite_get_number(body) - 1, floor((action_age * 45) / 60));
            body_frame = action_frame;
        }
        if (i == 0 && action_age >= 8 && action_age < 36)
        {
            body = spr_player_x_idle_shoot_charge;
            body_frame = min(sprite_get_number(body) - 1, floor(((action_age - 8) * 15) / 60));
        }
        draw_set_color(c_black);
        for (var shadow_layer = 0; shadow_layer < 5; shadow_layer++)
        {
            var shadow_rx = (29 - (shadow_layer * 3)) * sc;
            var shadow_ry = (3 - (shadow_layer * 0.35)) * sc;
            draw_set_alpha((0.035 + (shadow_layer * 0.017)) * (0.65 + (0.35 * strength)) * enter);
            draw_ellipse(anchor_x - shadow_rx, (foot_y + (2 * sc)) - shadow_ry, anchor_x + shadow_rx, foot_y + (2 * sc) + shadow_ry, false);
        }
        draw_set_alpha(enter);
        pal_swap_set((i == 0) ? spr_player_x_palette : spr_player_zero_palette, (i == 0) ? ((action_age >= 0 && action_age < 8 && (action_age % 4) < 2) ? 3 : 4) : 0, false);
        draw_sprite_ext(body, body_frame, anchor_x, anchor_y, actor_scale * facing, actor_scale, 0, c_white, (0.5 + (0.5 * strength)) * enter);
        pal_swap_reset();
        if (i == 1 && action_frame >= 0)
        {
            pal_swap_set(spr_bullet_saber_palette, 0, false);
            draw_sprite_ext(spr_bullet_zero_saber, action_frame, anchor_x, anchor_y, -actor_scale, actor_scale, 0, c_white, enter);
            pal_swap_reset();
        }
        if (i == 0 && action_age >= 8 && action_age < 32)
        {
            var gun_x = anchor_x + (18 * actor_scale);
            var gun_y = anchor_y - (5 * actor_scale);
            var muzzle_frame = floor((action_age - 8) / 2);
            if (muzzle_frame < sprite_get_number(spr_effect_muzzle_x_charge_2))
            {
                draw_sprite_ext(spr_effect_muzzle_x_charge_2, muzzle_frame, gun_x, gun_y, actor_scale, actor_scale, 0, c_white, enter);
            }
            var shot_age = action_age - 8;
            var shot_sprite = (shot_age < 4) ? spr_bullet_player_charge_2_spawn : spr_bullet_player_charge_2;
            var shot_frame = (shot_age < 4) ? floor(shot_age / 2) : (floor((shot_age - 4) / 3) % sprite_get_number(shot_sprite));
            var shot_x = gun_x + (max(0, shot_age - 2) * 3 * sc);
            var shot_left = shot_x - (sprite_get_xoffset(shot_sprite) * actor_scale);
            var shot_top = gun_y - (sprite_get_yoffset(shot_sprite) * actor_scale);
            var part_left = max(0, (card_left - shot_left) / actor_scale);
            var part_right = min(sprite_get_width(shot_sprite), (card_right - shot_left) / actor_scale);
            if (part_right > part_left)
            {
                draw_sprite_part_ext(shot_sprite, shot_frame, part_left, 0, part_right - part_left, sprite_get_height(shot_sprite), shot_left + (part_left * actor_scale), shot_top, actor_scale, actor_scale, c_white, min(1, (32 - action_age) / 7) * enter);
            }
        }
        draw_set_color(tint);
        draw_set_alpha((0.2 + (0.65 * strength)) * enter);
        draw_rectangle(px - (68 * sc), top + (109 * sc), px + (68 * sc), top + (111 * sc), false);
        draw_set_alpha(enter);
        scr_draw_text_outlined(px, top + (114 * sc), 0, merge_color(c_gray, tint, strength), character, sc * global.font_scale);
    }
    var rows = ["SESSION", "HUNTER", (coop_lobby_role == 1) ? "LISTEN PORT" : "HOST ADDRESS", "CUSTOMISE CONTROLS", (global.coop_role == 0) ? "START SESSION" : "CANCEL SESSION", "BACK"];
    var line_gap = 14;
    var vals = [(coop_lobby_role == 1) ? "HOST" : "JOIN", coop_lobby_char, (coop_lobby_role == 1) ? string(global.coop_port) : (global.coop_host + ":" + string(global.coop_port)), "", (global.coop_role == 0) ? "READY" : obj_coop_net.status, ""];
    var selection_y = panel_y + ((56 + (coop_lobby_cursor * line_gap)) * sc);
    draw_set_alpha(0.22 * enter);
    draw_set_color(violet);
    draw_rectangle(cx - (164 * sc), selection_y - (2 * sc), cx + (164 * sc), selection_y + (12 * sc), false);
    draw_set_alpha(enter);
    draw_set_color(violet);
    draw_rectangle(cx - (164 * sc), selection_y - (2 * sc), cx - (162 * sc), selection_y + (12 * sc), false);
    for (var r = 0; r < array_length(rows); r++)
    {
        var row_y = panel_y + ((56 + (r * line_gap)) * sc);
        var selected = coop_lobby_row == r;
        var ink = selected ? 16777215 : make_color_rgb(139, 154, 182);
        draw_set_halign(fa_left);
        scr_draw_text_outlined(cx - (152 * sc), row_y, 0, ink, rows[r], sc * 0.72 * global.font_scale);
        draw_set_halign(fa_right);
        scr_draw_text_outlined(cx + (152 * sc), row_y, 0, selected ? make_color_rgb(255, 190, 72) : blue, vals[r], sc * 0.72 * global.font_scale);
    }
    draw_set_halign(fa_center);
    scr_draw_text_outlined(cx, panel_y + (154 * sc), 0, make_color_rgb(130, 142, 173), (coop_lobby_error != "") ? coop_lobby_error : "LEFT / RIGHT: CHANGE - CONFIRM: SELECT", sc * 0.55 * global.font_scale);
    draw_set_alpha(olda);
    draw_set_color(oldc);
    draw_set_halign(oldh);
    draw_set_font(oldf);
    exit;
}
if (global.coop_buddy)
{
    exit;
}
if (instance_exists(obj_comic_parent))
{
    exit;
}
if (global.pause_screen == true)
{
    global.hud_toggle = false;
    pause_animate++;
    tank_animate++;
    if (instance_exists(obj_cutscene_investigator))
    {
        exit;
    }
    switch (global.pause_menu)
    {
        case "Paused":
            scr_get_character(global.playable_character.name);
            var menu_colour = character_colour;
            draw_sprite_ext(spr_white_space, 0, x, y, room_width, room_height, 0, menu_colour, 1);
            draw_sprite_ext(spr_white_space, 0, x, y, room_width, room_height, 0, c_black, 0.5);
            draw_sprite_ext(spr_pause_gradient, 0, display_get_gui_width() / 2, display_get_gui_height() / 2, global.ui_scale * 2, global.ui_scale, 0, c_white, 1);
            draw_sprite_ext(spr_pause_gradient, 0, display_get_gui_width() / 2, display_get_gui_height() / 2, global.ui_scale * 2, -global.ui_scale, 0, c_white, 1);
            gpu_set_blendmode(bm_add);
            draw_sprite_tiled_ext(spr_pause_grid, 0, pause_animate, pause_animate, global.ui_scale / 2, global.ui_scale / 2, menu_colour, 0.3);
            gpu_set_blendmode(bm_normal);
            var scale = global.ui_scale / 1.25;
            draw_sprite_ext(spr_pause_right, 0, display_get_gui_width(), 0, scale, scale, 0, menu_colour, 1);
            draw_sprite_ext(spr_pause_bottom, 0, 0, display_get_gui_height(), scale, scale, 0, menu_colour, 1);
            draw_sprite_ext(spr_pause_top, 0, 0, 0, scale, scale, 0, menu_colour, 1);
            draw_sprite_ext(spr_pause_right, 1, display_get_gui_width(), 0, scale, scale, 0, c_white, 1);
            shader_set(shd_hue);
            shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), pause_hue);
            draw_sprite_ext(spr_pause_right, 2, display_get_gui_width(), 0, scale, scale, 0, c_white, 1);
            shader_reset();
            draw_sprite_ext(spr_pause_bottom, 1, 0, display_get_gui_height(), scale, scale, 0, c_white, 1);
            draw_sprite_ext(spr_pause_top, 1, 0, 0, scale, scale, 0, c_white, 1);
            draw_set_font(global.fnt_numbers);
            if (global.lives_toggle == true)
            {
                draw_sprite_ext(global.playable_character.visual.life_icon, 0, display_get_gui_width() - (173 * scale), 37 * scale, scale, scale, 0, c_white, 1);
                draw_text_transformed_color(display_get_gui_width() - (153 * scale), 30 * scale, "x" + string(global.lives), scale, scale, 0, c_white, c_white, c_white, c_white, 1);
            }
            draw_sprite_ext(mugshot, blink, display_get_gui_width() - (96 * scale), 8 * scale, scale, scale, 0, c_white, 1);
            if (global.playable_character.name == "X")
            {
                if (global.x_armour_chest == "Shadow Chest")
                {
                    draw_sprite_ext(spr_mugshot_x_armour, 3, display_get_gui_width() - (96 * scale), 8 * scale, scale, scale, 0, c_white, 1);
                }
                if (global.x_armour_head == "Shadow Head")
                {
                    draw_sprite_ext(spr_mugshot_x_armour, 2, display_get_gui_width() - (96 * scale), 8 * scale, scale, scale, 0, c_white, 1);
                }
            }
            var amount = global.life / global.lifemax;
            if (global.life > 0)
            {
                draw_rectangle_color(display_get_gui_width() - (171 * scale), 82 * scale, (display_get_gui_width() - (171 * scale)) + (155 * scale * amount), (82 * scale) + (6 * scale), c_yellow, c_lime, c_lime, c_yellow, 0);
            }
            draw_text_transformed_color(display_get_gui_width() - (163 * scale), 69 * scale, string_repeat("0", max(0, 2 - string_length(string(global.life)))) + string(global.life) + "/" + string_repeat("0", max(0, 2 - string_length(string(global.lifemax)))) + string(global.lifemax), scale, scale, 0, c_white, c_white, c_white, c_white, 1);
            scr_get_rank(global.rescue_list);
            draw_sprite_ext(spr_pause_rank, rank_letter, display_get_gui_width() - (113 * scale), 60 * scale, scale, scale, 0, c_white, 1);
            draw_text_transformed_color(display_get_gui_width() - (159 * scale), 96 * scale, global.hearttank, scale, scale, 0, c_white, c_white, c_white, c_white, 1);
            draw_text_transformed_color(display_get_gui_width() - (159 * scale), 113 * scale, global.nightmare_souls, scale, scale, 0, c_white, c_white, c_white, c_white, 1);
            draw_text_transformed_color(display_get_gui_width() - (69 * scale), 96 * scale, string(global.rescue_count) + "/" + string(global.rescue_max), scale, scale, 0, c_white, c_white, c_white, c_white, 1);
            var draw_seconds = (global.playtime div 60) % 60;
            var draw_minutes = (global.playtime div 3600) % 60;
            var draw_hours = (global.playtime div 216000) % 60;
            var playtime = string_repeat("0", max(0, 2 - string_length(string(draw_hours)))) + string(draw_hours) + ":" + string_repeat("0", max(0, 2 - string_length(string(draw_minutes)))) + string(draw_minutes) + ":" + string_repeat("0", max(0, 2 - string_length(string(draw_seconds)))) + string(draw_seconds);
            draw_text_transformed_color(display_get_gui_width() - (69 * scale), 113 * scale, playtime, scale, scale, 0, c_white, c_white, c_white, c_white, 1);
            draw_set_font(global.fnt_game);
            for (var i = 0; i < 10; i++)
            {
                if (global.weapon[i].type != 0)
                {
                    var disabled = false;
                    if (global.playable_character.name == "Zero" && ds_list_find_index(global.weapon_disable_list, i) != -1)
                    {
                        disabled = true;
                    }
                    var shade = 16777215;
                    if (disabled == true)
                    {
                        shade = 8421504;
                    }
                    draw_sprite_ext(global.playable_character.visual.weapon_icon, i, 42 * scale, (31 * scale) + (17 * scale * i), scale, scale, 0, shade, 1);
                    amount = global.weapon[i].ammo / global.weapon_ammo_max;
                    var length = 120;
                    if (global.powertank == true)
                    {
                        length = 150;
                    }
                    draw_rectangle_color(57 * scale, (35 * scale) + (17 * scale * i), (57 * scale) + (length * scale), (35 * scale) + (17 * scale * i) + (3 * scale), menu_colour, menu_colour, menu_colour, menu_colour, 0);
                    draw_set_alpha(0.7);
                    draw_rectangle_color(57 * scale, (35 * scale) + (17 * scale * i), (57 * scale) + (length * scale), (35 * scale) + (17 * scale * i) + (3 * scale), c_black, c_black, c_black, c_black, 0);
                    draw_set_alpha(1);
                    scr_weapon_menus(global.weapon[i].type);
                    if (global.weapon[i].ammo > 0 && disabled == false)
                    {
                        draw_rectangle_color(57 * scale, (35 * scale) + (17 * scale * i), (57 * scale) + (length * scale * amount), (35 * scale) + (17 * scale * i) + (3 * scale), weapon_bar_colour_2, weapon_bar_colour_1, weapon_bar_colour_1, weapon_bar_colour_2, 0);
                    }
                    var text_colour = menu_colour;
                    if (i == menu_position && menu_state == "Weapons")
                    {
                        text_colour = 16777215;
                    }
                    var text_name = weapon_name_display;
                    draw_text_transformed_color((65 * scale) + (global.font_offset_x * scale), (21 * scale) + (17 * scale * i) + (global.font_offset_y * scale), string_upper(text_name), scale * global.font_scale, scale * global.font_scale, 0, text_colour, text_colour, text_colour, text_colour, 1);
                    if (disabled == true)
                    {
                        draw_text_transformed_color((65 * scale) + (global.font_offset_x * scale), (21 * scale) + (17 * scale * i) + (global.font_offset_y * scale), string_upper(text_name), scale * global.font_scale, scale * global.font_scale, 0, c_black, c_black, c_black, c_black, 0.5);
                    }
                }
            }
            if (menu_state == "Weapons")
            {
                draw_sprite_ext(spr_pause_cursor, 0, 25 * scale, (31 * scale) + (17 * scale * menu_position), scale, scale, 0, character_colour, 1);
                shader_set(shd_hue);
                shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), pause_hue);
                draw_sprite_ext(spr_pause_cursor, 1, 25 * scale, (31 * scale) + (17 * scale * menu_position), scale, scale, 0, c_white, 1);
                shader_reset();
            }
            for (var i = 0; i < (global.parts_amount - 1); i++)
            {
                draw_sprite_ext(spr_pause_parts, 0, (display_get_gui_width() - (171 * scale)) + (19 * i * scale), 148 * scale, scale, scale, 0, menu_colour, 1);
            }
            for (var i = 0; i < global.parts_amount; i++)
            {
                if (!is_undefined(ds_list_find_value(global.parts_equipped, i)))
                {
                    draw_sprite_ext(spr_partselect_icon, ds_list_find_value(global.parts_equipped, i), (display_get_gui_width() - (186 * scale)) + (19 * i * scale), 149 * scale, scale, scale, 0, c_white, 1);
                }
            }
            if (global.subtank_1 >= 0)
            {
                var animate = 0;
                if (menu_state == "Tanks" && menu_position == 0)
                {
                    animate = tank_animate / 3;
                }
                if (global.subtank_1 == global.tank_cap)
                {
                    draw_sprite_ext(spr_pickup_subtank_full, 0, display_get_gui_width() - (174 * scale), 197 * scale, scale, scale, 0, c_white, 1);
                }
                draw_sprite_ext(spr_pickup_subtank_1, animate, display_get_gui_width() - (174 * scale), 197 * scale, scale, scale, 0, c_white, 1);
                if (global.subtank_1 > 0)
                {
                    draw_rectangle_color(display_get_gui_width() - (187 * scale), 212 * scale, (display_get_gui_width() - (187 * scale)) + (26 * scale * (global.subtank_1 / global.tank_cap)), (212 * scale) + (3 * scale), c_yellow, c_lime, c_lime, c_yellow, 0);
                }
            }
            if (global.subtank_2 >= 0)
            {
                var animate = 0;
                if (menu_state == "Tanks" && menu_position == 1)
                {
                    animate = tank_animate / 3;
                }
                if (global.subtank_2 == global.tank_cap)
                {
                    draw_sprite_ext(spr_pickup_subtank_full, 0, (display_get_gui_width() - (174 * scale)) + (37 * scale), 197 * scale, scale, scale, 0, c_white, 1);
                }
                draw_sprite_ext(spr_pickup_subtank_2, animate, (display_get_gui_width() - (174 * scale)) + (37 * scale), 197 * scale, scale, scale, 0, c_white, 1);
                if (global.subtank_2 > 0)
                {
                    draw_rectangle_color((display_get_gui_width() - (187 * scale)) + (37 * scale), 212 * scale, (display_get_gui_width() - (187 * scale)) + (37 * scale) + (26 * scale * (global.subtank_2 / global.tank_cap)), (212 * scale) + (3 * scale), c_yellow, c_lime, c_lime, c_yellow, 0);
                }
            }
            if (global.weapontank >= 0)
            {
                var animate = 0;
                if (menu_state == "Tanks" && menu_position == 2)
                {
                    animate = tank_animate / 3;
                }
                if (global.weapontank == global.tank_cap)
                {
                    draw_sprite_ext(spr_pickup_weapontank_full, 0, (display_get_gui_width() - (174 * scale)) + (74 * scale), 197 * scale, scale, scale, 0, c_white, 1);
                }
                draw_sprite_ext(spr_pickup_weapontank, animate, (display_get_gui_width() - (174 * scale)) + (74 * scale), 197 * scale, scale, scale, 0, c_white, 1);
                if (global.weapontank > 0)
                {
                    draw_rectangle_color((display_get_gui_width() - (187 * scale)) + (74 * scale), 212 * scale, (display_get_gui_width() - (187 * scale)) + (74 * scale) + (26 * scale * (global.weapontank / global.tank_cap)), (212 * scale) + (3 * scale), c_yellow, c_orange, c_orange, c_yellow, 0);
                }
            }
            if (menu_state == "Options")
            {
                draw_sprite_ext(spr_pause_options, pause_animate / 3, (290 * scale) + (16 * scale * menu_position), display_get_gui_height() - (30 * scale), scale, scale, 0, character_colour, 1);
                shader_set(shd_hue);
                shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), pause_hue);
                draw_sprite_ext(spr_pause_options, pause_animate / 3, (290 * scale) + (16 * scale * menu_position), display_get_gui_height() - (30 * scale), scale, scale, 0, c_white, 1);
                shader_reset();
            }
            menu_description = "Nothing";
            switch (menu_state)
            {
                case "Weapons":
                    scr_weapon_menus(global.weapon[menu_position].type);
                    menu_description = weapon_description;
                    break;
                case "Tanks":
                    switch (menu_position)
                    {
                        case 0:
                        case 1:
                            menu_description = localtext("pause_desc_0");
                            break;
                        case 2:
                            menu_description = localtext("pause_desc_1");
                            break;
                    }
                    break;
                case "Options":
                    switch (menu_position)
                    {
                        case 0:
                            menu_description = localtext("pause_desc_2");
                            break;
                        case 1:
                            menu_description = localtext("pause_desc_3");
                            break;
                        case 2:
                            menu_description = localtext("pause_desc_4");
                            break;
                        case 3:
                            menu_description = localtext("pause_desc_5");
                            break;
                    }
                    break;
            }
            if (text_change != menu_description)
            {
                text_change = menu_description;
                text_scrolling = 0;
            }
            if (menu_description != "Nothing")
            {
                var text = string_copy(menu_description, 0, text_scrolling);
                draw_text_ext_transformed_colour((98 * scale) + (global.font_offset_x * scale), (display_get_gui_height() - (36 * scale)) + (global.font_offset_y * scale), text, 14 + global.font_seperation, 320, (scale / 2) * global.font_scale, (scale / 2) * global.font_scale, 0, 16777215, 16777215, 16777215, 16777215, 1);
            }
            break;
        case "Options":
            var scale = global.ui_scale / 1.25;
            if (room != rm_title)
            {
                draw_sprite_tiled_ext(spr_options_background, 0, pause_animate, pause_animate, 4, 4, c_white, 1);
            }
            else
            {
                draw_sprite_ext(spr_white_space, 0, 0, 0, room_width, room_height, 0, c_black, 1);
                draw_sprite_ext(spr_title_background, 0, display_get_gui_width() / 2, display_get_gui_height() / 2, 4, 4, 0, c_white, 1);
                draw_sprite_ext(spr_title_background, 1, title_eye_x, title_eye_y, 4, 4, 0, c_white, 1);
                draw_sprite_ext(spr_title_background, 2, display_get_gui_width() / 2, display_get_gui_height() / 2, 4, 4, 0, c_white, 1);
                draw_sprite_ext(spr_title_storm, 0, display_get_gui_width() / 2, display_get_gui_height() / 2, 2, 2, pause_animate * 0.5, c_dkgray, 1);
                draw_sprite_ext(spr_title_storm, 0, display_get_gui_width() / 2, display_get_gui_height() / 2, 3, 3, pause_animate * 0.75, c_dkgray, 1);
                draw_sprite_ext(spr_title_storm, 0, display_get_gui_width() / 2, display_get_gui_height() / 2, 4, 4, pause_animate, c_dkgray, 1);
                draw_sprite_ext(spr_title_storm, 0, display_get_gui_width() / 2, display_get_gui_height() / 2, 6, 6, pause_animate * 1.5, c_gray, 1);
                draw_sprite_ext(spr_title_storm, 0, display_get_gui_width() / 2, display_get_gui_height() / 2, 8, 8, pause_animate * 2, c_ltgray, 1);
                draw_sprite_ext(spr_title_lightning, 0, (display_get_gui_width() / 2) + (title_lightning._x * 4), (display_get_gui_height() / 2) + (title_lightning._y * 4), 2, 2, title_lightning.angle, title_lightning.colour, title_lightning.alpha);
                var _y = irandom(4);
                draw_sprite_tiled_ext(spr_scanlines, 0, 0, _y, 4, 4, c_white, 1);
            }
            var option_colour = 16777215;
            var select_colour = 557296;
            switch (global.pause_menu_sub)
            {
                case "Title":
                    if (title_state > 0)
                    {
                        with (obj_afterimage_gui)
                        {
                            gpu_set_blendmode(bm_add);
                            gpu_set_fog(true, image_blend, 0, 0);
                            draw_self();
                            gpu_set_blendmode(bm_normal);
                            gpu_set_fog(false, image_blend, 0, 0);
                        }
                        draw_sprite_ext(spr_title, global.language_title, display_get_gui_width() / 2, (display_get_gui_height() / 2) - (60 * scale), scale, scale, 0, c_white, 1);
                        for (var i = 0; i < 5; i++)
                        {
                            var text_sprite = spr_title_text;
                            if (menu_position == i && menu_position_horizontal == 0)
                            {
                                text_sprite = spr_title_text_highlighted;
                            }
                            if (i == 2)
                            {
                                draw_sprite_ext(spr_coop_title_menu, (menu_position == i && menu_position_horizontal == 0) ? 1 : 0, display_get_gui_width() / 2, (display_get_gui_height() / 2) + (50 * scale) + (14 * scale * i), scale, scale, 0, c_white, 1);
                            }
                            else
                            {
                                draw_sprite_ext(text_sprite, (i > 2) ? (i - 1) : i, display_get_gui_width() / 2, (display_get_gui_height() / 2) + (50 * scale) + (14 * scale * i), scale, scale, 0, c_white, 1);
                            }
                        }
                        draw_set_halign(fa_right);
                        scr_draw_text_outlined((display_get_gui_width() - (4 * scale)) + (global.font_offset_x * scale), (display_get_gui_height() - (15 * scale)) + (global.font_offset_y * scale), 0, 8421504, version, scale * global.font_scale);
                        draw_set_halign(fa_left);
                        var language_select = 8421504;
                        var language_alpha = 0.5;
                        if (menu_position_horizontal == 1)
                        {
                            language_select = 16777215;
                            language_alpha = 1;
                        }
                        draw_sprite_ext(spr_language, global.locale, 0, display_get_gui_height(), scale, scale, 0, language_select, language_alpha);
                        if (global.locale > 0)
                        {
                            draw_set_alpha(language_alpha);
                            scr_draw_text_outlined((scale * 44) + (global.font_offset_x * scale), (display_get_gui_height() - (27 * scale)) + (global.font_offset_y * scale), 0, language_select, localtext("credit"), scale * global.font_scale);
                            scr_draw_text_outlined((scale * 44) + (global.font_offset_x * scale), (display_get_gui_height() - (15 * scale)) + (global.font_offset_y * scale), 0, language_select, localtext("credit_name"), scale * global.font_scale);
                            draw_set_alpha(1);
                        }
                        draw_sprite_ext(spr_white_space, 0, x, y, room_width, room_height, 0, image_blend, title_white_alpha);
                        if (title_white_alpha > 0)
                        {
                            title_white_alpha -= 0.01;
                        }
                    }
                    break;
                case "Options":
                    menu_title = localtext("options_7");
                    for (var i = 0; i < 7; i++)
                    {
                        option_name = "Nothing";
                        option_select = option_colour;
                        var offset = 0;
                        if (room != rm_stage_select)
                        {
                            offset = 1;
                        }
                        switch (i + offset)
                        {
                            case 0:
                                option_name = localtext("options_0");
                                break;
                            case 1:
                                option_name = localtext("options_1");
                                break;
                            case 2:
                                option_name = localtext("options_2");
                                break;
                            case 3:
                                option_name = localtext("options_3");
                                break;
                            case 4:
                                option_name = localtext("options_4");
                                break;
                            case 5:
                                option_name = localtext("options_5");
                                if (room == rm_title)
                                {
                                    option_name = localtext("options_6");
                                }
                                break;
                            case 6:
                                if (room != rm_title)
                                {
                                    option_name = localtext("options_9");
                                }
                                break;
                        }
                        if (menu_position == (i + offset))
                        {
                            option_select = select_colour;
                        }
                        draw_set_halign(fa_center);
                        if (option_name != "Nothing")
                        {
                            draw_text_transformed_color((display_get_gui_width() / 2) + (global.font_offset_x * scale), 0 + (50 * scale) + (18 * scale * i) + (global.font_offset_y * scale), option_name, scale * global.font_scale, scale * global.font_scale, 0, option_select, option_select, option_select, option_select, 1);
                        }
                        draw_set_halign(fa_left);
                    }
                    break;
                case "Save Game":
                case "Load Game":
                    if (global.pause_menu_sub == "Load Game")
                    {
                        menu_title = localtext("options_8");
                    }
                    else
                    {
                        menu_title = localtext("options_0");
                    }
                    var autosave_offset = 0;
                    if (file_exists("save_0.txt") && global.pause_menu_sub == "Load Game")
                    {
                        autosave_offset = 1;
                    }
                    if (save_file == false)
                    {
                        if (file_exists("save_" + string((menu_position + 1) - autosave_offset) + ".txt"))
                        {
                            save_file = true;
                        }
                    }
                    var menu_colour = 12632256;
                    scr_get_character("X");
                    if (save_file == true)
                    {
                        if (save_import == 0)
                        {
                            save_import = import_json("save_" + string((menu_position + 1) - autosave_offset) + ".txt");
                        }
                        if (ds_map_exists(save_import, "save_playable_character"))
                        {
                            scr_get_character(ds_map_find_value(save_import, "save_playable_character"));
                            menu_colour = character_colour;
                        }
                    }
                    var _x = (display_get_gui_width() / 2) - (140 * scale);
                    var _y = 50 * scale;
                    draw_sprite_ext(spr_options_file, 0, _x, _y, scale, scale, 0, menu_colour, 0.7);
                    draw_sprite_ext(spr_options_file, 1, _x, _y, scale, scale, 0, menu_colour, 1);
                    shader_set(shd_hue);
                    shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), pause_hue);
                    draw_sprite_ext(spr_options_file, 2, _x, _y, scale, scale, 0, c_white, 1);
                    shader_reset();
                    for (var i = 0; i < (11 + autosave_offset); i++)
                    {
                        option_name = localtext("file_data") + " " + string((i + 1) - autosave_offset);
                        option_select = option_colour;
                        if (autosave_offset == 1 && i == 0)
                        {
                            option_name = localtext("file_autosave");
                        }
                        if (menu_position == i)
                        {
                            option_select = select_colour;
                        }
                        if (option_name != "Nothing")
                        {
                            draw_text_transformed_color(_x + (10 * scale) + (global.font_offset_x * scale), _y + (15 * scale * i) + (global.font_offset_y * scale), option_name, scale * global.font_scale, scale * global.font_scale, 0, option_select, option_select, option_select, option_select, 1);
                        }
                    }
                    draw_sprite_ext(spr_pause_cursor, 0, _x - (8 * scale), _y + (8 * scale) + (15 * scale * menu_position), scale, scale, 0, menu_colour, 1);
                    shader_set(shd_hue);
                    shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), pause_hue);
                    draw_sprite_ext(spr_pause_cursor, 1, _x - (8 * scale), _y + (8 * scale) + (15 * scale * menu_position), scale, scale, 0, c_white, 1);
                    shader_reset();
                    if (save_file == false)
                    {
                        if (file_exists("save_" + string((menu_position + 1) - autosave_offset) + ".txt"))
                        {
                            save_file = true;
                        }
                    }
                    if (save_file == true)
                    {
                        var weapon_sprite = spr_hud_weapon;
                        if (ds_map_exists(save_import, "save_playable_character"))
                        {
                            switch (ds_map_find_value(save_import, "save_playable_character"))
                            {
                                case "Zero":
                                    weapon_sprite = spr_hud_weapon_zero;
                                    break;
                                case "X":
                                    weapon_sprite = spr_hud_weapon;
                                    break;
                            }
                        }
                        if (ds_list_find_index(ds_map_find_value(save_import, "save_weapon"), "Yammark") != -1)
                        {
                            draw_sprite_ext(weapon_sprite, 1, _x + (70 * scale), _y + (24 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_list_find_index(ds_map_find_value(save_import, "save_weapon"), "Wolfang") != -1)
                        {
                            draw_sprite_ext(weapon_sprite, 2, _x + (70 * scale) + (19 * scale * 1), _y + (24 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_list_find_index(ds_map_find_value(save_import, "save_weapon"), "Heatnix") != -1)
                        {
                            draw_sprite_ext(weapon_sprite, 3, _x + (70 * scale) + (19 * scale * 2), _y + (24 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_list_find_index(ds_map_find_value(save_import, "save_weapon"), "Sharkplayer") != -1)
                        {
                            draw_sprite_ext(weapon_sprite, 4, _x + (70 * scale) + (19 * scale * 3), _y + (24 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_list_find_index(ds_map_find_value(save_import, "save_weapon"), "Scaravich") != -1)
                        {
                            draw_sprite_ext(weapon_sprite, 5, _x + (70 * scale), _y + (43 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_list_find_index(ds_map_find_value(save_import, "save_weapon"), "Turtloid") != -1)
                        {
                            draw_sprite_ext(weapon_sprite, 6, _x + (70 * scale) + (19 * scale * 1), _y + (43 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_list_find_index(ds_map_find_value(save_import, "save_weapon"), "Sheldon") != -1)
                        {
                            draw_sprite_ext(weapon_sprite, 7, _x + (70 * scale) + (19 * scale * 2), _y + (43 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_list_find_index(ds_map_find_value(save_import, "save_weapon"), "Mijinion") != -1)
                        {
                            draw_sprite_ext(weapon_sprite, 8, _x + (70 * scale) + (19 * scale * 3), _y + (43 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_list_find_index(ds_map_find_value(save_import, "save_weapon"), "Dragoon") != -1)
                        {
                            draw_sprite_ext(weapon_sprite, 9, _x + (70 * scale) + (19 * scale * 3), _y + (24 * scale), scale, scale, 0, c_white, 1);
                        }
                        draw_set_font(global.fnt_numbers);
                        scr_get_rank(ds_map_find_value(save_import, "save_rescue_list"));
                        for (var i = 0; i < (global.parts_amount - 1); i++)
                        {
                            draw_sprite_ext(spr_pause_parts, 0, _x + (77 * scale) + (19 * scale * i), _y + (66 * scale), scale, scale, 0, menu_colour, 1);
                        }
                        for (var i = 0; i < ds_list_size(ds_map_find_value(save_import, "save_parts_equipped")); i++)
                        {
                            draw_sprite_ext(spr_partselect_icon, ds_list_find_value(ds_map_find_value(save_import, "save_parts_equipped"), i), _x + (62 * scale) + (19 * scale * i), _y + (67 * scale), scale, scale, 0, c_white, 1);
                        }
                        draw_set_font(global.fnt_game);
                        draw_text_transformed_colour(_x + (70 * scale) + (global.font_offset_x * scale), _y + (80 * scale) + (global.font_offset_y * scale), localtext("file_parts") + ": " + string(ds_list_size(ds_map_find_value(save_import, "save_parts_owned"))), scale * global.font_scale, scale * global.font_scale, 0, c_white, c_white, c_white, c_white, 1);
                        draw_set_font(global.fnt_numbers);
                        if (ds_map_find_value(save_import, "save_subtank_1") > -1)
                        {
                            draw_sprite_ext(spr_pickup_subtank_1, 0, _x + (73 * scale), _y + (160 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_subtank_2") > -1)
                        {
                            draw_sprite_ext(spr_pickup_subtank_2, 0, _x + (101 * scale), _y + (160 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_weapontank") > -1)
                        {
                            draw_sprite_ext(spr_pickup_weapontank, 0, _x + (129 * scale), _y + (160 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_powertank") > 0)
                        {
                            draw_sprite_ext(spr_pickup_powertank, 0, _x + (155 * scale), _y + (162 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_blade_head_get") == true)
                        {
                            draw_sprite_ext(spr_options_armor, 0, _x + (61 * scale) + (15 * scale * 0), _y + (118 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_blade_chest_get") == true)
                        {
                            draw_sprite_ext(spr_options_armor, 1, _x + (61 * scale) + (15 * scale * 1), _y + (118 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_blade_arm_get") == true)
                        {
                            draw_sprite_ext(spr_options_armor, 2, _x + (61 * scale) + (15 * scale * 2), _y + (118 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_blade_leg_get") == true)
                        {
                            draw_sprite_ext(spr_options_armor, 3, _x + (61 * scale) + (15 * scale * 3), _y + (118 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_shadow_head_get") == true)
                        {
                            draw_sprite_ext(spr_options_armor, 4, _x + (61 * scale) + (15 * scale * 4), _y + (118 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_shadow_chest_get") == true)
                        {
                            draw_sprite_ext(spr_options_armor, 5, _x + (61 * scale) + (15 * scale * 5), _y + (118 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_shadow_arm_get") == true)
                        {
                            draw_sprite_ext(spr_options_armor, 6, _x + (61 * scale) + (15 * scale * 6), _y + (118 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_shadow_leg_get") == true)
                        {
                            draw_sprite_ext(spr_options_armor, 7, _x + (61 * scale) + (15 * scale * 7), _y + (118 * scale), scale, scale, 0, c_white, 1);
                        }
                        if (ds_map_find_value(save_import, "save_ng_cycle_max") > 0)
                        {
                            for (var a = 0; a < ds_map_find_value(save_import, "save_ng_cycle_max"); a++)
                            {
                                draw_sprite_ext(spr_option_ng_star, 0, _x + (196 * scale) + (12 * scale * a), _y - (6 * scale), scale, scale, 0, c_dkgray, 1);
                            }
                        }
                        if (ds_map_find_value(save_import, "save_ng_cycle") > 0)
                        {
                            for (var a = 0; a < ds_map_find_value(save_import, "save_ng_cycle"); a++)
                            {
                                draw_sprite_ext(spr_option_ng_star, 0, _x + (196 * scale) + (12 * scale * a), _y - (6 * scale), scale, scale, 0, c_white, 1);
                            }
                        }
                        draw_text_transformed_colour(_x + (201 * scale), _y + (11 * scale), string(ds_map_find_value(save_import, "save_game_completion")) + "%", scale, scale, 0, c_white, c_white, c_white, c_white, 1);
                        draw_text_transformed_colour(_x + (218 * scale), _y + (26 * scale), ds_map_find_value(save_import, "save_hearttank"), scale, scale, 0, c_white, c_white, c_white, c_white, 1);
                        draw_text_transformed_colour(_x + (218 * scale), _y + (43 * scale), ds_list_size(ds_map_find_value(save_import, "save_rescue_list")), scale, scale, 0, c_white, c_white, c_white, c_white, 1);
                        if (ds_map_exists(save_import, "save_playable_character"))
                        {
                            switch (ds_map_find_value(save_import, "save_playable_character"))
                            {
                                case "Zero":
                                    pal_swap_set(spr_player_zero_palette, 0, false);
                                    draw_sprite_ext(spr_player_zero_idle, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    if (ds_map_find_value(save_import, "save_zero_armour_black") == "Black Zero")
                                    {
                                        pal_swap_set(spr_player_zero_palette, 1, false);
                                        draw_sprite_ext(spr_player_zero_idle, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    }
                                    pal_swap_reset();
                                    break;
                                case "X":
                                default:
                                    pal_swap_set(spr_player_x_palette, 4, false);
                                    draw_sprite_ext(spr_player_x_idle, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    if (ds_map_find_value(save_import, "save_x_armour_chest") == "Blade Chest")
                                    {
                                        draw_sprite_ext(spr_player_x_idle_bladechest, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    }
                                    else if (ds_map_find_value(save_import, "save_x_armour_chest") == "Shadow Chest")
                                    {
                                        draw_sprite_ext(spr_player_x_idle_shadowchest, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    }
                                    if (ds_map_find_value(save_import, "save_x_armour_head") == "Blade Head")
                                    {
                                        draw_sprite_ext(spr_player_x_idle_bladehead, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    }
                                    else if (ds_map_find_value(save_import, "save_x_armour_head") == "Shadow Head")
                                    {
                                        draw_sprite_ext(spr_player_x_idle_shadowhead, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    }
                                    if (ds_map_find_value(save_import, "save_x_armour_leg") == "Blade Leg")
                                    {
                                        draw_sprite_ext(spr_player_x_idle_bladelegs, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    }
                                    else if (ds_map_find_value(save_import, "save_x_armour_leg") == "Shadow Leg")
                                    {
                                        draw_sprite_ext(spr_player_x_idle_shadowlegs, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    }
                                    if (ds_map_find_value(save_import, "save_x_armour_arm") == "Blade Arm")
                                    {
                                        draw_sprite_ext(spr_player_x_idle_bladearms, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    }
                                    else if (ds_map_find_value(save_import, "save_x_armour_arm") == "Shadow Arm")
                                    {
                                        draw_sprite_ext(spr_player_x_idle_shadowarms, pause_animate / 12, _x + (262 * scale), _y + (38 * scale), -scale, scale, 0, c_white, 1);
                                    }
                                    pal_swap_reset();
                                    break;
                            }
                        }
                        draw_sprite_ext(spr_pause_rank, rank_letter, _x + (265 * scale), _y + (70 * scale), scale, scale, 0, c_white, 1);
                        draw_text_transformed_colour(_x + (218 * scale), _y + (80 * scale), ds_map_find_value(save_import, "save_nightmare_souls"), scale, scale, 0, c_white, c_white, c_white, c_white, 1);
                        var draw_seconds = (ds_map_find_value(save_import, "save_playtime") div 60) % 60;
                        var draw_minutes = (ds_map_find_value(save_import, "save_playtime") div 3600) % 60;
                        var draw_hours = (ds_map_find_value(save_import, "save_playtime") div 216000) % 60;
                        var playtime = string_repeat("0", max(0, 2 - string_length(string(draw_hours)))) + string(draw_hours) + ":" + string_repeat("0", max(0, 2 - string_length(string(draw_minutes)))) + string(draw_minutes) + ":" + string_repeat("0", max(0, 2 - string_length(string(draw_seconds)))) + string(draw_seconds);
                        draw_text_transformed_colour(_x + (218 * scale), _y + (98 * scale), playtime, scale, scale, 0, c_white, c_white, c_white, c_white, 1);
                        draw_set_font(global.fnt_game);
                    }
                    draw_sprite_ext(spr_options_file, 3, _x, _y, scale, scale, 0, c_white, save_flash);
                    break;
                case "Game":
                    menu_title = localtext("options_1");
                    var amount = 7;
                    if (global.ng_cycle > 0 && room == rm_stage_select)
                    {
                        amount = 8;
                    }
                    for (var i = 0; i < amount; i++)
                    {
                        option_name = "Nothing";
                        option_choice = "Nothing";
                        option_select = option_colour;
                        switch (i)
                        {
                            case 0:
                                option_name = localtext("game_0");
                                option_choice = localtext("choice_off");
                                if (global.indicators == true)
                                {
                                    option_choice = localtext("choice_on");
                                }
                                break;
                            case 1:
                                option_name = localtext("game_1");
                                option_choice = localtext("choice_off");
                                if (global.cutscene_skip == true)
                                {
                                    option_choice = localtext("choice_on");
                                }
                                break;
                            case 2:
                                option_name = localtext("game_2");
                                option_choice = localtext("choice_off");
                                if (global.lives_toggle == true)
                                {
                                    option_choice = localtext("choice_on");
                                }
                                break;
                            case 3:
                                option_name = localtext("game_3");
                                switch (global.result_display)
                                {
                                    case 0:
                                        option_choice = localtext("choice_off");
                                        break;
                                    case 1:
                                        option_choice = localtext("performance_0");
                                        break;
                                    case 2:
                                        option_choice = localtext("performance_1");
                                        break;
                                }
                                break;
                            case 4:
                                option_name = localtext("game_4");
                                option_choice = localtext("choice_high");
                                if (global.gaichuuin_visability == true)
                                {
                                    option_choice = localtext("choice_low");
                                }
                                break;
                            case 5:
                                option_name = localtext("game_5");
                                option_choice = localtext("choice_off");
                                if (global.music_custom == true)
                                {
                                    option_choice = localtext("choice_on");
                                }
                                break;
                            case 6:
                                option_name = localtext("game_6");
                                option_choice = localtext("choice_off");
                                if (global.x4_charge_shot == true)
                                {
                                    option_choice = localtext("choice_on");
                                }
                                break;
                            case 7:
                                option_name = localtext("game_7");
                                option_choice = global.ng_cycle;
                                break;
                        }
                        if (menu_position == i)
                        {
                            option_select = select_colour;
                        }
                        if (option_name != "Nothing")
                        {
                            draw_text_transformed_color(((display_get_gui_width() / 2) - (90 * scale)) + (global.font_offset_x * scale), 0 + (50 * scale) + (18 * scale * i) + (global.font_offset_y * scale), option_name, scale * global.font_scale, scale * global.font_scale, 0, option_select, option_select, option_select, option_select, 1);
                        }
                        draw_set_halign(fa_right);
                        if (option_choice != "Nothing")
                        {
                            draw_text_transformed_color((display_get_gui_width() / 2) + (90 * scale) + (global.font_offset_x * scale), 0 + (50 * scale) + (18 * scale * i) + (global.font_offset_y * scale), option_choice, scale * global.font_scale, scale * global.font_scale, 0, option_select, option_select, option_select, option_select, 1);
                        }
                        draw_set_halign(fa_left);
                    }
                    break;
                case "Audio":
                    menu_title = localtext("options_2");
                    for (var i = 0; i < 3; i++)
                    {
                        option_name = "Nothing";
                        option_choice = "Nothing";
                        option_select = option_colour;
                        switch (i)
                        {
                            case 0:
                                option_name = localtext("audio_0");
                                option_choice = string(round(global.volume_master * 100)) + "%";
                                break;
                            case 1:
                                option_name = localtext("audio_1");
                                option_choice = string(round(global.volume_music * 100)) + "%";
                                break;
                            case 2:
                                option_name = localtext("audio_2");
                                option_choice = string(round(global.volume_effect * 100)) + "%";
                                break;
                        }
                        if (menu_position == i)
                        {
                            option_select = select_colour;
                        }
                        if (option_name != "Nothing")
                        {
                            draw_text_transformed_color(((display_get_gui_width() / 2) - (90 * scale)) + (global.font_offset_x * scale), 0 + (50 * scale) + (18 * scale * i) + (global.font_offset_y * scale), option_name, scale * global.font_scale, scale * global.font_scale, 0, option_select, option_select, option_select, option_select, 1);
                        }
                        draw_set_halign(fa_right);
                        if (option_choice != "Nothing")
                        {
                            draw_text_transformed_color((display_get_gui_width() / 2) + (90 * scale) + (global.font_offset_x * scale), 0 + (50 * scale) + (18 * scale * i) + (global.font_offset_y * scale), option_choice, scale * global.font_scale, scale * global.font_scale, 0, option_select, option_select, option_select, option_select, 1);
                        }
                        draw_set_halign(fa_left);
                    }
                    break;
                case "Visual":
                    menu_title = localtext("options_3");
                    for (var i = 0; i < 6; i++)
                    {
                        option_name = "Nothing";
                        option_choice = "Nothing";
                        option_select = option_colour;
                        option_alpha = 1;
                        if (menu_position == i)
                        {
                            option_select = select_colour;
                        }
                        switch (i)
                        {
                            case 0:
                                option_name = localtext("visual_4");
                                var _modes = [localtext("window_mode_0"), localtext("window_mode_1"), localtext("window_mode_2")];
                                option_choice = _modes[window_mode];
                                break;
                            case 1:
                                option_name = localtext("visual_5");
                                option_choice = "x" + string(window_size);
                                if (window_mode > 0)
                                {
                                    option_alpha = 0.5;
                                }
                                break;
                            case 2:
                                option_name = localtext("visual_6");
                                var _modes = [localtext("window_res_0"), localtext("window_res_1")];
                                option_choice = _modes[window_resolution];
                                break;
                            case 3:
                                option_name = localtext("visual_1");
                                option_choice = localtext("choice_off");
                                if (global.fps_display == true)
                                {
                                    option_choice = localtext("choice_on");
                                }
                                break;
                            case 4:
                                option_name = localtext("visual_2");
                                option_choice = string_format(global.ui_scale, 1, 1);
                                break;
                            case 5:
                                option_name = localtext("visual_3");
                                option_choice = localtext("choice_off");
                                if (global.vsync == true)
                                {
                                    option_choice = localtext("choice_on");
                                }
                                break;
                        }
                        if (option_name != "Nothing")
                        {
                            draw_text_transformed_color(((display_get_gui_width() / 2) - (90 * scale)) + (global.font_offset_x * scale), 0 + (50 * scale) + (18 * scale * i) + (global.font_offset_y * scale), option_name, scale * global.font_scale, scale * global.font_scale, 0, option_select, option_select, option_select, option_select, option_alpha);
                        }
                        draw_set_halign(fa_right);
                        if (option_choice != "Nothing")
                        {
                            draw_text_transformed_color((display_get_gui_width() / 2) + (90 * scale) + (global.font_offset_x * scale), 0 + (50 * scale) + (18 * scale * i) + (global.font_offset_y * scale), option_choice, scale * global.font_scale, scale * global.font_scale, 0, option_select, option_select, option_select, option_select, option_alpha);
                        }
                        draw_set_halign(fa_left);
                    }
                    break;
                case "Controls":
                    menu_title = localtext("options_4");
                    for (var i = 0; i < 6; i++)
                    {
                        option_name = "Nothing";
                        option_choice = "Nothing";
                        option_select = option_colour;
                        switch (i)
                        {
                            case 0:
                                option_name = localtext("controls_0");
                                option_choice = localtext("choice_off");
                                if (controller_toggle == true)
                                {
                                    option_choice = localtext("choice_on");
                                }
                                break;
                            case 1:
                                option_name = localtext("controls_1");
                                break;
                            case 2:
                                option_name = localtext("controls_3");
                                option_choice = localtext("choice_off");
                                if (global.rapidfire == true)
                                {
                                    option_choice = localtext("choice_on");
                                }
                                break;
                            case 3:
                                option_name = localtext("controls_4");
                                option_choice = localtext("choice_off");
                                if (global.autocharge)
                                {
                                    option_choice = localtext("choice_on");
                                }
                                break;
                            case 4:
                                option_name = "Tag Swap Key";
                                option_choice = (tag_binding_mode == 1) ? "..." : tagteam_key_name(global.tag_swap_key);
                                break;
                            case 5:
                                option_name = "Tag Swap Pad";
                                option_choice = (tag_binding_mode == 2) ? "..." : scr_controllerbinds(global.tag_swap_pad);
                                break;
                        }
                        if (menu_position == i)
                        {
                            option_select = select_colour;
                        }
                        if (option_name != "Nothing")
                        {
                            draw_text_transformed_color(((display_get_gui_width() / 2) - (90 * scale)) + (global.font_offset_x * scale), 0 + (50 * scale) + (18 * scale * i) + (global.font_offset_y * scale), option_name, scale * global.font_scale, scale * global.font_scale, 0, option_select, option_select, option_select, option_select, 1);
                        }
                        draw_set_halign(fa_right);
                        if (option_choice != "Nothing")
                        {
                            draw_text_transformed_color((display_get_gui_width() / 2) + (90 * scale) + (global.font_offset_x * scale), 0 + (50 * scale) + (18 * scale * i) + (global.font_offset_y * scale), option_choice, scale * global.font_scale, scale * global.font_scale, 0, option_select, option_select, option_select, option_select, 1);
                        }
                        draw_set_halign(fa_left);
                    }
                    break;
                case "Bindings":
                    menu_title = localtext("controls_1");
                    if (global.controller == true)
                    {
                        for (var i = 0; i < 7; i++)
                        {
                            var x_pos = (display_get_gui_width() / 2) - (10 * scale);
                            var y_pos = 70 * scale;
                            var colour = option_colour;
                            if (menu_position == i)
                            {
                                colour = select_colour;
                            }
                            var offset_x = -40;
                            var offset_y = 0;
                            for (var a = 0; a < 7; a++)
                            {
                                key_list[a] = localtext("bindings_" + string(a + 4));
                            }
                            draw_text_transformed_color(x_pos + (offset_x * scale) + (global.font_offset_x * scale), y_pos + (12 * scale * (i + offset_y)) + (global.font_offset_y * scale), key_list[i], scale * global.font_scale, scale * global.font_scale, 0, colour, colour, colour, colour, 1);
                            scr_controllerbinds(controller[i + 4]);
                            var key_display = button;
                            if (key_select == true && menu_position == i)
                            {
                                key_display = "...";
                            }
                            draw_text_transformed_color(x_pos + ((offset_x + 100) * scale) + (global.font_offset_x * scale), y_pos + (12 * scale * (i + offset_y)) + (global.font_offset_y * scale), key_display, scale * global.font_scale, scale * global.font_scale, 0, colour, colour, colour, colour, 1);
                        }
                    }
                    else
                    {
                        for (var i = 0; i < (array_length(keyboard) - 1); i++)
                        {
                            var x_pos = (display_get_gui_width() / 2) - (55 * scale);
                            var y_pos = 70 * scale;
                            var colour = option_colour;
                            if (menu_position == i)
                            {
                                colour = select_colour;
                            }
                            var offset_x = -80;
                            var offset_y = 0;
                            if (i > 10)
                            {
                                offset_x = 55;
                                offset_y = -11;
                            }
                            for (var a = 0; a < 19; a++)
                            {
                                key_list[a] = localtext("bindings_" + string(a));
                            }
                            draw_text_transformed_color(x_pos + (offset_x * scale) + (global.font_offset_x * scale), y_pos + (12 * scale * (i + offset_y)) + (global.font_offset_y * scale), key_list[i], scale * global.font_scale, scale * global.font_scale, 0, colour, colour, colour, colour, 1);
                            scr_keybinds();
                            var key_display = key[keyboard[i]];
                            if (key_select == true && menu_position == i)
                            {
                                key_display = "...";
                            }
                            draw_text_transformed_color(x_pos + ((offset_x + 100) * scale) + (global.font_offset_x * scale), y_pos + (12 * scale * (i + offset_y)) + (global.font_offset_y * scale), key_display, scale * global.font_scale, scale * global.font_scale, 0, colour, colour, colour, colour, 1);
                        }
                    }
                    draw_set_halign(fa_center);
                    if (key_select == false)
                    {
                        draw_text_transformed_color((display_get_gui_width() / 2) + (10 * scale) + (global.font_offset_x * scale), (display_get_gui_height() - (20 * scale)) + (global.font_offset_y * scale), localtext("bindings_guide_0"), scale * global.font_scale, scale * global.font_scale, 0, c_white, c_white, c_white, c_white, 1);
                    }
                    else
                    {
                        draw_text_transformed_color((display_get_gui_width() / 2) + (10 * scale) + (global.font_offset_x * scale), (display_get_gui_height() - (20 * scale)) + (global.font_offset_y * scale), localtext("bindings_guide_1"), scale * global.font_scale, scale * global.font_scale, 0, c_white, c_white, c_white, c_white, 1);
                    }
                    draw_set_halign(fa_left);
                    break;
            }
            if (global.pause_menu_sub != "Title")
            {
                draw_set_font(global.fnt_larger);
                draw_set_halign(fa_center);
                draw_text_transformed_color((display_get_gui_width() / 2) - (6 * scale), 0 + (20 * scale), string_upper(menu_title), scale, scale, 0, c_white, c_white, c_white, c_white, 1);
                draw_set_halign(fa_left);
                draw_set_font(global.fnt_game);
            }
            if (global.pause_menu_sub != "Title")
            {
                if (room != rm_stage_select)
                {
                }
                else
                {
                    scale = global.ui_scale / 1.25;
                    draw_sprite_ext(spr_stageselect_words_frame, pause_animate / 5, -(11 * scale), display_get_gui_height(), scale, scale, 0, c_white, 1);
                    draw_sprite_ext(spr_stageselect_words_frame, pause_animate / 5, display_get_gui_width() + (11 * scale), display_get_gui_height(), -scale, scale, 0, c_white, 1);
                    draw_sprite_ext(spr_stageselect_words_library, pause_animate / 5, 57 * scale, display_get_gui_height() - (13 * scale), scale, scale, 0, c_white, 1);
                    draw_sprite_ext(spr_stageselect_words_parts, pause_animate / 5, display_get_gui_width() - (57 * scale), display_get_gui_height() - (13 * scale), scale, scale, 0, c_white, 1);
                }
            }
            break;
        case "Stage Select":
            var scale = global.ui_scale / 1.25;
            draw_sprite_ext(spr_white_space, 0, x, y, room_width, room_height, 0, c_black, 1);
            scr_get_level(menu_position);
            if (level_background != "Nothing" && stageselect_state > 1)
            {
                var background_animate = 0;
                if (level_background == spr_bg_mijinion)
                {
                    background_animate = pause_animate / 10;
                }
                else if (level_background == spr_bg_WOOHOOLAB)
                {
                    background_animate = pause_animate / 10;
                }
                else if (level_background == spr_bg_heatnix_purple)
                {
                    background_animate = pause_animate / 6;
                }
                if (level_background == spr_bg_mijinion)
                {
                    draw_sprite_ext(level_background, background_animate, display_get_gui_width() / 2, 0, 3.75, 3.75, 0, c_white, 1);
                    gpu_set_blendmode(bm_add);
                    draw_sprite_ext(level_background, background_animate, display_get_gui_width() / 2, 0, 3.75, 3.75, 0, level_colour, 1);
                    gpu_set_blendmode(bm_normal);
                }
                else
                {
                    draw_sprite_tiled_ext(level_background, background_animate, pause_animate * 2, 0, 5, 5, c_white, 1);
                    gpu_set_blendmode(bm_add);
                    draw_sprite_tiled_ext(level_background, background_animate, pause_animate * 2, 0, 5, 5, level_colour, 1);
                    gpu_set_blendmode(bm_normal);
                }
            }
            draw_sprite_ext(spr_stageselect_gradient, 0, display_get_gui_width() / 2, -175, 10, 5, 0, level_colour, 1);
            draw_sprite_ext(spr_stageselect_gradient, 0, display_get_gui_width() / 2, display_get_gui_height() + 175, 10, -5, 0, level_colour, 1);
            gpu_set_blendmode(bm_add);
            draw_sprite_tiled_ext(spr_pause_grid, 0, pause_animate, pause_animate, 2.5, 2.5, level_colour, 0.3);
            gpu_set_blendmode(bm_normal);
            draw_sprite_tiled_ext(spr_stageselect_static, pause_animate, 0, 0, 4, 4, c_white, stageselect_bg_static);
            draw_sprite_ext(spr_white_space, 0, x, y, room_width, room_height, 0, c_white, stageselect_bg_swap);
            var pos_x = display_get_gui_width() / 2;
            var pos_y = (display_get_gui_height() / 2) + (8 * scale);
            draw_sprite_ext(spr_stageselect, 0, pos_x, pos_y, scale, scale, 0, c_white, 1);
            
            function scr_get_position(arg0)
            {
                select_x = 0;
                select_y = 0;
                switch (arg0)
                {
                    case 0:
                        select_x = -137;
                        select_y = -58;
                        break;
                    case 1:
                        select_x = -76;
                        select_y = -92;
                        break;
                    case 2:
                        select_x = 76;
                        select_y = -92;
                        break;
                    case 3:
                        select_x = 137;
                        select_y = -58;
                        break;
                    case 2.5:
                        select_x = 0;
                        select_y = -107;
                        break;
                    case 4:
                        select_x = -137;
                        select_y = 58;
                        break;
                    case 5:
                        select_x = -76;
                        select_y = 92;
                        break;
                    case 6:
                        select_x = 76;
                        select_y = 92;
                        break;
                    case 7:
                        select_x = 137;
                        select_y = 58;
                        break;
                }
            }
            
            for (var i = 0; i < 8; i++)
            {
                scr_get_position(i);
                scr_get_level(i);
                if (ds_list_find_index(global.level_list, level_destination) == -1)
                {
                    draw_sprite_ext(spr_stageselect_portrait, i, pos_x + (select_x * scale), pos_y + (select_y * scale), scale, scale, 0, c_white, 1);
                }
                else
                {
                    draw_sprite_ext(spr_stageselect_portrait_completed, i, pos_x + (select_x * scale), pos_y + (select_y * scale), scale, scale, 0, c_white, 1);
                }
                scr_get_level(menu_position);
                if (menu_position != i)
                {
                    draw_sprite_ext(spr_stageselect_overlay, 0, pos_x + (select_x * scale), pos_y + (select_y * scale), scale, scale, 0, c_black, 0.5);
                    draw_sprite_ext(spr_stageselect_portrait_static, pause_animate, pos_x + (select_x * scale), pos_y + (select_y * scale), scale, scale, 0, c_white, 0.075);
                }
                if (stageselect[i].alpha > 1)
                {
                    draw_sprite_ext(spr_stageselect_overlay, 0, pos_x + (select_x * scale), pos_y + (select_y * scale), scale, scale, 0, #101008, 1);
                }
                else
                {
                    draw_sprite_ext(spr_stageselect_overlay, 0, pos_x + (select_x * scale), pos_y + (select_y * scale), scale, scale, 0, c_white, stageselect[i].alpha);
                }
            }
            if (stageselect_state > 1)
            {
                scr_get_position(menu_position);
                draw_sprite_ext(spr_stageselect_select, pause_animate / 5, pos_x + (select_x * scale), pos_y + (select_y * scale), scale, scale, 0, c_white, 1);
                draw_set_halign(fa_center);
                draw_set_font(global.fnt_larger);
                draw_text_ext_transformed_color((display_get_gui_width() / 2) + (116 * scale), (display_get_gui_height() / 2) - (2 * scale), level_name, 15, 10 * scale, scale / 1.25, scale / 1.25, 0, 16777215, 16777215, 16777215, 16777215, 1);
                var fnt_percent = font_add_sprite_ext(spr_font_percentage, "1234567890% ", true, 0);
                var percent_colour = 16777215;
                draw_set_font(fnt_percent);
                scr_get_level_completion(level_destination);
                if (completion >= 100)
                {
                    percent_colour = 65535;
                }
                draw_text_transformed_color((display_get_gui_width() / 2) - (115 * scale), (display_get_gui_height() / 2) - (7 * scale), string(completion) + "%", scale, scale, 0, percent_colour, percent_colour, percent_colour, percent_colour, 1);
                draw_set_font(global.fnt_game);
                for (var i = 0; i < array_length(collectibles_icon); i++)
                {
                    if (collectibles_icon[i] > -1)
                    {
                        var offset = 0;
                        if ((i % 2) != 0)
                        {
                            offset = 10;
                        }
                        draw_sprite_ext(spr_stageselect_completed, collectibles_icon[i], ((display_get_gui_width() / 2) - (135 * scale)) + (10 * scale * i), (display_get_gui_height() / 2) + (12 * scale) + (offset * scale), scale, scale, 0, c_white, 1);
                    }
                }
                draw_set_halign(fa_left);
                if (level_name != localtext("lvl_name_debug"))
                {
                    draw_sprite_ext(spr_stageselect_map, pause_animate / 5, (display_get_gui_width() / 2) + (level_map_x * scale), (display_get_gui_height() / 2) + (level_map_y * scale), scale, scale, 0, c_white, 1);
                }
            }
            draw_sprite_ext(spr_stageselect_words_frame, pause_animate / 5, -(11 * scale), display_get_gui_height(), scale, scale, 0, c_white, 1);
            draw_sprite_ext(spr_stageselect_words_frame, pause_animate / 5, display_get_gui_width() + (11 * scale), display_get_gui_height(), -scale, scale, 0, c_white, 1);
            if (stageselect_state > 1)
            {
                draw_sprite_ext(spr_stageselect_words_parts, pause_animate / 5, 57 * scale, display_get_gui_height() - (13 * scale), scale, scale, 0, c_white, 1);
                draw_sprite_ext(spr_stageselect_words_library, pause_animate / 5, display_get_gui_width() - (57 * scale), display_get_gui_height() - (13 * scale), scale, scale, 0, c_white, 1);
            }
            break;
        case "Part Selection":
            scr_get_character(global.playable_character.name);
            var menu_colour = character_colour;
            var menu_hue = pause_hue;
            draw_sprite_ext(spr_white_space, 0, x, y, room_width, room_height, 0, menu_colour, 1);
            draw_sprite_ext(spr_white_space, 0, x, y, room_width, room_height, 0, c_black, 0.5);
            draw_sprite_ext(spr_pause_gradient, 1, display_get_gui_width() / 2, display_get_gui_height() / 2, 10, 5, 0, c_white, 1);
            draw_sprite_ext(spr_pause_gradient, 1, display_get_gui_width() / 2, display_get_gui_height() / 2, 10, -5, 0, c_white, 1);
            gpu_set_blendmode(bm_add);
            draw_sprite_tiled_ext(spr_pause_grid, 0, pause_animate, pause_animate, 2.5, 2.5, menu_colour, 0.3);
            gpu_set_blendmode(bm_normal);
            var scale = global.ui_scale / 1.25;
            var menu_pos_x = 25;
            var menu_pos_y = 100;
            var offset = 0;
            
            function scr_part_catagory(arg0, arg1, arg2, arg3, arg4, arg5)
            {
                draw_sprite_ext(spr_partselect_catagory, 0, arg1 * arg4, arg2 * arg4, arg4, arg4, 0, arg5, 1);
                var select_colour = arg5;
                if (menu_position == arg0)
                {
                    select_colour = 16777215;
                }
                draw_text_transformed_color((arg1 * arg4) + (10 * arg4) + (global.font_offset_x * arg4), ((arg2 * arg4) - (2 * arg4)) + (global.font_offset_y * arg4), arg3, arg4 * global.font_scale, arg4 * global.font_scale, 0, select_colour, select_colour, select_colour, select_colour, 1);
            }
            
            draw_sprite_ext(spr_pause_cursor, 0, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (17 * scale * menu_position) + (6 * scale), scale, scale, 0, menu_colour, 1);
            shader_set(shd_hue);
            shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), pause_hue);
            draw_sprite_ext(spr_pause_cursor, 1, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (17 * scale * menu_position) + (6 * scale), scale, scale, 0, c_white, 1);
            shader_reset();
            scr_part_catagory(0, menu_pos_x, menu_pos_y + 0, localtext("shop_menu_0"), scale, menu_colour);
            scr_part_catagory(1, menu_pos_x, menu_pos_y + 17, localtext("shop_menu_1"), scale, menu_colour);
            scr_part_catagory(2, menu_pos_x, menu_pos_y + 34, localtext("shop_menu_2"), scale, menu_colour);
            scr_part_catagory(3, menu_pos_x, menu_pos_y + 51, localtext("shop_menu_6"), scale, menu_colour);
            if (global.zero_unlock == true)
            {
                offset += 1;
                if (global.playable_character.name == "Zero")
                {
                    scr_part_catagory(4, menu_pos_x, menu_pos_y + 68, localtext("shop_menu_5"), scale, menu_colour);
                }
                else
                {
                    scr_part_catagory(4, menu_pos_x, menu_pos_y + 68, localtext("shop_menu_4"), scale, menu_colour);
                }
            }
            var soul_x_pos = menu_pos_x * scale;
            var soul_y_pos = (menu_pos_y * scale) + (17 * scale * (5 + offset)) + (10 * scale);
            draw_sprite_ext(spr_hud_souls, pause_animate / 7, soul_x_pos, soul_y_pos, global.ui_scale, global.ui_scale, 0, c_white, 1);
            var soul_text = string_repeat("0", max(0, 5 - string_length(string(global.nightmare_souls)))) + string(global.nightmare_souls);
            var soul_text_colour = 16024640;
            draw_set_font(global.fnt_numbers);
            draw_text_transformed_color(soul_x_pos + (28 * global.ui_scale), soul_y_pos - (16 * global.ui_scale), soul_text, global.ui_scale, global.ui_scale, 0, soul_text_colour, soul_text_colour, soul_text_colour, soul_text_colour, 1);
            draw_set_font(global.fnt_game);
            if (global.pause_menu_sub != "Options")
            {
                menu_pos_x = 170;
                menu_pos_y = 60;
                
                function scr_part_item(arg0, arg1, arg2, arg3, arg4, arg5)
                {
                    scr_get_part(arg3);
                    var select_colour = arg5;
                    if (menu_position_sub == arg0)
                    {
                        select_colour = 16777215;
                    }
                    if (arg3 == 902 || arg3 == 903)
                    {
                        tagteam_upgrade_icon(arg3, (arg1 * arg4) + arg4, (arg2 * arg4) + (2 * arg4), arg4);
                    }
                    else
                    {
                        draw_sprite_ext(spr_partselect_icon, arg3, (arg1 * arg4) + (1 * arg4), (arg2 * arg4) + (2 * arg4), arg4, arg4, 0, c_white, 1);
                    }
                    draw_sprite_ext(spr_partselect_item, 0, arg1 * arg4, arg2 * arg4, arg4, arg4, 0, arg5, 1);
                    draw_sprite_ext(spr_partselect_item, 1, arg1 * arg4, arg2 * arg4, arg4, arg4, 0, c_white, 1);
                    draw_text_transformed_color((arg1 * arg4) + (28 * arg4) + (global.font_offset_x * arg4), (arg2 * arg4) + (0 * arg4) + (global.font_offset_y * arg4), (arg3 == 902) ? "Separate HP" : ((arg3 == 903) ? "Separate Energy" : part_name), arg4 * global.font_scale, arg4 * global.font_scale, 0, select_colour, select_colour, select_colour, select_colour, 1);
                }
                
                var length = 10;
                switch (global.pause_menu_sub)
                {
                    case "Equip":
                        for (var i = 0; i < length; i++)
                        {
                            if (ds_list_size(global.parts_owned) > i)
                            {
                                scr_part_item(i, menu_pos_x, menu_pos_y + (19 * i), ds_list_find_value(global.parts_owned, i + scroll), scale, menu_colour);
                                var find = ds_list_find_value(global.parts_owned, i + scroll);
                                if ((find == 902 || find == 903) ? tagteam_upgrade_enabled(find) : (ds_list_find_index(global.parts_equipped, find) != -1))
                                {
                                    draw_sprite_ext(spr_partselect_item, 2, menu_pos_x * scale, (menu_pos_y * scale) + (19 * i * scale), scale, scale, 0, c_white, 1);
                                }
                            }
                        }
                        draw_sprite_ext(spr_pause_cursor, 0, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (19 * scale * menu_position_sub) + (9 * scale), scale, scale, 0, menu_colour, 1);
                        shader_set(shd_hue);
                        shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), pause_hue);
                        draw_sprite_ext(spr_pause_cursor, 1, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (19 * scale * menu_position_sub) + (9 * scale), scale, scale, 0, c_white, 1);
                        arrow = dsin(current_time * 0.4) * 4;
                        if (scroll > 0)
                        {
                            draw_sprite_ext(spr_partselect_scroll, 1, (menu_pos_x * scale) + (80 * scale), ((menu_pos_y * scale) - (10 * scale)) + arrow, scale, scale, 0, c_white, 1);
                        }
                        if ((length_limit + scroll) < ds_list_size(global.parts_owned))
                        {
                            draw_sprite_ext(spr_partselect_scroll, 0, (menu_pos_x * scale) + (80 * scale), ((menu_pos_y * scale) + (19 * scale * length_limit) + (10 * scale)) - arrow, scale, scale, 0, c_white, 1);
                        }
                        shader_reset();
                        draw_sprite_ext(spr_partselect_equipped, 0, (menu_pos_x * scale) + (160 * scale), (menu_pos_y * scale) + (1 * scale), scale, scale, 0, menu_colour, 1);
                        for (var i = 1; i < global.parts_amount; i++)
                        {
                            draw_sprite_ext(spr_partselect_equipped, 1, (menu_pos_x * scale) + (160 * scale), ((menu_pos_y * scale) - (2 * scale)) + (24 * scale * i), scale, scale, 0, menu_colour, 1);
                            shader_set(shd_hue);
                            shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), pause_hue);
                            draw_sprite_ext(spr_partselect_equipped, 2, (menu_pos_x * scale) + (160 * scale), ((menu_pos_y * scale) - (2 * scale)) + (24 * scale * i), scale, scale, 0, c_white, 1);
                            shader_reset();
                        }
                        for (var i = 0; i < global.parts_amount; i++)
                        {
                            if (!is_undefined(ds_list_find_value(global.parts_equipped, i)))
                            {
                                draw_sprite_ext(spr_partselect_icon, ds_list_find_value(global.parts_equipped, i), (menu_pos_x * scale) + (161 * scale), (menu_pos_y * scale) + (2 * scale) + (24 * scale * i), scale, scale, 0, c_white, 1);
                            }
                        }
                        break;
                    case "Develop":
                        for (var i = 0; i < length; i++)
                        {
                            if (ds_list_size(global.parts_store) > i)
                            {
                                scr_part_item(i, menu_pos_x, menu_pos_y + (19 * i), ds_list_find_value(global.parts_store, i + scroll), scale, menu_colour);
                                var select_colour = menu_colour;
                                if (part_cost > global.nightmare_souls)
                                {
                                    select_colour = 4210752;
                                }
                                if (menu_position_sub == i)
                                {
                                    select_colour = 16777215;
                                    if (part_cost > global.nightmare_souls)
                                    {
                                        select_colour = 8421504;
                                    }
                                }
                                draw_sprite_ext(spr_partselect_cost, 0, (menu_pos_x * scale) + (135 * scale), (menu_pos_y * scale) + (19 * i * scale), scale, scale, 0, menu_colour, 1);
                                draw_sprite_ext(spr_partselect_cost, 1, (menu_pos_x * scale) + (135 * scale), (menu_pos_y * scale) + (19 * i * scale), scale, scale, 0, select_colour, 1);
                                draw_set_font(global.fnt_numbers);
                                draw_text_transformed_color((menu_pos_x * scale) + (135 * scale) + (12 * scale), (menu_pos_y * scale) + (19 * i * scale), part_cost, scale, scale, 0, select_colour, select_colour, select_colour, select_colour, 1);
                                draw_set_font(global.fnt_game);
                            }
                        }
                        if (ds_list_size(global.parts_store) > 0)
                        {
                            draw_sprite_ext(spr_pause_cursor, 0, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (19 * scale * menu_position_sub) + (9 * scale), scale, scale, 0, menu_colour, 1);
                            shader_set(shd_hue);
                            shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), pause_hue);
                            draw_sprite_ext(spr_pause_cursor, 1, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (19 * scale * menu_position_sub) + (9 * scale), scale, scale, 0, c_white, 1);
                        }
                        arrow = dsin(current_time * 0.4) * 4;
                        if (scroll > 0)
                        {
                            draw_sprite_ext(spr_partselect_scroll, 1, (menu_pos_x * scale) + (80 * scale), ((menu_pos_y * scale) - (10 * scale)) + arrow, scale, scale, 0, c_white, 1);
                        }
                        if ((length_limit + scroll) < ds_list_size(global.parts_store))
                        {
                            draw_sprite_ext(spr_partselect_scroll, 0, (menu_pos_x * scale) + (80 * scale), ((menu_pos_y * scale) + (19 * scale * length_limit) + (10 * scale)) - arrow, scale, scale, 0, c_white, 1);
                        }
                        shader_reset();
                        break;
                    case "Armour":
                        var armour_rows = coop_armour_rows();
                        for (var ai = 0; ai < array_length(armour_rows); ai++)
                        {
                            var ink = (ai == menu_position_sub) ? 16777215 : menu_colour;
                            var yy = (menu_pos_y + (19 * ai)) * scale;
                            var picked = variable_global_get(armour_rows[ai][1]);
                            if (picked == 0)
                            {
                                picked = "None";
                            }
                            draw_set_halign(fa_left);
                            draw_text_transformed_color(menu_pos_x * scale, yy, armour_rows[ai][0], scale * global.font_scale, scale * global.font_scale, 0, ink, ink, ink, ink, 1);
                            draw_set_halign(fa_right);
                            draw_text_transformed_color((menu_pos_x + 178) * scale, yy, string(picked), scale * global.font_scale, scale * global.font_scale, 0, ink, ink, ink, ink, 1);
                        }
                        draw_set_halign(fa_left);
                        break;
                }
            }
            draw_sprite_ext(spr_partselect_top, 0, 0, 0, scale, scale, 0, menu_colour, 1);
            draw_sprite_ext(spr_partselect_top, 1, 0, 0, scale, scale, 0, c_white, 1);
            var text;
            if (global.pause_menu_sub == "Options")
            {
                text = global.playable_character.visual.shop_options;
            }
            else if (global.pause_menu_sub == "Armour")
            {
                text = "Choose unlocked armour with LEFT / RIGHT. BACK to return.";
            }
            else
            {
                var find = ds_list_find_value(global.parts_owned, menu_position_sub + scroll);
                if (global.pause_menu_sub == "Develop")
                {
                    find = ds_list_find_value(global.parts_store, menu_position_sub + scroll);
                }
                scr_get_part(find);
                text = part_description;
            }
            if (global.pause_menu_sub == "Develop" && ds_list_size(global.parts_store) <= 0)
            {
                text = global.playable_character.visual.shop_empty;
            }
            scr_get_character(global.playable_character.visual.shop_character);
            draw_sprite_ext(mugshot, blink, 96 * scale, 8 * scale, -scale, scale, 0, c_white, 1);
            if (text_scrolling < string_length(text))
            {
                draw_sprite_ext(mugshot_talk, text_scrolling / 6, 96 * scale, 8 * scale, -scale, scale, 0, c_white, 1);
            }
            if (text_change != text)
            {
                text_change = text;
                text_scrolling = 0;
            }
            else
            {
                text_scrolling++;
            }
            var typewriter = string_copy(text, 0, text_scrolling);
            draw_text_ext_transformed_color((112 * scale) + (global.font_offset_x * scale), (9 * scale) + (global.font_offset_y * scale), typewriter, 14 + global.font_seperation, 240, (scale / 1.5) * global.font_scale, (scale / 1.5) * global.font_scale, 0, 16777215, 16777215, 16777215, 16777215, 1);
            draw_sprite_ext(spr_partselect_rank, 0, display_get_gui_width(), 0, scale, scale, 0, menu_colour, 1);
            draw_sprite_ext(spr_partselect_rank, 1, display_get_gui_width(), 0, scale, scale, 0, c_white, 1);
            shader_set(shd_hue);
            shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), menu_hue);
            draw_sprite_ext(spr_partselect_rank, 2, display_get_gui_width(), 0, scale, scale, 0, c_white, 1);
            shader_reset();
            scr_get_rank(global.rescue_list);
            draw_sprite_ext(spr_pause_rank, rank_letter, display_get_gui_width() - (25 * scale), 12 * scale, scale, scale, 0, c_white, 1);
            draw_text_ext_transformed_color((display_get_gui_width() - (74 * scale)) + (global.font_offset_x * scale), (25 * scale) + (global.font_offset_y * scale), localtext("shop_rescues") + " " + string(rank_size), 14 + global.font_seperation, 60 * scale, scale * global.font_scale, scale * global.font_scale, 0, 16777215, 16777215, 16777215, 16777215, 1);
            draw_sprite_ext(spr_stageselect_words_frame, pause_animate / 5, -(11 * scale), display_get_gui_height(), scale, scale, 0, c_white, 1);
            draw_sprite_ext(spr_stageselect_words_frame, pause_animate / 5, display_get_gui_width() + (11 * scale), display_get_gui_height(), -scale, scale, 0, c_white, 1);
            draw_sprite_ext(spr_stageselect_words_options, pause_animate / 5, 57 * scale, display_get_gui_height() - (13 * scale), scale, scale, 0, c_white, 1);
            draw_sprite_ext(spr_stageselect_words_stages, pause_animate / 5, display_get_gui_width() - (57 * scale), display_get_gui_height() - (13 * scale), scale, scale, 0, c_white, 1);
            draw_sprite_ext(spr_white_space, 0, 0, 0, room_width, room_height, 0, c_white, save_flash);
            break;
        case "Library":
            if (instance_exists(obj_cutscene_datalog) && !instance_exists(obj_fade_out))
            {
                exit;
            }
            var menu_colour = 8388736;
            draw_sprite_ext(spr_white_space, 0, x, y, room_width, room_height, 0, menu_colour, 1);
            draw_sprite_ext(spr_white_space, 0, x, y, room_width, room_height, 0, c_black, 0.5);
            draw_sprite_ext(spr_pause_gradient, 1, display_get_gui_width() / 2, display_get_gui_height() / 2, 10, 5, 90, c_white, 1);
            draw_sprite_ext(spr_pause_gradient, 1, display_get_gui_width() / 2, display_get_gui_height() / 2, 10, -5, 90, c_white, 1);
            gpu_set_blendmode(bm_add);
            draw_sprite_tiled_ext(spr_pause_grid, 0, pause_animate, pause_animate, 2.5, 2.5, menu_colour, 0.3);
            gpu_set_blendmode(bm_normal);
            var scale = global.ui_scale / 1.25;
            draw_sprite_ext(spr_partselect_top, 0, 0, 0, scale, scale, 0, menu_colour, 1);
            draw_sprite_ext(spr_partselect_top, 1, 0, 0, scale, scale, 0, c_white, 1);
            scr_get_character(global.playable_character.visual.weapon_get_character);
            draw_sprite_ext(mugshot, blink, 96 * scale, 8 * scale, -scale, scale, 0, c_white, 1);
            var text = localtext("library_0");
            if (global.pause_menu_sub == "Data Logs")
            {
                text = localtext("library_2");
            }
            else if (global.pause_menu_sub == "Level Performance")
            {
                text = localtext("library_1");
            }
            else if (global.pause_menu_sub == "Ability Details")
            {
                text = localtext("library_6");
            }
            if (text_scrolling < string_length(text))
            {
                draw_sprite_ext(mugshot_talk, text_scrolling / 6, 96 * scale, 8 * scale, -scale, scale, 0, c_white, 1);
            }
            if (text_change != text)
            {
                text_change = text;
                text_scrolling = 0;
            }
            else
            {
                text_scrolling++;
            }
            var typewriter = string_copy(text, 0, text_scrolling);
            draw_text_ext_transformed_color((112 * scale) + (global.font_offset_x * scale), (9 * scale) + (global.font_offset_y * scale), typewriter, 14 + global.font_seperation, 240, (scale / 1.5) * global.font_scale, (scale / 1.5) * global.font_scale, 0, 16777215, 16777215, 16777215, 16777215, 1);
            var menu_pos_x = 25;
            var menu_pos_y = 100;
            var offset = 0;
            
            function scr_library_catagory(arg0, arg1, arg2, arg3, arg4, arg5)
            {
                draw_sprite_ext(spr_partselect_catagory, 0, arg1 * arg4, arg2 * arg4, arg4, arg4, 0, arg5, 1);
                var select_colour = arg5;
                if (menu_position == arg0)
                {
                    select_colour = 16777215;
                }
                draw_text_transformed_color((arg1 * arg4) + (10 * arg4) + (global.font_offset_x * arg4), ((arg2 * arg4) - (2 * arg4)) + (global.font_offset_y * arg4), arg3, arg4 * global.font_scale, arg4 * global.font_scale, 0, select_colour, select_colour, select_colour, select_colour, 1);
            }
            
            draw_sprite_ext(spr_pause_cursor, 0, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (17 * scale * menu_position) + (6 * scale), scale, scale, 0, menu_colour, 1);
            draw_sprite_ext(spr_pause_cursor, 1, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (17 * scale * menu_position) + (6 * scale), scale, scale, 0, c_white, 1);
            scr_library_catagory(0, menu_pos_x, menu_pos_y + 0, localtext("library_3"), scale, menu_colour);
            scr_library_catagory(1, menu_pos_x, menu_pos_y + 17, localtext("library_4"), scale, menu_colour);
            scr_library_catagory(2, menu_pos_x, menu_pos_y + 34, localtext("library_5"), scale, menu_colour);
            if (ds_list_size(global.level_list) >= 5)
            {
                scr_library_catagory(3, menu_pos_x, menu_pos_y + 51, localtext("shop_menu_3"), scale, 65535);
            }
            if (global.pause_menu_sub != "Options")
            {
                switch (global.pause_menu_sub)
                {
                    case "Data Logs":
                        menu_pos_x = 170;
                        menu_pos_y = 60;
                        
                        function scr_datalog_draw(arg0, arg1, arg2, arg3, arg4, arg5)
                        {
                            var select_colour = arg5;
                            if (menu_position_sub == arg0)
                            {
                                select_colour = 16777215;
                            }
                            draw_sprite_ext(spr_library_item, 0, arg1 * arg4, arg2 * arg4, arg4, arg4, 0, arg5, 1);
                            draw_sprite_ext(spr_datalog_icon, 0, (arg1 * arg4) + (1 * arg4), (arg2 * arg4) + (2 * arg4), arg4, arg4, 0, c_white, 1);
                            draw_text_transformed_color((arg1 * arg4) + (28 * arg4) + (global.font_offset_x * arg4), (arg2 * arg4) + (0 * arg4) + (global.font_offset_y * arg4), localtext(arg3), arg4 * global.font_scale, arg4 * global.font_scale, 0, select_colour, select_colour, select_colour, select_colour, 1);
                        }
                        
                        var length = 10;
                        for (var i = 0; i < length; i++)
                        {
                            if (ds_list_size(global.datalog_list) > i)
                            {
                                scr_datalog_draw(i, menu_pos_x, menu_pos_y + (19 * i), ds_list_find_value(global.datalog_list, i + scroll), scale, menu_colour);
                            }
                        }
                        if (ds_list_size(global.datalog_list) > 0)
                        {
                            draw_sprite_ext(spr_pause_cursor, 0, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (19 * scale * menu_position_sub) + (9 * scale), scale, scale, 0, menu_colour, 1);
                            draw_sprite_ext(spr_pause_cursor, 1, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (19 * scale * menu_position_sub) + (9 * scale), scale, scale, 0, c_white, 1);
                        }
                        arrow = dsin(current_time * 0.4) * 4;
                        if (scroll > 0)
                        {
                            draw_sprite_ext(spr_partselect_scroll, 1, (menu_pos_x * scale) + (80 * scale), ((menu_pos_y * scale) - (10 * scale)) + arrow, scale, scale, 0, c_white, 1);
                        }
                        if ((length_limit + scroll) < ds_list_size(global.datalog_list))
                        {
                            draw_sprite_ext(spr_partselect_scroll, 0, (menu_pos_x * scale) + (80 * scale), ((menu_pos_y * scale) + (19 * scale * length_limit) + (10 * scale)) - arrow, scale, scale, 0, c_white, 1);
                        }
                        break;
                    case "Level Performance":
                        menu_pos_x = 170;
                        menu_pos_y = 70;
                        var spacing = 38;
                        
                        function scr_level_draw(arg0, arg1, arg2, arg3, arg4)
                        {
                            scr_get_level(arg3.level);
                            var select_colour = level_colour;
                            if (menu_position_sub == arg0)
                            {
                                select_colour = 16777215;
                            }
                            draw_sprite_ext(spr_library_performance, 0, arg1 * arg4, arg2 * arg4, arg4, arg4, 0, level_colour, 1);
                            draw_sprite_ext(spr_library_performance, arg3.level + 3, arg1 * arg4, arg2 * arg4, arg4, arg4, 0, level_colour, 1);
                            draw_sprite_ext(spr_library_performance, 1, arg1 * arg4, arg2 * arg4, arg4, arg4, 0, c_white, 0.25);
                            draw_set_font(global.fnt_larger);
                            draw_text_transformed_color((arg1 * arg4) + (3 * arg4), arg2 * arg4, string_upper(level_name), arg4, arg4, 0, select_colour, select_colour, select_colour, select_colour, 1);
                            draw_set_font(global.fnt_heading);
                            for (var a = 0; a < global.ng_cycle; a++)
                            {
                                draw_sprite_ext(spr_option_ng_star, 0, ((arg1 * arg4) + (220 * arg4)) - (12 * arg4 * a), (arg2 * arg4) - (4 * arg4), arg4, arg4, 0, c_white, 1);
                            }
                            scr_medal_colour(arg3.kill_rank);
                            if (arg3.kill_rank >= 0)
                            {
                                scr_draw_sprite_outlined((arg1 * arg4) + (2 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, spr_results_icon, 0, 1, arg4, false);
                                scr_draw_text_outlined_ext((arg1 * arg4) + (19 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, arg3.kill, arg4, 9999, 9999, 1, 0);
                                gpu_set_blendmode(bm_add);
                                scr_draw_sprite_outlined((arg1 * arg4) + (2 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, spr_results_icon, 0, 0.25, arg4, false);
                                scr_draw_text_outlined_ext((arg1 * arg4) + (19 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, arg3.kill, arg4, 9999, 9999, 0.25, 0);
                                gpu_set_blendmode(bm_normal);
                                if (sparkle_fade > 120 && (((pause_animate % 15) == 0 && arg3.kill_rank == 3) || ((pause_animate % 30) == 0 && arg3.kill_rank == 2)))
                                {
                                    shine = instance_create_depth((arg1 * arg4) + (2 * arg4) + (random_range(0, 40) * arg4), (arg2 * arg4) + (random_range(14, 28) * arg4), 0, obj_particle_gui);
                                    shine.sprite_index = spr_shiny_sparkle;
                                    shine.image_xscale = arg4;
                                    shine.image_yscale = arg4;
                                    if (menu_position_sub != arg0)
                                    {
                                        shine.image_blend = c_ltgray;
                                    }
                                }
                            }
                            else
                            {
                                draw_sprite_ext(spr_results_icon, 0, (arg1 * arg4) + (2 * arg4), (arg2 * arg4) + (14 * arg4), arg4, arg4, 0, c_ltgray, 1);
                                draw_text_transformed_color((arg1 * arg4) + (19 * arg4), (arg2 * arg4) + (14 * arg4), arg3.kill, arg4, arg4, 0, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 1);
                            }
                            scr_medal_colour(arg3.damage_rank);
                            if (arg3.damage_rank >= 0)
                            {
                                scr_draw_sprite_outlined((arg1 * arg4) + (58 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, spr_results_icon, 1, 1, arg4, false);
                                scr_draw_text_outlined_ext((arg1 * arg4) + (75 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, arg3.damage, arg4, 9999, 9999, 1, 0);
                                gpu_set_blendmode(bm_add);
                                scr_draw_sprite_outlined((arg1 * arg4) + (58 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, spr_results_icon, 1, 0.25, arg4, false);
                                scr_draw_text_outlined_ext((arg1 * arg4) + (75 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, arg3.damage, arg4, 9999, 9999, 0.25, 0);
                                gpu_set_blendmode(bm_normal);
                                if (sparkle_fade > 120 && (((pause_animate % 15) == 0 && arg3.damage_rank == 3) || ((pause_animate % 30) == 0 && arg3.damage_rank == 2)))
                                {
                                    shine = instance_create_depth((arg1 * arg4) + (58 * arg4) + (random_range(0, 30) * arg4), (arg2 * arg4) + (random_range(14, 28) * arg4), 0, obj_particle_gui);
                                    shine.sprite_index = spr_shiny_sparkle;
                                    shine.image_xscale = arg4;
                                    shine.image_yscale = arg4;
                                    if (menu_position_sub != arg0)
                                    {
                                        shine.image_blend = c_ltgray;
                                    }
                                }
                            }
                            else
                            {
                                draw_sprite_ext(spr_results_icon, 1, (arg1 * arg4) + (58 * arg4), (arg2 * arg4) + (14 * arg4), arg4, arg4, 0, c_ltgray, 1);
                                draw_text_transformed_color((arg1 * arg4) + (75 * arg4), (arg2 * arg4) + (14 * arg4), arg3.damage, arg4, arg4, 0, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 1);
                            }
                            scr_medal_colour(arg3.time_rank);
                            var draw_frames = arg3.time % 60;
                            var draw_seconds = (arg3.time div 60) % 60;
                            var draw_minutes = (arg3.time div 3600) % 60;
                            var playtime = string_repeat("0", max(0, 2 - string_length(string(draw_minutes)))) + string(draw_minutes) + ":" + string_repeat("0", max(0, 2 - string_length(string(draw_seconds)))) + string(draw_seconds) + ":" + string_repeat("0", max(0, 2 - string_length(string(draw_frames)))) + string(draw_frames);
                            if (arg3.time_rank >= 0)
                            {
                                scr_draw_sprite_outlined((arg1 * arg4) + (114 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, spr_results_icon, 2, 1, arg4, false);
                                scr_draw_text_outlined_ext((arg1 * arg4) + (131 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, playtime, arg4, 9999, 9999, 1, 0);
                                gpu_set_blendmode(bm_add);
                                scr_draw_sprite_outlined((arg1 * arg4) + (114 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, spr_results_icon, 2, 0.25, arg4, false);
                                scr_draw_text_outlined_ext((arg1 * arg4) + (131 * arg4), (arg2 * arg4) + (14 * arg4), medal_outline, medal_colour, playtime, arg4, 9999, 9999, 0.25, 0);
                                gpu_set_blendmode(bm_normal);
                                if (sparkle_fade > 120 && (((pause_animate % 10) == 0 && arg3.time_rank == 3) || ((pause_animate % 20) == 0 && arg3.time_rank == 2)))
                                {
                                    shine = instance_create_depth((arg1 * arg4) + (114 * arg4) + (random_range(0, 98) * arg4), (arg2 * arg4) + (random_range(14, 28) * arg4), 0, obj_particle_gui);
                                    shine.sprite_index = spr_shiny_sparkle;
                                    shine.image_xscale = arg4;
                                    shine.image_yscale = arg4;
                                    if (menu_position_sub != arg0)
                                    {
                                        shine.image_blend = c_ltgray;
                                    }
                                }
                            }
                            else
                            {
                                draw_sprite_ext(spr_results_icon, 2, (arg1 * arg4) + (114 * arg4), (arg2 * arg4) + (14 * arg4), arg4, arg4, 0, c_ltgray, 1);
                                draw_text_transformed_color((arg1 * arg4) + (131 * arg4), (arg2 * arg4) + (14 * arg4), playtime, arg4, arg4, 0, c_ltgray, c_ltgray, c_ltgray, c_ltgray, 1);
                            }
                            if (menu_position_sub != arg0)
                            {
                                draw_sprite_ext(spr_library_performance, 1, arg1 * arg4, arg2 * arg4, arg4, arg4, 0, c_white, 0.25);
                            }
                        }
                        
                        var length = 5;
                        for (var i = 0; i < length; i++)
                        {
                            if (ds_list_size(global.result_store) > i)
                            {
                                scr_level_draw(i, menu_pos_x, menu_pos_y + (spacing * i), ds_list_find_value(global.result_store, i + scroll), scale);
                            }
                        }
                        if (ds_list_size(global.result_store) > 0)
                        {
                            draw_sprite_ext(spr_pause_cursor, 0, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (spacing * scale * menu_position_sub) + (13 * scale), scale, scale, 0, menu_colour, 1);
                            draw_sprite_ext(spr_pause_cursor, 1, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (spacing * scale * menu_position_sub) + (13 * scale), scale, scale, 0, c_white, 1);
                        }
                        arrow = dsin(current_time * 0.4) * 4;
                        if (scroll > 0)
                        {
                            draw_sprite_ext(spr_partselect_scroll, 1, (menu_pos_x * scale) + (120 * scale), ((menu_pos_y * scale) - (15 * scale)) + arrow, scale, scale, 0, c_white, 1);
                        }
                        if ((4 + scroll) < ds_list_size(global.result_store))
                        {
                            draw_sprite_ext(spr_partselect_scroll, 0, (menu_pos_x * scale) + (120 * scale), ((menu_pos_y * scale) + (15 * scale * length_limit) + (9 * scale)) - arrow, scale, scale, 0, c_white, 1);
                        }
                        break;
                    case "Ability Details":
                        menu_pos_x = 170;
                        menu_pos_y = 60;
                        
                        function scr_special_draw(arg0, arg1, arg2, arg3, arg4, arg5)
                        {
                            var select_colour = arg5;
                            if (menu_position_sub == arg0)
                            {
                                select_colour = 16777215;
                            }
                            draw_sprite_ext(spr_library_item, 0, arg1 * arg4, arg2 * arg4, arg4, arg4, 0, arg5, 1);
                            draw_sprite_ext(spr_wheel_icon, 0, (arg1 * arg4) + (8 * arg4), (arg2 * arg4) + (9 * arg4), arg4, arg4, 0, arg5, 1);
                            var weapon_sprite = spr_hud_weapon;
                            if (global.playable_character.name == "Zero")
                            {
                                weapon_sprite = spr_hud_weapon_zero;
                            }
                            draw_sprite_ext(weapon_sprite, weapon_position, (arg1 * arg4) + (8 * arg4), (arg2 * arg4) + (8 * arg4), arg4, arg4, 0, c_white, 1);
                            draw_text_transformed_color((arg1 * arg4) + (28 * arg4) + (global.font_offset_x * arg4), (arg2 * arg4) + (0 * arg4) + (global.font_offset_y * arg4), localtext(arg3), arg4 * global.font_scale, arg4 * global.font_scale, 0, select_colour, select_colour, select_colour, select_colour, 1);
                        }
                        
                        var length = 8;
                        for (var i = 0; i < length; i++)
                        {
                            if (ds_list_size(global.weapon_list) > i)
                            {
                                scr_weapon_get(ds_list_find_value(global.weapon_list, i + scroll), false);
                                scr_weapon_menus(global.give_weapon);
                                scr_special_draw(i, menu_pos_x, menu_pos_y + (19 * i), weapon_name_display, scale, weapon_ammo_colour);
                            }
                        }
                        if (ds_list_size(global.weapon_list) > 0)
                        {
                            draw_sprite_ext(spr_pause_cursor, 0, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (19 * scale * menu_position_sub) + (9 * scale), scale, scale, 0, menu_colour, 1);
                            draw_sprite_ext(spr_pause_cursor, 1, (menu_pos_x * scale) - (9 * scale), (menu_pos_y * scale) + (19 * scale * menu_position_sub) + (9 * scale), scale, scale, 0, c_white, 1);
                        }
                        arrow = dsin(current_time * 0.4) * 4;
                        if (scroll > 0)
                        {
                            draw_sprite_ext(spr_partselect_scroll, 1, (menu_pos_x * scale) + (80 * scale), ((menu_pos_y * scale) - (10 * scale)) + arrow, scale, scale, 0, c_white, 1);
                        }
                        if ((length_limit + scroll) < ds_list_size(global.weapon_list))
                        {
                            draw_sprite_ext(spr_partselect_scroll, 0, (menu_pos_x * scale) + (80 * scale), ((menu_pos_y * scale) + (19 * scale * length_limit) + (10 * scale)) - arrow, scale, scale, 0, c_white, 1);
                        }
                        break;
                }
            }
            draw_sprite_ext(spr_stageselect_words_frame, pause_animate / 5, -(11 * scale), display_get_gui_height(), scale, scale, 0, c_white, 1);
            draw_sprite_ext(spr_stageselect_words_frame, pause_animate / 5, display_get_gui_width() + (11 * scale), display_get_gui_height(), -scale, scale, 0, c_white, 1);
            draw_sprite_ext(spr_stageselect_words_stages, pause_animate / 5, 57 * scale, display_get_gui_height() - (13 * scale), scale, scale, 0, c_white, 1);
            draw_sprite_ext(spr_stageselect_words_options, pause_animate / 5, display_get_gui_width() - (57 * scale), display_get_gui_height() - (13 * scale), scale, scale, 0, c_white, 1);
            draw_set_font(global.fnt_game);
            break;
    }
}
