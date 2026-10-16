if (sprite_index == spr_pickup_soul_mega_appear)
{
    sprite_index = spr_pickup_soul_mega;
    image_index = 0;
    image_speed = 1;
    reward_ready = true;
}
else
{
    event_inherited();
}
