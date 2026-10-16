scr_make_sound(snd_menu_equip, 1, 1, false);
save_flash = 1;
obj_manager.save_slot = menu_position + 1;
with (obj_manager)
{
    event_user(0);
}
save_import = 0;
save_file = false;
