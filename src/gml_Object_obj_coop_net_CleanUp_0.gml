if (socket >= 0)
{
    network_destroy(socket);
}
if (global.coop_role == 1 && peer >= 0 && peer != socket)
{
    network_destroy(peer);
}
ds_map_destroy(entities);
ds_map_destroy(client_shots);
ds_map_destroy(consumed_shots);
ds_map_destroy(fx_sent);
ds_map_destroy(fx_remote);
ds_map_destroy(solid_registry);
ds_map_destroy(solid_removed);
