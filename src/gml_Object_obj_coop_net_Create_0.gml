connect_inflight = true;
connect_retry_at = 120;
connect_started_tick = 0;
connect_attempts = 1;
persistent = true;
socket = -1;
peer = -1;
connected = false;
tick = 0;
rx_tick = 0;
tx_count = 0;
rx_count = 0;
status = "Starting";
profile_sent = false;
profile_applied = false;
profile_dirty = true;
remote = -4;
pending_room = "";
last_room = "";
world = [];
world_tick = 0;
entities = ds_map_create();
consumed_shots = ds_map_create();
shot_epoch = 0;
client_shots = ds_map_create();
session_id = string(current_time) + "-" + string(irandom(999999));
if (global.coop_role == 1)
{
    socket = network_create_server(0, global.coop_port, 2);
    status = (socket >= 0) ? "Waiting for partner" : "Port unavailable";
}
else if (global.coop_role == 2)
{
    socket = network_create_socket(network_socket_tcp);
    network_connect_async(socket, global.coop_host, global.coop_port);
    status = "Connecting";
}
coop_log("START role=" + string(global.coop_role) + " socket=" + string(socket));
remote_room = "";
room_epoch = 0;
remote_epoch = -1;
pending_restart = false;
progress_signature = "";
weapon_signature = "";
downed = 0;
fx_sent = ds_map_create();
fx_remote = ds_map_create();
if (global.coop_role == 0)
{
    status = "Choose Host or Join";
}
host_character = "X";
guest_character = "Zero";
reward_total = 0;
reward_seen = 0;
personal_ready = false;
personal_signature = "";
lives_ready = false;
spectating = false;
party_end_delay = 0;
solid_registry = ds_map_create();
solid_removed = ds_map_create();
solid_revision = 0;
solid_seen_revision = -1;
mobility_epoch = 0;
if (global.coop_role == 2)
{
    coop_log("CONNECT_TARGET " + global.coop_host + ":" + string(global.coop_port));
}
