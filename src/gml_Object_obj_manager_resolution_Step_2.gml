camera_set_view_size(view_camera[0], global.view_width, global.view_height);
if (instance_exists(obj_spawnzone))
{
    camera_set_view_pos(view_camera[0], obj_spawnzone.x - (global.view_width / 2), obj_spawnzone.y - (global.view_height / 2));
}
