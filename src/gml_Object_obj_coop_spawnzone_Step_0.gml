if (!instance_exists(obj_coop_net) || !instance_exists(obj_coop_net.remote))
{
    instance_destroy();
    exit;
}
x = obj_coop_net.remote.x;
y = obj_coop_net.remote.y;
image_xscale = 760 / sprite_get_width(sprite_index);
image_yscale = 540 / sprite_get_height(sprite_index);
