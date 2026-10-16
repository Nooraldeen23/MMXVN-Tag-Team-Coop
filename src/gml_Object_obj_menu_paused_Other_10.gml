if (global.pause_screen_state == 2 && !instance_exists(obj_fade_in))
{
    fade = instance_create_depth(obj_camera.x, obj_camera.y, 0, obj_fade_out);
    fade.fade_speed = global.pause_screen_speed;
    global.pause_screen_state = 3;
}
