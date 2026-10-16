shootpos_x = 19;
shootpos_y = -8;
if (player_state == UnknownEnum.Value_4)
{
    shootpos_x = 32;
    shootpos_y = 8;
}
else if (player_state == UnknownEnum.Value_1)
{
    shootpos_x = 21;
    shootpos_y = -8;
}
else if (airborne == true)
{
    shootpos_y = -9;
}
else
{
    switch (sprite_index)
    {
        case spr_player_x_crouch:
        case spr_player_x_crouch_shooting:
        case spr_player_x_crouch_shot_charged:
            if (image_index < 1 && sprite_index == spr_player_x_crouch_shooting)
            {
                shootpos_y = -1;
                shootpos_x = 24;
            }
            else
            {
                shootpos_y = 5;
                shootpos_x = 25;
            }
            break;
        case spr_player_x_dash:
        case spr_player_x_dash_loop:
        case spr_player_x_dash_shooting:
        case spr_player_x_dash_shooting_loop:
            if (image_index < 1 && sprite_index == spr_player_x_dash_shooting)
            {
                shootpos_y = 4;
                shootpos_x = 26;
            }
            else if (image_index < 2 && sprite_index == spr_player_x_dash_shooting)
            {
                shootpos_y = 10;
                shootpos_x = 30;
            }
            else
            {
                shootpos_y = 5;
                shootpos_x = 33;
            }
            break;
        case spr_player_x_move_start:
        case spr_player_x_move_loop:
        case spr_player_x_move_start_shooting:
        case spr_player_x_move_loop_shooting:
            shootpos_y = -8;
            shootpos_x = 27;
            break;
    }
}
wall_slide_reverse = 1;
if (wall_slide == true)
{
    wall_slide_reverse = -1;
}
if (player_state == UnknownEnum.Value_0 || player_state == UnknownEnum.Value_1)
{
    shootpos_x *= (image_xscale * wall_slide_reverse);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_4 = 4
}
