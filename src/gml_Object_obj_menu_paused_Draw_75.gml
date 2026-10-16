if (room == rm_title && global.pause_menu == "Options" && global.pause_menu_sub == "Title" && title_state > 0 && title_white_alpha <= 0.01 && !instance_exists(obj_comic_parent))
{
    var tt_font = draw_get_font();
    var tt_color = draw_get_color();
    var tt_alpha = draw_get_alpha();
    var tt_ha = draw_get_halign();
    var tt_va = draw_get_valign();
    var tt_s = global.ui_scale / 1.25;
    var tt_x = (display_get_gui_width() / 2) + (7 * tt_s);
    var tt_y = (display_get_gui_height() / 2) + (14 * tt_s);
    gpu_set_blendmode(bm_add);
    pal_swap_set(spr_effect_charging_palette, 5, false);
    draw_sprite_ext(spr_effect_charging_reverse, pause_animate / 6, tt_x - (52 * tt_s), tt_y + (4 * tt_s), 1.3 * tt_s, 0.35 * tt_s, 0, c_white, 0.28);
    pal_swap_set(spr_effect_charging_palette, 15, false);
    draw_sprite_ext(spr_effect_charging_reverse, (pause_animate / 6) + 3, tt_x + (52 * tt_s), tt_y + (4 * tt_s), 1.3 * tt_s, 0.35 * tt_s, 0, c_white, 0.28);
    pal_swap_reset();
    gpu_set_blendmode(bm_normal);
    draw_set_font(global.fnt_game);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
    scr_draw_text_outlined(tt_x, tt_y, 0, 16777215, "Tag team mod + Co-op mod by nooraldeen", tt_s * global.font_scale * 0.8);
    draw_set_font(tt_font);
    draw_set_color(tt_color);
    draw_set_alpha(tt_alpha);
    draw_set_halign(tt_ha);
    draw_set_valign(tt_va);
}
