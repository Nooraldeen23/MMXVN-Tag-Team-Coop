with (obj_tag_colonel_wave)
{
    instance_destroy();
}
with (obj_tag_colonel_bolt)
{
    instance_destroy();
}
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
event_inherited();
