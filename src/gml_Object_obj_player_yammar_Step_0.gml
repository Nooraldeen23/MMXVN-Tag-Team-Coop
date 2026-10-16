if (global.pause == true)
{
    exit;
}
if (life > 0)
{
    if (instance_exists(target))
    {
        center_x = target.x + (2 * target.image_xscale);
        center_y = target.y;
        orbit_angle += orbit_speed;
        if (orbit_angle >= 360)
        {
            orbit_angle -= 360;
        }
        if (orbit < orbit_grow)
        {
            orbit += 0.5;
        }
        if (orbit > 0)
        {
            x = lengthdir_x(orbit, orbit_angle) + center_x;
            y = lengthdir_y(orbit, orbit_angle) + center_y;
        }
        if (global.life <= 0 || expiry == 0)
        {
            life = 0;
        }
        if (obj_player.player_state == UnknownEnum.Value_5 || obj_player.player_state == UnknownEnum.Value_4)
        {
            life = 0;
        }
        image_xscale = target.image_xscale;
        if (target.wall_slide == true)
        {
            image_xscale = -target.image_xscale;
        }
        if (shoot_delay > 0)
        {
            shoot_delay--;
        }
        expiry--;
        if (expiry < 300)
        {
            if ((expiry % 2) == 0)
            {
                if (image_alpha == 0)
                {
                    image_alpha = 0.7;
                }
                else
                {
                    image_alpha = 0;
                }
            }
        }
        if (iframes > 0)
        {
            iframes--;
            if ((iframes % flicker_speed) == 0)
            {
                if (flicker == false)
                {
                    flicker = true;
                }
                else
                {
                    flicker = false;
                }
            }
        }
        else
        {
            flicker = false;
        }
    }
    else
    {
        life = 0;
    }
}
else
{
    instance_create_layer(x, y, "Explosions", obj_explosion);
    scr_make_sound(snd_explosion, 1, 1, false);
    instance_destroy();
}

enum UnknownEnum
{
    Value_4 = 4,
    Value_5
}
