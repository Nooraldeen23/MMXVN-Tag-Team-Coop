if (global.pause == true)
{
    exit;
}
if (movement_freeze == false)
{
    if (colliding == true)
    {
        scr_update_ignore_coll();
        xspeed = scr_move(xspeed, 0);
        yspeed = scr_move(yspeed, 1);
        if (player_state == UnknownEnum.Value_4 && movement == true)
        {
            x = clamp(x, obj_camera.x - 200, obj_camera.x + 200);
        }
    }
    else
    {
        x += xspeed;
        y += yspeed;
    }
}
else
{
    speed = 0;
}

enum UnknownEnum
{
    Value_4 = 4
}
