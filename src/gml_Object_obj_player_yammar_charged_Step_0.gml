if (global.pause == true)
{
    exit;
}
if (expiry > 0 && global.life > 0)
{
    image_xscale = obj_player.image_xscale;
    if (obj_player.wall_slide == true)
    {
        image_xscale = -obj_player.image_xscale;
    }
    x_pos = (obj_player.x - (30 * image_xscale)) + offset_x;
    y_pos = (obj_player.y - 20) + offset_y;
    y_pos += (dsin(current_time * 0.5) * 1);
    x += ((x_pos - x) * 0.1);
    y += ((y_pos - y) * 0.1);
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
    var target_check = false;
    with (target)
    {
        if (life > 0 && place_meeting(x, y, obj_camera) && invul == false)
        {
            target_check = true;
        }
    }
    if (target_check == true && obj_player.movement == true)
    {
        event_user(10);
    }
    else
    {
        target = instance_nearest(x, y, obj_enemy_hostile);
    }
    if (obj_player.player_state == UnknownEnum.Value_5 || obj_player.player_state == UnknownEnum.Value_4)
    {
        expiry = 0;
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
