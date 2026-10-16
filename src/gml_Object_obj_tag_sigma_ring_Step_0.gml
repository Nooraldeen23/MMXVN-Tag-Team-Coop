if (global.pause)
{
    exit;
}
if (global.death || !instance_exists(ring_owner) || ring_owner.sig_death)
{
    instance_destroy();
    exit;
}
ring_timer++;
var old_x = x;
x += (ring_face * ring_velocity);
image_index = floor(ring_timer / 3) % 12;
image_xscale = ring_face;
if (instance_exists(obj_player) && ring_timer > 8)
{
    var px = (obj_player.bbox_left + obj_player.bbox_right) / 2;
    var crossing = px >= (min(old_x, x) - 9) && px <= (max(old_x, x) + 9);
    var top_hit = obj_player.bbox_bottom > (y - 43) && obj_player.bbox_top < (y - 29);
    var bottom_hit = obj_player.bbox_bottom > (y + 29) && obj_player.bbox_top < (y + 43);
    if (crossing && (top_hit || bottom_hit))
    {
        tagteam_sigma_hurt_player(8);
    }
}
if (x < 54 || x > 394 || ring_timer > 145)
{
    instance_destroy();
}
