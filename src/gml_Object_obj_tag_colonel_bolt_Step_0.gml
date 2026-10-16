if (global.pause)
{
    exit;
}
bolt_tick++;
if (bolt_kind == 1)
{
    bolt_height = clamp((bolt_tick - 14) / 6, 0, 1);
    if (bolt_tick >= 38)
    {
        bolt_height = clamp((46 - bolt_tick) / 8, 0, 1);
    }
    bolt_height = bolt_height * bolt_height * (3 - (2 * bolt_height));
    bolt_active = bolt_height >= 0.55;
    var anchor = tagteam_colonel_bolt_anchor(floor(bolt_tick / 3) % 4);
    if (bolt_active && instance_exists(obj_player) && obj_player.bbox_right > (x + anchor[3]) && obj_player.bbox_left < (x + anchor[4]) && obj_player.bbox_bottom > (y - ((y - 320) * bolt_height)) && obj_player.bbox_top < y)
    {
        tagteam_sigma_hurt_player(bolt_damage);
    }
    if (bolt_tick >= 48)
    {
        instance_destroy();
    }
    exit;
}
if (bolt_fade > 0)
{
    bolt_fade++;
    bolt_active = false;
    if (bolt_fade >= 12)
    {
        instance_destroy();
    }
    exit;
}
x += (bolt_face * bolt_speed);
image_index = floor(bolt_tick / 3) % 4;
if (instance_exists(obj_player) && abs(obj_player.x - (x + (bolt_face * 16))) < 17 && obj_player.bbox_bottom > (y - 30) && obj_player.bbox_top < y)
{
    tagteam_sigma_hurt_player(bolt_damage);
}
if ((x + (bolt_face * 24)) <= 64 || (x + (bolt_face * 24)) >= 384 || bolt_tick >= 100)
{
    x = clamp(x, 88, 360);
    bolt_fade = 1;
    bolt_active = false;
}
