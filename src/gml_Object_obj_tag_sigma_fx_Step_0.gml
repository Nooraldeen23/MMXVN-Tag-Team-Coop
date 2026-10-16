if (global.pause)
{
    exit;
}
fx_timer++;
image_index = min(sprite_get_number(sprite_index) - 1, fx_frame + floor(fx_timer / 2));
image_alpha = 1 - (fx_timer / fx_lifetime);
if (fx_timer >= fx_lifetime)
{
    instance_destroy();
}
