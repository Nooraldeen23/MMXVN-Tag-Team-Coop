if (tag_state > 0)
{
    exit;
}
if ((global.input_up || (global.input_down && airborne == true)) && player_state == UnknownEnum.Value_0 && climbing_dismount == false)
{
    player_state = UnknownEnum.Value_1;
    event_user(5);
    airdash_lock = false;
    yspeed = 0;
    xspeed = 0;
    dash = false;
    wall_jump = false;
}
if (!global.input_up && !global.input_down)
{
    climbing_dismount = false;
}
if (global.input_down_pressed && player_state == UnknownEnum.Value_0 && obj_player.y < ((other.y + (16 * other.image_yscale)) - 0.1) && climbing_dismount == false)
{
    player_state = UnknownEnum.Value_1;
    event_user(5);
    airdash_lock = false;
    x = instance_place(x, y, obj_ladder).x + 8;
    yspeed = 0;
    xspeed = 0;
    dash = false;
    wall_jump = false;
    if (y < other.y)
    {
        y += 24;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
