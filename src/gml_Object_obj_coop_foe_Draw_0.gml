if (sprite_index == -1 || image_alpha <= 0)
{
    exit;
}
if (isHit || (boss && coop_boss_flicker))
{
    gpu_set_fog(true, make_color_rgb(211, 232, 248), 0, 0);
}
if (coop_kind == obj_enemy_moth && coop_native_jet)
{
    var jet = spr_enemy_moth_jet;
    if (sprite_index == spr_enemy_moth)
    {
        if (image_index > 1)
        {
            jet = spr_enemy_moth_jet_3;
        }
        else if (image_index > 0)
        {
            jet = spr_enemy_moth_jet_2;
        }
    }
    draw_sprite_ext(jet, global.animate / 5, x, y, image_xscale, 1, 0, c_white, image_alpha);
}
if (coop_kind == obj_boss_donut && variable_instance_exists(id, "coop_draw_angle"))
{
    draw_sprite_ext(sprite_index, image_index, x, y, 1, image_yscale, coop_draw_angle, image_blend, image_alpha);
}
else
{
    draw_self();
}
if (isHit || (boss && coop_boss_flicker))
{
    gpu_set_fog(false, make_color_rgb(211, 232, 248), 0, 0);
}
if (coop_kind == obj_weather_machine && shield_fade > 0)
{
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(spr_weather_machine_shield, global.animate / 4, x, y, image_xscale, image_yscale, 0, c_white, shield_fade);
    gpu_set_blendmode(bm_normal);
}
