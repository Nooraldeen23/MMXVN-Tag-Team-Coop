if (global.pause)
{
    exit;
}
if (col_wall_impact)
{
    col_impact_tick++;
    speed = 0;
    damage = 0;
    image_alpha = 1 - (col_impact_tick / 12);
    image_index = (image_index + 0.45) % sprite_get_number(sprite_index);
    if (col_impact_tick >= 12)
    {
        instance_destroy();
    }
    exit;
}
image_xscale = -col_face * col_wave_scale;
image_yscale = col_wave_scale;
image_angle = 0;
event_inherited();
col_wave_age++;
if (sprite_index == spr_tag_colonel_crush)
{
    image_speed = 0;
    image_index = (floor(col_wave_age * col_wave_growth) + col_wave_phase) % 9;
}
var hitmask = asset_get_index(sprite_get_name(sprite_index) + "_body_" + string(clamp(floor(image_index), 0, sprite_get_number(sprite_index) - 1)));
if (hitmask != -1)
{
    mask_index = hitmask;
}
if ((col_face > 0 && bbox_right >= 384) || (col_face < 0 && bbox_left <= 64))
{
    var edge = (col_face > 0) ? 384 : 64;
    var lead = (col_face > 0) ? bbox_right : bbox_left;
    x += (edge - lead);
    col_wall_impact = true;
    col_impact_tick = 0;
    speed = 0;
    damage = 0;
    expiry = 999;
    image_speed = 0;
    var impact = instance_create_layer(edge - (col_face * 3), (sprite_index == spr_tag_colonel_crush) ? 530 : y, "Explosions", obj_explosion);
    impact.sprite_index = spr_explosion_player;
    impact.image_speed = 0.65;
    impact.image_xscale = 0.35;
    impact.image_yscale = 0.35;
    if (col_wave_role == 0)
    {
        tagteam_colonel_sfx("land", 0.22);
    }
}
