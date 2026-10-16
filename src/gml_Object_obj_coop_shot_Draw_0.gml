if (!visible || sprite_index < 0)
{
    exit;
}
if (coop_palette_sprite >= 0)
{
    pal_swap_set(coop_palette_sprite, coop_palette, false);
}
var draw_x = x;
var draw_y = y;
var draw_sx = image_xscale;
var draw_sy = image_yscale;
if (coop_slash && instance_exists(obj_coop_net.remote))
{
    draw_x = obj_coop_net.remote.x;
    draw_y = obj_coop_net.remote.y;
    draw_sx = obj_coop_net.remote.image_xscale;
    draw_sy = obj_coop_net.remote.image_yscale;
}
draw_sprite_ext(sprite_index, coop_draw_frame, draw_x, draw_y, draw_sx, draw_sy, image_angle, image_blend, image_alpha);
if (coop_palette_sprite >= 0)
{
    pal_swap_reset();
}
