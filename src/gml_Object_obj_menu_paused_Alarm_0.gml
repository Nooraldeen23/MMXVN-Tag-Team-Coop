if (blink < 3)
{
    blink++;
    alarm[0] = 5;
}
else
{
    blink = 0;
    alarm[0] = random_range(120, 600);
}
