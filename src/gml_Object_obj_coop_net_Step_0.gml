if (global.coop_role == 1 && coop_enabled())
{
    with (obj_boss_parent)
    {
        if ((!variable_instance_exists(id, "coop_hp_scaled") || !coop_hp_scaled) && lifemax > 0 && lifemax < 99999)
        {
            coop_hp_scaled = true;
            life *= 2;
            lifemax *= 2;
            if (variable_instance_exists(id, "absorb_cap"))
            {
                absorb_cap = lifemax;
            }
            coop_log("BOSS_HP_X2 " + object_get_name(object_index) + " max=" + string(lifemax));
        }
    }
}
if (coop_enabled())
{
    coop_trim_tag_upgrades();
}
tick++;
if (global.coop_role == 2 && !connected && room == rm_title && tick >= connect_retry_at && (!connect_inflight || (tick - connect_started_tick) >= 600))
{
    if (socket >= 0)
    {
        network_destroy(socket);
    }
    socket = network_create_socket(network_socket_tcp);
    peer = -1;
    connect_inflight = true;
    connect_started_tick = tick;
    connect_retry_at = tick + 120;
    connect_attempts++;
    status = "Connecting (attempt " + string(connect_attempts) + ")";
    network_connect_async(socket, global.coop_host, global.coop_port);
    coop_log("CONNECT_RETRY " + string(connect_attempts) + " " + global.coop_host + ":" + string(global.coop_port));
}
if (connected && (tick % 120) == 0)
{
    coop_send(coop_packet("op", "ping"));
}
if (!coop_enabled())
{
    exit;
}
if (connected && (tick - rx_tick) > 600)
{
    coop_connection_lost();
    if (instance_exists(remote))
    {
        remote.visible = false;
    }
    coop_log("TIMEOUT");
}
if (global.coop_role == 2 && pending_room != "" && asset_get_index(pending_room) != room)
{
    var next = asset_get_index(pending_room);
    if (next != -1)
    {
        pending_room = "";
        global.pause = false;
        global.pause_screen = false;
        global.death = false;
        room_goto(next);
        exit;
    }
}
if (instance_exists(obj_player) && coop_play_room())
{
    coop_apply_character();
    if (!instance_exists(remote))
    {
        remote = instance_create_depth(obj_player.x + 24, obj_player.y, -1, obj_coop_remote);
    }
    if (global.coop_role == 1 && connected && instance_exists(remote) && !instance_exists(obj_coop_spawnzone))
    {
        instance_create_depth(remote.x, remote.y, 0, obj_coop_spawnzone);
    }
    if (global.coop_role == 2)
    {
        with (obj_enemy_parent)
        {
            if (object_index != obj_coop_foe)
            {
                visible = false;
                image_alpha = 0;
                mask_index = spr_coop_empty_mask;
                damage = 0;
                invul = true;
            }
        }
        with (obj_bossmanager)
        {
            visible = false;
            damage = 0;
            invul = true;
        }
    }
}
if (connected && global.coop_role == 1)
{
    if (profile_dirty && is_array(global.weapon) && (coop_play_room() || room == rm_stage_select))
    {
        with (obj_manager)
        {
            save_slot = 0;
            event_user(0);
        }
        if (variable_instance_exists(obj_manager, "json_export_string"))
        {
            coop_send(coop_packet("op", "profile", "save", obj_manager.json_export_string, "room", room_get_name(room), "first", !profile_sent));
            profile_sent = true;
            profile_dirty = false;
        }
    }
    if ((tick % 3) == 0 && coop_play_room())
    {
        coop_send(coop_scene_packet());
    }
}
if (global.coop_role == 2 && instance_exists(obj_player) && coop_play_room() && connected)
{
    if (variable_instance_exists(id, "host_blocked") && host_blocked)
    {
        obj_player.movement = false;
        obj_player.xspeed = 0;
    }
    else if ((!instance_exists(obj_cutscene_level_start) || obj_cutscene_level_start.action >= 4) && !global.death && !global.pause && !global.pause_screen && !coop_local_healing())
    {
        obj_player.movement = true;
    }
}
with (obj_coop_foe)
{
    if ((current_time - coop_seen) > 1500)
    {
        instance_destroy();
    }
}
with (obj_coop_shot)
{
    if ((current_time - coop_seen) > 1000)
    {
        instance_destroy();
    }
}
if (global.coop_smoke && (tick % 300) == 0)
{
    coop_log("PERF fps=" + string(fps) + " capacity=" + string(fps_real));
}
with (obj_coop_pickup)
{
    if (coop_epoch != obj_coop_net.world_tick)
    {
        instance_destroy();
    }
}
if (global.coop_role == 2 && connected)
{
    if (pending_restart && pending_room != "" && asset_get_index(pending_room) == room)
    {
        pending_restart = false;
        pending_room = "";
        global.death = false;
        global.life = global.lifemax;
        room_restart();
        exit;
    }
}
if (global.coop_role == 1 && connected && global.coop_campaign_active && (tick % 3) == 0 && !coop_play_room() && room != rm_title && room != rm_skip_title)
{
    coop_send(coop_scene_packet());
}
with (obj_coop_npc)
{
    if (coop_epoch != obj_coop_net.world_tick)
    {
        instance_destroy();
    }
}
if (coop_client())
{
    with (obj_reploid)
    {
        if (object_index != obj_coop_npc)
        {
            visible = false;
            mask_index = spr_coop_empty_mask;
        }
    }
    with (obj_dialogue)
    {
        if (object_index != obj_coop_dialogue)
        {
            instance_destroy();
        }
    }
}
coop_party_step();
with (obj_coop_foe)
{
    if (coop_epoch != obj_coop_net.world_tick)
    {
        instance_destroy();
    }
}
if (coop_client())
{
    with (obj_enemy_parent)
    {
        if (object_index != obj_coop_foe)
        {
            visible = false;
            image_alpha = 0;
            damage = 0;
            instance_deactivate_object(id);
        }
    }
    with (obj_bullet_default)
    {
        if (villainy == 2 && object_index != obj_coop_enemy_shot)
        {
            instance_destroy();
        }
    }
}
if (coop_client())
{
    with (obj_explosion)
    {
        if (variable_instance_exists(id, "coop_remote_effect") && (current_time - coop_fx_seen) > 1500)
        {
            instance_destroy();
        }
    }
    with (obj_particle_cut)
    {
        if (variable_instance_exists(id, "coop_remote_effect") && (current_time - coop_fx_seen) > 1500)
        {
            instance_destroy();
        }
    }
}
if (coop_play_room() && instance_exists(obj_player))
{
    obj_player.image_blend = (global.coop_role == 2) ? c_white : c_white;
}
