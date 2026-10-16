draw_sprite(spr_tag_ruined_temple, floor(secret_clock / 12) % 10, 8, 320);
for (var floor_x = 0; floor_x < 448; floor_x += 96)
{
    draw_sprite(spr_tag_temple_floor, floor(floor_x / 96) % 3, floor_x, 544);
}
draw_sprite_ext(spr_tag_ruin_wall, 0, 0, 320, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_tag_ruin_wall, 0, 448, 320, -1, 1, 0, c_white, 1);
draw_set_color(make_color_rgb(104, 103, 115));
draw_line_width(64, 544, 384, 544, 2);
draw_set_color(c_white);
if (instance_exists(obj_player))
{
    var feet = obj_player.bbox_bottom;
    var altitude = max(0, 544 - feet);
    var shadow_alpha = 0.24 * clamp(1 - (altitude / 130), 0, 1);
    draw_set_alpha(shadow_alpha);
    draw_set_color(c_black);
    draw_ellipse(clamp(obj_player.x, 74, 374) - 10, 543, clamp(obj_player.x, 74, 374) + 10, 547, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
with (obj_tag_colonel)
{
    var height = max(0, col_floor - y);
    var grounded = clamp(1 - (height / 160), 0, 1);
    var wide = col_dead ? 32 : 18;
    draw_set_color(c_black);
    draw_set_alpha(0.28 * grounded * image_alpha);
    draw_ellipse(x - (wide * (0.55 + (0.45 * grounded))), 542, x + (wide * (0.55 + (0.45 * grounded))), 546, false);
    draw_set_alpha(0.1 * grounded * image_alpha);
    draw_ellipse(x - wide - 3, 541, x + wide + 3, 547, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
tagteam_colonel_wall_draw();
