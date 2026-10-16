if (global.coop_role != 1 || !connected || !coop_enabled() || !coop_play_room())
{
    exit;
}
with (obj_explosion)
{
    coop_send_native_effect();
}
with (obj_particle_cut)
{
    coop_send_native_effect();
}
coop_fx_lifecycle();
if ((tick % 15) == 0)
{
    coop_personal_save();
}
