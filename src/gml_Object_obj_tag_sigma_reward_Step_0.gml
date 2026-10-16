if (coop_client())
{
    visible = false;
    exit;
}
event_inherited();
pickup_type = 7;
pickup_power = reward_bait ? 0 : 500;
pickup_expiry = -1;
image_speed = global.pause ? 0 : 1;
image_xscale = 1.25;
image_yscale = 1.25;
