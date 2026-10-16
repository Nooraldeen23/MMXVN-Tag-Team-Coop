if (global.pause)
{
    exit;
}
dust_timer++;
if (dust_chip)
{
    sprite_index = spr_effect_rubble;
    image_index = dust_timer % 2;
    image_xscale = 0.5;
    image_yscale = 0.5;
    dust_vy += 0.12;
    x += dust_vx;
    y += dust_vy;
    image_angle += (dust_face * 9);
}
else
{
    image_index = floor(dust_timer / 2);
    x += (dust_face * 0.22);
    y -= 0.12;
    image_alpha = 0.7 * min(1, (20 - dust_timer) / 6);
}
if (dust_timer >= 20)
{
    instance_destroy();
}
