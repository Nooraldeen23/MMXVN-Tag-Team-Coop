stageselect_state = 1;
event_user(3);
if (room == rm_stage_select)
{
    alarm[2] = 60;
    global.level_completed = false;
}
