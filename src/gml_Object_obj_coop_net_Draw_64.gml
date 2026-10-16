if (global.coop_role == 0 || room == rm_title || global.pause_screen)
{
    exit;
}
var old_font = draw_get_font();
var old_color = draw_get_color();
var old_alpha = draw_get_alpha();
var old_align = draw_get_halign();
var scale = global.ui_scale * 0.6;
var line = "CO-OP | " + global.coop_character + " " + ((global.coop_role == 1) ? "HOST" : "JOIN") + " | " + (connected ? "CONNECTED" : status);
if (instance_exists(remote) && remote.visible && coop_play_room())
{
    line += (" | " + remote.coop_character + " " + string(max(0, remote.coop_hp)) + "/" + string(remote.coop_maxhp));
}
if (coop_play_room())
{
    line += (" | " + (spectating ? "SPECTATING" : ("LIVES " + string(global.lives))));
}
draw_set_font(global.fnt_game);
draw_set_color(make_color_rgb(186, 195, 210));
draw_set_alpha(0.42);
draw_set_halign(fa_right);
draw_text_transformed(display_get_gui_width() - (4 * global.ui_scale), 2 * global.ui_scale, line, scale, scale, 0);
draw_set_font(old_font);
draw_set_color(old_color);
draw_set_alpha(old_alpha);
draw_set_halign(old_align);
