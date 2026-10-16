if (global.pause)
{
    exit;
}
event_inherited();
wave_timer++;
image_index = floor(wave_timer / 2) % sprite_get_number(sprite_index);
image_xscale = (direction > 90 && direction < 270) ? 0.4 : -0.4;
array_push(wave_tail, [x, y]);
if (array_length(wave_tail) > 3)
{
    array_delete(wave_tail, 0, 1);
}
if (x < 68 || x > 380 || wave_timer >= 90)
{
    instance_destroy();
}
