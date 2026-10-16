with (obj_explosion)
{
    if (variable_instance_exists(id, "tag_sigma_owner") && tag_sigma_owner == other.id)
    {
        instance_destroy();
    }
}
if (font_exists(sig_hud_font))
{
    font_delete(sig_hud_font);
}
if (sig_audio_charge != -1)
{
    audio_stop_sound(sig_audio_charge);
}
if (sig_audio_laser != -1)
{
    audio_stop_sound(sig_audio_laser);
}
event_inherited();
