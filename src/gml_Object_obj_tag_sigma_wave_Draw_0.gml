for (var i = 0; i < array_length(wave_tail); i++)
{
    draw_sprite_ext(sprite_index, image_index, wave_tail[i][0], wave_tail[i][1], image_xscale, 0.4, 0, c_white, 0.04 + (0.035 * i));
}
draw_self();
