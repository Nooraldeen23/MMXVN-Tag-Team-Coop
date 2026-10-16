if (death_animation == 0)
{
    scr_make_sound(snd_player_death, 1, 1, false);
    scr_player_voicelines("Death");
}
if (death_animation < 3)
{
    death_animation++;
    alarm[0] = 15;
    var particle_offset = 0;
    var particle_amount = 8;
    if (death_animation == 2)
    {
        particle_offset = 22.5;
    }
    if (death_animation == 3)
    {
        particle_amount = 16;
        particle_offset = 11;
    }
    for (var i = 0; i < particle_amount; i++)
    {
        if (global.black_armour_get == true && global.playable_character.name == "Zero")
        {
            particle = instance_create_layer(obj_player.x, obj_player.y, "Explosions", obj_particle_animated);
            particle.sprite_index = spr_effect_death_ring_zero_black;
            particle.speed = 1 + (death_animation / 2);
            particle.direction = particle_offset + ((360 / particle_amount) * i);
        }
        else
        {
            particle = instance_create_layer(obj_player.x, obj_player.y, "Explosions", obj_particle_animated);
            particle.sprite_index = global.playable_character.visual.death_ring;
            particle.speed = 1 + (death_animation / 2);
            particle.direction = particle_offset + ((360 / particle_amount) * i);
        }
    }
    with (obj_player)
    {
        image_alpha = 0;
    }
}
if (death_animation == 3)
{
    fade = instance_create_depth(obj_camera.x, obj_camera.y, 0, obj_fade_out);
    fade.fade_speed = 0.005;
}
