if (global.life > 0 && (current_time - coop_request_at) >= 120)
{
    coop_request_at = current_time;
    coop_send(coop_packet("op", "pickup_request", "room", room_get_name(room), "key", coop_server_id));
}
