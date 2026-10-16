if (global.pause || global.death)
{
    exit;
}
if (!instance_exists(beam_owner) || beam_owner.sig_state != "p2_cfire")
{
    instance_destroy();
    exit;
}
beam_timer++;
x = beam_owner.x + (beam_face * 27);
y = beam_owner.y - 49;
var bx = (beam_face < 0) ? 64 : 384;
if (beam_timer >= 14 && tagteam_sigma_line_hit(x, y, bx, y, (beam_big ? 48 : 24) * clamp(beam_timer / 14, 0, 1)))
{
    tagteam_sigma_hurt_player(beam_big ? 13 : 11);
}
