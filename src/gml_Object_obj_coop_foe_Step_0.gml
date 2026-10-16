var old_x = x;
var old_y = y;
var old_left = bbox_left;
var old_right = bbox_right;
var old_top = bbox_top;
coop_proxy_motion();
image_speed = 0;
if ((current_time - coop_seen) > 1500)
{
    instance_destroy();
    exit;
}
if (colliding && collide_vertical && instance_exists(obj_player))
{
    var rider = obj_player;
    var dx = x - old_x;
    var dy = y - old_y;
    if (abs(dx) < 24 && abs(dy) < 24 && rider.yspeed >= 0 && rider.bbox_right > old_left && rider.bbox_left < old_right && abs(rider.bbox_bottom - old_top) <= 4)
    {
        with (rider)
        {
            if (dx != 0)
            {
                scr_move(dx, 0);
            }
            if (dy != 0)
            {
                scr_move(dy, 1);
            }
        }
    }
}
