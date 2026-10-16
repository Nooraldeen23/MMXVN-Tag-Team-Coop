if (secret_death_voice != -1)
{
    audio_stop_sound(secret_death_voice);
}
if (secret_music != -1)
{
    audio_stop_sound(secret_music);
    if (global.music == snd_tag_sigma_theme || global.music == secret_music_asset)
    {
        global.music = "Off";
    }
}
