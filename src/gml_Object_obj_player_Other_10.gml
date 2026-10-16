if (global.pause == true && combo_timer < 10)
{
    exit;
}
if (animation_lock == true)
{
    exit;
}
if (global.life > 0)
{
    spr_manager.update();
}
with (obj_bullet_saber)
{
    speed_change = true;
    switch (sprite_index)
    {
        case spr_bullet_x_saber:
        case spr_bullet_x_saber_fire:
        case spr_bullet_x_saber_blade:
        case spr_bullet_x_saber_blade_charged:
            if (obj_player.sprite_index != spr_player_x_saber)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_x_saber_jump:
        case spr_bullet_x_saber_fire_jump:
        case spr_bullet_x_saber_blade_jump:
        case spr_bullet_x_saber_blade_jump_charged:
            if (obj_player.sprite_index != spr_player_x_saber_jump && obj_player.sprite_index != spr_player_x_saber_landing)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_x_saber_wall:
        case spr_bullet_x_saber_fire_wall:
        case spr_bullet_x_saber_blade_wall:
        case spr_bullet_x_saber_blade_wall_charged:
            if (obj_player.sprite_index != spr_player_x_saber_walljump)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_x_machdash:
        case spr_bullet_x_machdash_charged:
            speed_change = false;
            if (!(obj_player.sprite_index == spr_player_x_machdash || obj_player.sprite_index == spr_player_x_machdash_up || obj_player.sprite_index == spr_player_x_machdash_down))
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber:
            if (obj_player.sprite_index != spr_player_zero_saber)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_player_zero_saber_upattack:
            if (obj_player.sprite_index != spr_player_zero_upattack)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber_2:
            if (obj_player.sprite_index != spr_player_zero_saber_2)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber_3:
            if (obj_player.sprite_index != spr_player_zero_saber_3)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber_crouch:
            if (obj_player.sprite_index != spr_player_zero_saber_crouch)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber_walljump:
            if (obj_player.sprite_index != spr_player_zero_saber_walljump)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber_climb:
            if (obj_player.sprite_index != spr_player_zero_saber_climb)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber_jump:
            if (obj_player.sprite_index != spr_player_zero_saber_jump && obj_player.sprite_index != spr_player_zero_saber_landing)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber_jump_double:
            if (obj_player.sprite_index != spr_player_zero_saber_jump_double)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber_ensuizan:
            if (obj_player.sprite_index != spr_player_zero_saber_ensuizan)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber_shoenzan_charged:
            if (obj_player.sprite_index != spr_player_zero_saber_shoenzan_charged)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_saber_shoenzan_underwater:
            if (obj_player.sprite_index != spr_player_zero_saber_shoenzan_charged)
            {
                instance_destroy(id, false);
            }
            break;
        case spr_bullet_zero_ryuenjin:
            if (obj_player.sprite_index != spr_player_zero_ryuenjin)
            {
                instance_destroy(id, false);
            }
            break;
    }
}
