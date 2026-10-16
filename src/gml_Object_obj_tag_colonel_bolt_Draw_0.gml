if (bolt_kind == 1)
{
    if (bolt_tick < 14)
    {
        draw_sprite_ext(spr_tag_colonel_spark, floor(bolt_tick / 2) % 8, x, y - 2, 0.22, 0.22, 0, c_white, 0.55 + (0.2 * sin(bolt_tick)));
    }
    else
    {
        var frame = floor(bolt_tick / 3) % 4;
        var anchor = tagteam_colonel_bolt_anchor(frame);
        var sy = ((y - 320) * bolt_height) / anchor[2];
        draw_sprite_ext(spr_tag_colonel_sky_bolt, frame, x - anchor[0], y - (anchor[1] * sy), 1, sy, 0, c_white, 1);
    }
    exit;
}
draw_sprite_ext(spr_tag_colonel_ground_electric, floor(bolt_tick / 3) % 4, x, y, -bolt_face, 1, 0, c_white, (bolt_fade > 0) ? (1 - (bolt_fade / 12)) : 1);
