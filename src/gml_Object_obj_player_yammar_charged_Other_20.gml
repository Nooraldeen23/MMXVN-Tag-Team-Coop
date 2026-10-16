if (shoot_delay == 0)
{
    bullet = instance_create_layer(x + (6 * image_xscale), y, "Projectiles", obj_bullet_missile);
    bullet.damage = damage;
    bullet.direction = image_angle;
    bullet.image_xscale = image_xscale;
    bullet.speed = 6 * image_xscale;
    bullet.special = true;
    bullet.special_type = "Yammar Option";
    scr_make_sound(snd_yammark_shoot, 1, 1, false);
    shoot_delay = shoot_delay_max;
}
