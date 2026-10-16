var offsets = tagteam_colonel_foot_offsets();
var foot = variable_struct_get(offsets, col_pose);
var dy = foot[min(col_frame, array_length(foot) - 1)];
if (isHit || boss_flicker)
{
    gpu_set_fog(true, make_color_rgb(211, 232, 248), 0, 0);
}
draw_sprite_ext(sprite_index, image_index, x, y + dy, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
if (isHit || boss_flicker)
{
    gpu_set_fog(false, make_color_rgb(211, 232, 248), 0, 0);
}
if (col_enraged && !col_dead && image_alpha > 0 && !isHit && !boss_flicker && (col_state != "rage" || col_tick >= 24))
{
    var electric = asset_get_index("spr_tag_colonel_electric_" + col_pose);
    if (electric != -1)
    {
        gpu_set_blendmode(bm_add);
        draw_sprite_ext(electric, (col_frame * 4) + (floor(col_clock / 3) % 4), x, y + dy, image_xscale, 1, 0, c_white, 0.75 * image_alpha);
        gpu_set_blendmode(bm_normal);
    }
}
if (col_state == "rage" && col_tick >= 24 && col_tick < 45)
{
    var strike_alpha = clamp(1 - ((col_tick - 24) / 21), 0, 1);
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(spr_tag_colonel_bolt, floor((col_tick - 24) / 2) % 5, x + (8 * col_face), y - 128, 1, 1, 0, c_white, strike_alpha);
    gpu_set_blendmode(bm_normal);
}
if (col_state == "thunder_hold")
{
    var tip = tagteam_colonel_saber_tip(id);
    var tip_x = tip[0];
    var tip_y = tip[1];
    var sky_alpha = min(1, col_tick / 5) * clamp((36 - col_tick) / 8, 0, 1);
    var frame = floor(col_tick / 2) % 4;
    var anchor = tagteam_colonel_bolt_anchor(frame);
    var sy = (tip_y - 320) / anchor[2];
    draw_sprite_ext(spr_tag_colonel_sky_bolt, frame, tip_x - anchor[0], tip_y - (anchor[1] * sy), 1, sy, 0, c_white, sky_alpha);
    draw_sprite_ext(spr_tag_colonel_spark, floor(col_tick / 3) % 8, tip_x, tip_y, 0.6, 0.6, 0, c_white, sky_alpha);
}
if (col_state == "thunder_slam" && col_tick >= 9 && col_tick < 23)
{
    draw_sprite_ext(spr_tag_colonel_spark, floor((col_tick - 9) / 2) % 8, x, col_floor - 3, 0.9, 0.4, 0, c_white, 1);
}
if (col_state == "arrival" || col_state == "land")
{
    var fade = (col_state == "land") ? clamp(1 - (col_tick / 24), 0, 1) : 1;
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(spr_pickup_soul_glow, 0, x, 544, 2.5, 0.45, 0, make_color_rgb(225, 75, 255), fade * 0.6);
    gpu_set_blendmode(bm_normal);
}
