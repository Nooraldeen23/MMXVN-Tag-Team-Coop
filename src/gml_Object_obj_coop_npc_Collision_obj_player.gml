if (global.life > 0 && !coop_requested && !rescued && !openning)
{
    coop_requested = true;
    coop_send(coop_packet("op", "rescue_request", "room", room_get_name(room), "key", coop_server_id));
}
