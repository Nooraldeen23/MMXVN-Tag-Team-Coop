if (global.hud_toggle)
{
    var x_pos = display_get_gui_width() - (30 * global.ui_scale);
    var y_pos = (display_get_gui_height() / 2) + (10 * global.ui_scale);
    draw_sprite_ext(spr_hud_boss, 0, x_pos, y_pos, global.ui_scale, global.ui_scale, 0, c_white, 1);
    var bar_height = -(96 * global.ui_scale) - 1;
    var bar_start_y = y_pos;
    var display_life = life;
    if (variable_instance_exists(id, "col_dead") && col_dead)
    {
        display_life = 0;
    }
    if (variable_instance_exists(id, "sig_death") && sig_death)
    {
        display_life = 0;
    }
    var bar_limit = min(1, display_life / lifemax);
    if (!variable_instance_exists(id, "sig_life_tick"))
    {
        sig_life_tick = life;
    }
    if (sig_life_tick != life)
    {
        sig_life_tick += ((life - sig_life_tick) * 0.025);
    }
    if (display_life > 0)
    {
        draw_rectangle_color(x_pos, bar_start_y, (x_pos + (3 * global.ui_scale)) - 1, bar_start_y + ((bar_height + global.ui_scale) * (sig_life_tick / lifemax)), c_red, c_red, c_red, c_red, 0);
        draw_rectangle_color(x_pos, bar_start_y, (x_pos + (3 * global.ui_scale)) - 1, bar_start_y + (bar_height * bar_limit), c_lime, c_lime, c_yellow, c_yellow, 0);
    }
    var previous_font = draw_get_font();
    var previous_align = draw_get_halign();
    draw_set_font(sig_hud_font);
    draw_set_halign(fa_center);
    var percentage = max(0, (display_life / lifemax) * 100);
    draw_text_ext_transformed_color(x_pos + (6.5 * global.ui_scale), y_pos + (17 * global.ui_scale), string(ceil(percentage)) + "%", 10, 11 * global.ui_scale, global.ui_scale, global.ui_scale, 0, 15790192, 15790192, 15790192, 15790192, 1);
    draw_set_font(previous_font);
    draw_set_halign(previous_align);
}
