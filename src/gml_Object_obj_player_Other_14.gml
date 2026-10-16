bullet = instance_create_layer(x, y, "Projectiles", obj_bullet_saber);
switch (machdash_direction)
{
    case 270:
        bullet.image_angle = machdash_direction;
        break;
    case 90:
        bullet.image_angle = machdash_direction;
        break;
    default:
        bullet.offset_y = -4;
        bullet.image_xscale = image_xscale;
        break;
}
bullet.damage = machdash_damage;
bullet.melee_frames = 3;
bullet.sprite_index = spr_bullet_x_machdash;
bullet.melee_slash = false;
bullet.turning = false;
bullet.slash = false;
bullet.palette = 3;
if (machdash_hold >= machdash_holdmax)
{
    machdash_charged = true;
}
if (machdash_charged == true)
{
    bullet.sprite_index = spr_bullet_x_machdash_charged;
    bullet.damage = machdash_damage * 3;
    bullet.guard_breaking = true;
    machdash_invul = -1;
    scr_make_sound(snd_machdash, 1, 1, false);
    scr_player_voicelines("Charge Shot");
    alarm[4] = dash_length / 1.5;
}
with (bullet)
{
    if (ds_list_find_index(global.parts_equipped, 14) != -1)
    {
        scr_get_part_effect(14, false);
    }
    if (ds_list_find_index(global.parts_equipped, 3) != -1)
    {
        scr_get_part_effect(3, false);
    }
    if (ds_list_find_index(global.parts_equipped, 17) != -1)
    {
        scr_get_part_effect(17, "Saber");
    }
    if (ds_list_find_index(global.parts_equipped, 21) != -1)
    {
        scr_get_part_effect(21, "Saber");
    }
}
if (machdash_charged == true)
{
    bullet.palette = 0;
}
