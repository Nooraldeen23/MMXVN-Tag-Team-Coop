if (global.pause)
{
    exit;
}
if (beam_timer == 0)
{
    beam_face = image_xscale;
}
beam_timer++;
speed = 0;
yspeed = 0;
damage = 18;
tick = false;
piercing = true;
phasing = true;
palette_type = 0;
sprite_index = spr_tag_beam_mask;
image_xscale = beam_face * 1.7857142857142858;
image_yscale = 1;
event_inherited();
