if (global.pause || global.death)
{
    exit;
}
lance_timer++;
if (!lance_landed)
{
    lance_old_x = x;
    lance_old_y = y;
    var distance = point_distance(x, y, lance_target_x, lance_target_y);
    var aim = point_direction(x, y, lance_target_x, lance_target_y);
    lance_speed = min(19, lance_speed + 0.75);
    x += lengthdir_x(min(distance, lance_speed), aim);
    y += lengthdir_y(min(distance, lance_speed), aim);
    image_angle = aim + 90;
    image_index = min(4, floor(lance_timer / 2));
    if (tagteam_sigma_line_hit(lance_old_x, lance_old_y, x, y, 6))
    {
        tagteam_sigma_hurt_player(8);
    }
    if (distance <= lance_speed)
    {
        lance_landed = true;
        image_angle = 0;
        tagteam_sigma_sfx("burst", 0.45);
        var impact = instance_create_layer(x, y - 5, "Explosions", obj_tag_sigma_fx);
        impact.image_xscale = 0.65;
        impact.image_yscale = 0.4;
    }
}
else
{
    lance_ground_timer++;
    image_index = (lance_ground_timer < 20) ? (2 + (floor(lance_ground_timer / 3) % 3)) : min(9, 5 + floor((lance_ground_timer - 20) / 3));
    if (lance_ground_timer < 20 && point_distance(obj_player.x, obj_player.y - 12, x, y - 8) < 16)
    {
        tagteam_sigma_hurt_player(7);
    }
    if (lance_ground_timer >= 35)
    {
        instance_destroy();
    }
}
