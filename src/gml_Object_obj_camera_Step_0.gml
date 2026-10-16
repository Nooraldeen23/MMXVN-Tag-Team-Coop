if (coop_enabled() && instance_exists(obj_coop_net) && obj_coop_net.spectating && instance_exists(obj_coop_net.remote))
{
    x = clamp(obj_coop_net.remote.x, global.view_width / 2, max(global.view_width / 2, room_width - (global.view_width / 2)));
    y = clamp(obj_coop_net.remote.y, global.view_height / 2, max(global.view_height / 2, room_height - (global.view_height / 2)));
    exit;
}
image_xscale = 430 / sprite_get_width(sprite_index);
image_yscale = 240 / sprite_get_height(sprite_index);
var check = false;
with (obj_player)
{
    if (place_meeting(x, y, obj_pit))
    {
        check = true;
    }
}
if (instance_exists(obj_camera_freemove))
{
    var find_space = 0;
    var find_transition_x = 0;
    var find_transition_y = 0;
    with (obj_player)
    {
        find_space = instance_place(x, y, obj_camera_freemove);
        if (find_space != -4)
        {
            if (find_space.active == false)
            {
                find_space = -4;
            }
        }
        if (find_space == -4)
        {
            check = false;
            with (obj_bossmanager)
            {
                if (bossfight_begin == true)
                {
                    check = true;
                }
            }
            if (check == false)
            {
                find_space = camera_lasttouch;
            }
        }
        find_transition_x = instance_place(x, y, obj_camera_horizontal);
        find_transition_y = instance_place(x, y, obj_camera_vertical);
    }
    if (find_space != -4)
    {
        var length_x = 16 * find_space.image_xscale;
        if (find_transition_x == -4)
        {
            x = clamp(obj_player.x, find_space.x + (global.view_width / 2), (find_space.x + length_x) - (global.view_width / 2));
        }
        else
        {
            x = obj_player.x;
        }
        var length_y = 16 * find_space.image_yscale;
        var border = 25;
        var scroll_speed = obj_player.yspeed;
        if (obj_player.on_slope == true)
        {
            scroll_speed = 1 + obj_player.yspeed;
        }
        with (obj_player)
        {
            with (instance_place(x, y + 1, obj_solid_moving))
            {
                scroll_speed = move_speed;
            }
        }
        if (scroll_speed < 0)
        {
            scroll_speed *= -1;
        }
        if ((obj_player.y < (y - border) && obj_player.on_slope == false) || (obj_player.y < (y + 30) && obj_player.on_slope == true))
        {
            y -= scroll_speed;
        }
        else if (obj_player.y > (y + border))
        {
            y += scroll_speed;
        }
        if (find_transition_y == -4)
        {
            y = clamp(y, find_space.y + (global.view_height / 2), (find_space.y + length_y) - (global.view_height / 2));
        }
        else
        {
            y = obj_player.y;
        }
    }
    else
    {
    }
    var find_boss = 0;
    with (obj_player)
    {
        find_boss = instance_place(x, y, obj_camera_bossroom);
    }
    with (find_boss)
    {
        if (active == false)
        {
            find_boss = -4;
        }
    }
    if (find_boss != -4)
    {
        x = find_boss.x;
        y = find_boss.y;
    }
}
