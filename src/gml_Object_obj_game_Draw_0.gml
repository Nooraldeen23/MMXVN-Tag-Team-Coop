if (wheel_animate > 0)
{
    draw_sprite_ext(spr_wheel_ring, wheel_animate, obj_player.x, obj_player.y, 1, 1, 0, c_white, 0.7);
    var wheel_amount = 8;
    var wheel_expand = 10 * (wheel_animate - 1);
    for (var a = 0; a < wheel_amount; a++)
    {
        if (global.weapon[a + 1].type != 0)
        {
            var wheel_angle = ((360 / wheel_amount) * -a) + 90;
            if (global.weapon_choice == (a + 1))
            {
                draw_sprite_ext(spr_wheel_icon, 1, obj_player.x + lengthdir_x(wheel_expand, wheel_angle), obj_player.y + lengthdir_y(wheel_expand, wheel_angle), 1, 1, 0, c_white, 1);
                scr_draw_sprite_outlined(obj_player.x + lengthdir_x(wheel_expand, wheel_angle), (obj_player.y + lengthdir_y(wheel_expand, wheel_angle)) - 1, 16777215, 16777215, global.playable_character.visual.weapon_icon, a + 1, 1, 1, true);
            }
            else
            {
                draw_sprite_ext(spr_wheel_icon, 0, obj_player.x + lengthdir_x(wheel_expand, wheel_angle), obj_player.y + lengthdir_y(wheel_expand, wheel_angle), 1, 1, 0, c_white, 1);
                draw_sprite_ext(global.playable_character.visual.weapon_icon, a + 1, obj_player.x + lengthdir_x(wheel_expand, wheel_angle), (obj_player.y + lengthdir_y(wheel_expand, wheel_angle)) - 1, 1, 1, 0, c_white, 1);
            }
        }
    }
}
