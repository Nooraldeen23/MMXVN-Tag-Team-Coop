if (ds_map_find_value(async_load, "type") == 2 && global.coop_role == 2 && connected && (ds_map_find_value(async_load, "id") == socket || ds_map_find_value(async_load, "socket") == peer))
{
    coop_connection_lost();
    exit;
}
if (global.coop_role == 0)
{
    exit;
}
if (global.coop_role == 0)
{
    exit;
}
var kind = ds_map_find_value(async_load, "type");
if (kind == 1 && global.coop_role == 1)
{
    if (peer == -1)
    {
        peer = ds_map_find_value(async_load, "socket");
        connected = true;
        rx_tick = tick;
        profile_sent = false;
        profile_dirty = true;
        status = "Partner connected";
        coop_send(coop_packet("op", "welcome", "version", 1, "session", session_id, "character", global.coop_character));
        coop_log("CONNECTED server peer=" + string(peer));
    }
    else
    {
        network_destroy(ds_map_find_value(async_load, "socket"));
    }
}
if (kind == 4 && global.coop_role == 2)
{
    if (ds_map_exists(async_load, "id") && ds_map_find_value(async_load, "id") != socket)
    {
        exit;
    }
    connect_inflight = false;
    if (ds_map_find_value(async_load, "succeeded"))
    {
        peer = socket;
        connected = true;
        rx_tick = tick;
        status = "Connected to host";
        coop_send(coop_packet("op", "hello", "version", 1, "character", global.coop_character));
        coop_log("CONNECTED client");
    }
    else
    {
        status = "Waiting for host - retrying";
        connect_retry_at = tick + 120;
        coop_log("CONNECT_FAILED " + global.coop_host + ":" + string(global.coop_port));
    }
}
if (kind == 2)
{
    if (global.coop_role == 1 && ds_map_find_value(async_load, "socket") == peer)
    {
        connected = false;
        peer = -1;
        status = "Zero disconnected";
        if (instance_exists(remote))
        {
            remote.visible = false;
        }
        coop_partner_left();
    }
}
if (kind == 3)
{
    var packet_buffer = ds_map_find_value(async_load, "buffer");
    var size = ds_map_find_value(async_load, "size");
    if (size < 2 || size > 1048576)
    {
        exit;
    }
    buffer_seek(packet_buffer, buffer_seek_start, 0);
    var text = buffer_read(packet_buffer, buffer_string);
    try
    {
        var packet = json_parse(text);
        if (is_struct(packet) && variable_struct_exists(packet, "op"))
        {
            rx_count++;
            rx_tick = tick;
            coop_receive(packet);
        }
    }
    catch (err)
    {
        coop_log("BAD_PACKET " + string(err));
    }
}
