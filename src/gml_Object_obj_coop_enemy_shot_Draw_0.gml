if (!visible || sprite_index < 0 || image_alpha <= 0)
{
    exit;
}
if (palette_type > 0)
{
    pal_swap_set(palette_type, palette, false);
}
draw_self();
if (palette_type > 0)
{
    pal_swap_reset();
}
