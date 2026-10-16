if (obj_player.movement == true && obj_player.animation_lock == false && global.pause_screen == false && room != rm_weapon_get && room != rm_training && result_disable == false)
{
    global.result_timer++;
    if (global.result_display > 1 && global.level_completed == false)
    {
        var alpha = 0.25;
        var colour = 16777215;
        var colour_outline = 8421504;
        if (global.result_timer_minute > 0)
        {
            alpha = 1;
            colour = 65535;
            colour_outline = 28825;
        }
        var draw_frames = global.result_timer % 60;
        var draw_seconds = (global.result_timer div 60) % 60;
        var draw_minutes = (global.result_timer div 3600) % 60;
        var playtime = string_repeat("0", max(0, 2 - string_length(string(draw_minutes)))) + string(draw_minutes) + ":" + string_repeat("0", max(0, 2 - string_length(string(draw_seconds)))) + string(draw_seconds) + ":" + string_repeat("0", max(0, 2 - string_length(string(draw_frames)))) + string(draw_frames);
        draw_set_font(global.fnt_heading);
        scr_draw_sprite_outlined((display_get_gui_width() / 2) - 150 - (18 * global.ui_scale), 3 * global.ui_scale, colour_outline, colour, spr_results_icon, 2, alpha, global.ui_scale, false);
        scr_draw_text_outlined_ext((display_get_gui_width() / 2) - 150, 3 * global.ui_scale, colour_outline, colour, playtime, global.ui_scale, 9999, 9999, alpha, 0);
        alpha = 0.25;
        colour = 16777215;
        colour_outline = 8421504;
        if (obj_player.hurt == true || obj_player.recovery > 0 || global.death == true || obj_player.image_blend == c_blue)
        {
            alpha = 1;
            colour = 65535;
            colour_outline = 28825;
        }
        draw_set_halign(fa_right);
        scr_draw_sprite_outlined(display_get_gui_width() - (18 * global.ui_scale), display_get_gui_height() - (17 * global.ui_scale), colour_outline, colour, spr_results_icon, 1, alpha, global.ui_scale, false);
        scr_draw_text_outlined_ext(display_get_gui_width() - (20 * global.ui_scale), display_get_gui_height() - (17 * global.ui_scale), colour_outline, colour, global.result_damage, global.ui_scale, 9999, 9999, alpha, 0);
        alpha = 0.25;
        colour = 16777215;
        colour_outline = 8421504;
        if (global.result_kill_change > 0)
        {
            alpha = 1;
            colour = 65535;
            colour_outline = 28825;
        }
        scr_draw_sprite_outlined(display_get_gui_width() - (18 * global.ui_scale), display_get_gui_height() - (36 * global.ui_scale), colour_outline, colour, spr_results_icon, 0, alpha, global.ui_scale, false);
        scr_draw_text_outlined_ext(display_get_gui_width() - (20 * global.ui_scale), display_get_gui_height() - (36 * global.ui_scale), colour_outline, colour, ds_list_size(global.result_kill), global.ui_scale, 9999, 9999, alpha, 0);
        draw_set_halign(fa_left);
        draw_set_font(global.fnt_game);
    }
}
