instance_create_layer(x, y, "Collision", obj_spawnzone);
instance_create_layer(x, y, "Collision", obj_camera);
instance_create_layer(x, y, "Instances", obj_part_manager);
global.animate = 0;
global.hud_toggle = false;
pal_swap_init_system(shd_pal_swapper, shd_pal_html_sprite, shd_pal_html_surface);
base_life = 32;
global.life = base_life;
global.lifemax = base_life;
life_tick = global.life;
life_extend = 0;
global.death = false;
death_animation = 0;
global.music = "Off";
souls_collected = 0;
souls_timer = 0;
souls_alpha = 0;
souls_y_target = 125;
souls_y = souls_y_target;
system = part_system_create();
part_system_depth(system, depth - 1);
fade = instance_create_depth(obj_camera.x, obj_camera.y, 0, obj_fade_in);
fade.fade_speed = 0.01;
spawning_start = false;
alarm[1] = 30;
if (room == rm_turtloid)
{
    C1 = layer_get_id("Water");
    layer_script_begin(C1, scr_water_start);
    layer_script_end(C1, scr_water_end);
}
wheel_animate = 0;
wheel_state = 0;
depth = 0;
