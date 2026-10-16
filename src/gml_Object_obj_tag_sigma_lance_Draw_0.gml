var scale_y = lance_landed ? 0.28 : 0.5;
if (!lance_landed)
{
    draw_sprite_ext(spr_tag_satan_lance, image_index, lance_old_x, lance_old_y, 0.65, scale_y, image_angle, c_white, 0.18);
}
draw_sprite_ext(spr_tag_satan_lance, image_index, x, y, 0.75, scale_y, image_angle, c_white, 1);
