if (airborne == false)
{
    dash = false;
    airdash_lock = false;
    xspeed = 0;
    airdash_point = 0;
}
if (airdash_state > 1)
{
    if (hurt == false)
    {
        xspeed = 0;
        yspeed = 0;
    }
    event_user(5);
}
