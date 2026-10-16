event_inherited();
if (sig_state == "intro_descend" || sig_state == "intro_land" || sig_state == "p2_descend")
{
    var top = 304;
    var front = lerp(top, 546, clamp(sig_timer / 10, 0, 1));
    var fade = (sig_state == "intro_land") ? clamp(1 - (sig_timer / 24), 0, 1) : 1;
    var old_alpha = draw_get_alpha();
    var old_color = draw_get_color();
    gpu_set_blendmode(bm_add);
    for (var band = 0; band < 12; band++)
    {
        var band_y = lerp(top, front, band / 12);
        var next_y = lerp(top, front, (band + 1) / 12);
        draw_set_color(make_color_rgb(255, 95, 145));
        draw_set_alpha(fade * (0.12 + ((0.2 * band) / 12)));
        draw_rectangle(x - 5, band_y, x + 5, next_y, false);
        draw_set_color(c_white);
        draw_set_alpha(fade * (0.2 + ((0.35 * band) / 12)));
        draw_rectangle(x - 1, band_y, x + 1, next_y, false);
    }
    draw_sprite_ext(spr_pickup_soul_glow, 0, x, 544, 2.5, 0.55, 0, make_color_rgb(230, 100, 255), fade * 0.65);
    gpu_set_blendmode(bm_normal);
    draw_set_alpha(old_alpha);
    draw_set_color(old_color);
}
if (sig_state == "transform" || sig_state == "p2_arrive" || sig_state == "p2_arrive_finish" || sig_state == "p2_arrive_settle")
{
    var scale = 4;
    var alpha = 0.35;
    if (sig_state == "transform")
    {
        scale = 1.5 + (sig_timer / 9);
        alpha = 0.15 + ((0.35 * sig_timer) / 32);
    }
    if (sig_state == "p2_arrive_settle")
    {
        alpha *= clamp(1 - (sig_timer / sig_anim.duration), 0, 1);
    }
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(spr_pickup_soul_glow, 0, x, y - 48, scale, scale * 1.35, 0, make_color_rgb(172, 65, 255), alpha);
    draw_sprite_ext(spr_pickup_soul_glow, 0, x, y - 48, scale * 0.45, scale * 0.65, 0, make_color_rgb(238, 185, 255), alpha);
    gpu_set_blendmode(bm_normal);
}
if (sig_state == "p2_dprepare")
{
    draw_sprite_ext(spr_pickup_soul_glow, 0, x, 540, 2, 0.3, 0, make_color_rgb(190, 90, 255), 0.7);
}
if (sig_state == "p2_warpout" || sig_state == "p2_warphidden")
{
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(spr_pickup_soul_glow, 0, x, y - 45, 1.5, 4, 0, make_color_rgb(170, 75, 255), (sig_state == "p2_warpout") ? 0.35 : 0.15);
    gpu_set_blendmode(bm_normal);
}
if (sig_enraged && !sig_death && !isHit && !boss_flicker)
{
    var skin = asset_get_index(sprite_get_name(sprite_index) + "_electric");
    if (skin != -1)
    {
        draw_sprite_ext(skin, image_index, x, y, image_xscale, image_yscale, 0, c_white, 0.62 + (0.28 * sin(sig_electric_clock * 0.35)));
    }
}
if (sig_state == "p2_enrage")
{
    var burst = sig_timer % 23;
    var a = clamp(1 - (burst / 10), 0, 1);
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(spr_title_lightning, 0, x, y - 130, 0.6, 1.1, 0, make_color_rgb(215, 195, 255), a);
    draw_sprite_ext(spr_pickup_soul_glow, 0, x, y - 50, 4, 5, 0, make_color_rgb(165, 90, 255), 0.3 + (0.2 * sin(sig_timer)));
    gpu_set_blendmode(bm_normal);
}
if (sig_state == "p2_cprepare")
{
    var edge = (sig_face < 0) ? 64 : 384;
    draw_set_color(make_color_rgb(190, 115, 255));
    draw_set_alpha(0.2 + (0.15 * sin(sig_timer / 4)));
    draw_line_width(x + (sig_face * 27), y - 49, edge, y - 49, 2);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
