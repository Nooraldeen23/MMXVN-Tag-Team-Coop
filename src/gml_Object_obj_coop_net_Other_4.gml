room_epoch++;
with (obj_coop_remote)
{
    instance_destroy();
}
remote = -4;
with (obj_coop_foe)
{
    instance_destroy();
}
with (obj_coop_shot)
{
    coop_expired = true;
    instance_destroy();
}
with (obj_coop_pickup)
{
    instance_destroy();
}
ds_map_clear(entities);
ds_map_clear(client_shots);
ds_map_clear(consumed_shots);
profile_dirty = true;
coop_log("ROOM " + room_get_name(room) + " epoch=" + string(room_epoch));
downed = 0;
with (obj_coop_npc)
{
    instance_destroy();
}
with (obj_coop_dialogue)
{
    instance_destroy();
}
ds_map_clear(fx_sent);
ds_map_clear(fx_remote);
if (room == rm_stage_select)
{
    lives_ready = false;
    spectating = false;
    global.death = false;
    global.life = global.lifemax;
    global.lives = 2;
}
if (spectating)
{
    global.life = 0;
}
ds_map_clear(solid_registry);
ds_map_clear(solid_removed);
solid_revision = 0;
solid_seen_revision = -1;
coop_register_solids();
