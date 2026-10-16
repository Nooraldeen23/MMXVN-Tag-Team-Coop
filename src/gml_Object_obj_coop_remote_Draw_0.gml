if (!visible || sprite_index == -1)
{
    exit;
}
if (coop_flash)
{
    gpu_set_fog(true, make_color_rgb(211, 232, 248), 0, 0);
}
else if (coop_palette_sprite != -1)
{
    pal_swap_set(coop_palette_sprite, coop_palette, false);
}
coop_draw_proxy();
if (coop_flash)
{
    gpu_set_fog(false, make_color_rgb(211, 232, 248), 0, 0);
}
else if (coop_palette_sprite != -1)
{
    pal_swap_reset();
}
