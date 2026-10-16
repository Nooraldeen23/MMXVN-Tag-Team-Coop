if (autosaving > 0 && autosaving < 120)
{
    autosaving++;
    if (autosaving > 100)
    {
        autosaving_alpha -= 0.05;
    }
    else
    {
        autosaving_alpha = 0.5 + (dsin(current_time * 0.4) * 0.5);
    }
    var x_pos = display_get_gui_width() - (30 * global.ui_scale);
    var y_pos = display_get_gui_height() - (18 * global.ui_scale);
    draw_sprite_ext(spr_autosave_icon, 0, x_pos, y_pos, global.ui_scale, global.ui_scale, 0, c_white, autosaving_alpha);
}
else
{
    autosaving = 0;
    autosaving_alpha = 1;
}
if (global.fps_display == true)
{
    draw_set_font(global.fnt_numbers);
    scr_draw_text_outlined(16 * global.ui_scale, 1 * global.ui_scale, 0, 65535, "FPS = " + string(fps), global.ui_scale / 2);
    draw_set_font(global.fnt_game);
}
