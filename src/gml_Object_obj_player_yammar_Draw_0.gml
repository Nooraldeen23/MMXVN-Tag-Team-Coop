if (flicker == true)
{
    gpu_set_fog(true, #D3E8F8, 0, 0);
    draw_self();
    gpu_set_fog(false, #D3E8F8, 0, 0);
}
else
{
    draw_self();
}
