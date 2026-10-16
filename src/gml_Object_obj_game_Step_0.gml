tagteam_check_partner_rescue();
if (global.pause == false)
{
    global.animate++;
}
if (!coop_enabled() && global.death == false && global.life <= 0)
{
    global.death = true;
    alarm[0] = 15;
    with (obj_player)
    {
        sprite_index = global.playable_character.action.hurt;
        image_speed = 0;
        image_index = 0;
        movement_freeze = true;
    }
}
if (!coop_enabled() && global.death == true)
{
    if (death_animation > 0 && death_animation < 3)
    {
        if (global.black_armour_get == true && global.playable_character.name == "Zero")
        {
            particle = instance_create_layer(obj_player.x, obj_player.y, "Explosions", obj_particle_animated);
            particle.sprite_index = spr_effect_death_zero_black;
            particle.speed = random_range(4, 5);
            particle.direction = irandom(359);
            particle.image_index = irandom(particle.image_number - 1);
            particle.depth += 1;
        }
        else
        {
            particle = instance_create_layer(obj_player.x, obj_player.y, "Explosions", obj_particle_animated);
            particle.sprite_index = global.playable_character.visual.death_particle;
            particle.speed = random_range(4, 5);
            particle.direction = irandom(359);
            particle.image_index = irandom(particle.image_number - 1);
            particle.depth += 1;
        }
    }
    with (obj_fade_out)
    {
        if (alpha == 1)
        {
            if (global.lives_toggle == true && room != rm_training)
            {
                global.lives--;
            }
            if (global.lives_toggle == true && global.lives < 0)
            {
                if (room == rm_intro)
                {
                    global.checkpointx = obj_player.xstart;
                    global.checkpointy = obj_player.ystart;
                    global.lives = global.lives_start + 1;
                }
                else
                {
                    room_goto(rm_stage_select);
                    global.lives = global.lives_start;
                }
            }
            else
            {
                room_restart();
            }
        }
    }
}
if (!coop_enabled())
{
    with (obj_spawnzone)
    {
        var despawn_threshold = global.view_width / 4;
        var array = obj_manager.store_respawn;
        for (var a = 0; a < 500; a++)
        {
            if (array[a].store_object != -1)
            {
                var x_collision = array[a].store_x > (x - (sprite_width / 2) - despawn_threshold) && array[a].store_x < (x + (sprite_width / 2) + despawn_threshold);
                var y_collision = array[a].store_y > ((y - (sprite_height / 2)) + 30) && array[a].store_y < ((y + (sprite_height / 2)) - 30);
                if (x_collision && y_collision)
                {
                    if (array[a].respawn == 1 || array[a].respawn == 242)
                    {
                        spawn = instance_create_depth(array[a].store_x, array[a].store_y, array[a].store_depth, array[a].store_object);
                        spawn.image_yscale = array[a].store_yscale;
                        spawn.image_angle = array[a].store_angle;
                        spawn.enemy_type = array[a].store_type;
                        array[a].store_x = 0;
                        array[a].store_y = 0;
                        array[a].store_depth = 0;
                        array[a].store_object = -1;
                        array[a].store_xscale = 0;
                        array[a].store_yscale = 0;
                        array[a].store_angle = 0;
                        array[a].store_type = 0;
                        array[a].respawn = 0;
                        a = 500;
                    }
                }
                else
                {
                    array[a].respawn = 1;
                }
            }
        }
    }
}
else if (!coop_client())
{
    var records = obj_manager.store_respawn;
    var margin = global.view_width / 4;
    for (var slot = 0; slot < 500; slot++)
    {
        if (records[slot].store_object != -1)
        {
            var record = records[slot];
            var inside = false;
            with (obj_spawnzone)
            {
                if (record.store_x > (bbox_left - margin) && record.store_x < (bbox_right + margin) && record.store_y > (bbox_top + 30) && record.store_y < (bbox_bottom - 30))
                {
                    inside = true;
                }
            }
            if (inside)
            {
                if (record.respawn == 1 || record.respawn == 242)
                {
                    var enemy = instance_create_depth(record.store_x, record.store_y, record.store_depth, record.store_object);
                    enemy.image_xscale = record.store_xscale;
                    enemy.image_yscale = record.store_yscale;
                    enemy.image_angle = record.store_angle;
                    enemy.enemy_type = record.store_type;
                    record.store_x = 0;
                    record.store_y = 0;
                    record.store_depth = 0;
                    record.store_object = -1;
                    record.store_xscale = 0;
                    record.store_yscale = 0;
                    record.store_angle = 0;
                    record.store_type = 0;
                    record.respawn = 0;
                    break;
                }
            }
            else
            {
                record.respawn = 1;
            }
        }
    }
}
event_user(0);
if (souls_timer > 0)
{
    souls_timer--;
    souls_alpha -= 0.01;
    souls_y_target = 0;
}
else
{
    souls_collected = 0;
    souls_alpha = 1.5;
    souls_y_target = 125;
}
souls_y += ((souls_y_target - souls_y) * 0.1);
if (wheel_state > 0)
{
    if (wheel_animate < 5)
    {
        wheel_animate++;
    }
    else if (wheel_state < 30)
    {
        wheel_state++;
    }
    else
    {
        wheel_state = 0;
    }
}
else if (wheel_state == 0)
{
    if (wheel_animate > 0)
    {
        wheel_animate--;
    }
}
