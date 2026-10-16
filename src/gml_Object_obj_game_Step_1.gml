if (room == rm_title && variable_global_exists("pause_menu_sub") && global.pause_menu_sub == "Co-op")
{
    audio_stop_sound(snd_music_title);
    audio_stop_sound(snd_ambience_nightmarestorm);
    exit;
}
if (global.music != "Off")
{
    if (global.music == "Level")
    {
        switch (room)
        {
            case rm_intro:
                global.music = snd_music_intro;
                if (obj_player.x > 14832)
                {
                    global.music = snd_music_haunted;
                }
                break;
            case rm_yammark:
                global.music = snd_music_yammark;
                break;
            case rm_turtloid:
                global.music = snd_music_turtloid;
                break;
            case rm_heatnix:
                global.music = snd_music_heatnix;
                break;
            case rm_mijinion:
                global.music = snd_music_mijinion;
                break;
            case rm_weapon_get:
                global.music = snd_music_weapon_get;
                break;
            case rm_training:
                global.music = snd_music_training;
                break;
            case rm_template:
                global.music = snd_music_dragoon_kimura;
                break;
            default:
                global.music = "Off";
                exit;
        }
    }
    if (!audio_is_playing(global.music))
    {
        scr_music_loop();
        scr_make_sound(global.music, 1, 1, true);
    }
}
