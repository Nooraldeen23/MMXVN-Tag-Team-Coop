if (instance_exists(obj_player) && obj_player.x < 112 && obj_player.y > 2150 && obj_player.y < 2250)
{
    var a = draw_get_alpha();
    var c = draw_get_color();
    draw_set_alpha(0.5 + (0.2 * sin(global.animate / 12)));
    draw_set_color(make_color_rgb(120, 90, 190));
    draw_ellipse(36, 2183, 56, 2228, true);
    draw_set_alpha(a);
    draw_set_color(c);
}
