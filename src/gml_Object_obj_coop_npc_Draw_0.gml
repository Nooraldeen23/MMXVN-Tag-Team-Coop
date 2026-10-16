pal_swap_set(spr_reploid_palette_main, palette_main, false);
coop_draw_proxy();
pal_swap_set(spr_reploid_palette_skin, palette_skin, false);
coop_draw_proxy();
pal_swap_set(spr_reploid_palette_secondary, palette_secondary, false);
coop_draw_proxy();
pal_swap_reset();
if (!openning && sprite_index != spr_reploid_warp)
{
    var cry = rescued ? spr_reploid_thanks : spr_reploid_help;
    draw_sprite_ext(cry, global.animate / 10, x, y - (sprite_height / 2) - 6, 1, 1, 0, c_white, 1);
}
