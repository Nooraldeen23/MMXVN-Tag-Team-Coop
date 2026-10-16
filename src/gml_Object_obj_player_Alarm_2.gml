if (global.death == false)
{
    if (hurt == false)
    {
        if (flicker == false)
        {
            flicker = true;
        }
        else
        {
            flicker = false;
        }
    }
    if (recovery == 1)
    {
        alarm[2] = 4;
    }
    else
    {
        flicker = false;
    }
}
