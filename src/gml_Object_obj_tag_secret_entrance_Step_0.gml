if (coop_enabled())
{
    instance_destroy();
    exit;
}
if (room != rm_turtloid || !instance_exists(obj_player))
{
    instance_destroy();
    exit;
}
if (global.pause || global.death || instance_exists(obj_dialogue) || instance_exists(obj_comic_parent))
{
    exit;
}
if (instance_exists(secret_fade))
{
    if (secret_fade.alpha >= 1)
    {
        global.tag_return_x = 208;
        global.tag_return_y = 2217;
        instance_destroy(secret_fade);
        instance_destroy();
        room_goto(rm_tag_sigma);
    }
    exit;
}
if (obj_player.x < 64 && obj_player.y > 2150 && obj_player.y < 2250 && obj_player.movement && global.input_left)
{
    secret_hold++;
    if (secret_hold >= 18)
    {
        secret_fade = instance_create_depth(obj_player.x, obj_player.y, -1000, obj_fade_out);
        secret_fade.fade_speed = 0.06;
        obj_player.movement = false;
        scr_make_sound(global.playable_character.sound.warp_out, 1, 1, false);
    }
}
else
{
    secret_hold = 0;
}
