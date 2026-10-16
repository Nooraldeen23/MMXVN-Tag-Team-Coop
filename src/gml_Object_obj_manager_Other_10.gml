if (coop_client())
{
    exit;
}
save_data = ds_map_create();
ds_map_set(save_data, "save_nightmare_souls", global.nightmare_souls);
var save_rescue_list = ds_list_create();
ds_list_copy(save_rescue_list, global.rescue_list);
ds_map_add_list(save_data, "save_rescue_list", save_rescue_list);
var save_pickup_list = ds_list_create();
ds_list_copy(save_pickup_list, global.pickup_list);
ds_map_add_list(save_data, "save_pickup_list", save_pickup_list);
var save_level_list = ds_list_create();
ds_list_copy(save_level_list, global.level_list);
ds_map_add_list(save_data, "save_level_list", save_level_list);
var save_nightmare_progress = ds_list_create();
ds_list_copy(save_nightmare_progress, global.nightmare_progress);
ds_map_add_list(save_data, "save_nightmare_progress", save_nightmare_progress);
var save_datalog_list = ds_list_create();
ds_list_copy(save_datalog_list, global.datalog_list);
ds_map_add_list(save_data, "save_datalog_list", save_datalog_list);
var save_weapon = ds_list_create();
ds_list_copy(save_weapon, global.weapon_list);
ds_map_add_list(save_data, "save_weapon", save_weapon);
var save_weapon_disable = ds_list_create();
ds_list_copy(save_weapon_disable, global.weapon_disable_list);
ds_map_add_list(save_data, "save_weapon_disable", save_weapon_disable);
ds_map_set(save_data, "save_hearttank", global.hearttank);
ds_map_set(save_data, "save_subtank_1", global.subtank_1);
ds_map_set(save_data, "save_subtank_2", global.subtank_2);
ds_map_set(save_data, "save_weapontank", global.weapontank);
ds_map_set(save_data, "save_powertank", global.powertank);
ds_map_set(save_data, "save_blade_head_get", global.blade_head_get);
ds_map_set(save_data, "save_blade_chest_get", global.blade_chest_get);
ds_map_set(save_data, "save_blade_arm_get", global.blade_arm_get);
ds_map_set(save_data, "save_blade_leg_get", global.blade_leg_get);
ds_map_set(save_data, "save_shadow_head_get", global.shadow_head_get);
ds_map_set(save_data, "save_shadow_chest_get", global.shadow_chest_get);
ds_map_set(save_data, "save_shadow_arm_get", global.shadow_arm_get);
ds_map_set(save_data, "save_shadow_leg_get", global.shadow_leg_get);
ds_map_set(save_data, "save_x_armour_head", global.x_armour_head);
ds_map_set(save_data, "save_x_armour_chest", global.x_armour_chest);
ds_map_set(save_data, "save_x_armour_arm", global.x_armour_arm);
ds_map_set(save_data, "save_x_armour_leg", global.x_armour_leg);
ds_map_set(save_data, "save_zero_armour_black", global.zero_armour_black);
ds_map_set(save_data, "save_black_armour_get", global.black_armour_get);
var save_parts_equipped = ds_list_create();
ds_list_copy(save_parts_equipped, global.parts_equipped);
ds_map_add_list(save_data, "save_parts_equipped", save_parts_equipped);
var save_parts_owned = ds_list_create();
ds_list_copy(save_parts_owned, global.parts_owned);
ds_map_add_list(save_data, "save_parts_owned", save_parts_owned);
var save_parts_store = ds_list_create();
ds_list_copy(save_parts_store, global.parts_store);
ds_map_add_list(save_data, "save_parts_store", save_parts_store);
var save_parts_list = ds_list_create();
ds_list_copy(save_parts_list, global.parts_list);
ds_map_add_list(save_data, "save_parts_list", save_parts_list);
ds_map_set(save_data, "save_playable_character", global.playable_character.name);
ds_map_set(save_data, "save_zero_unlock", global.zero_unlock);
ds_map_set(save_data, "save_playtime", global.playtime);
ds_map_set(save_data, "save_game_completion", global.game_completion);
ds_map_set(save_data, "save_ng_cycle", global.ng_cycle);
ds_map_set(save_data, "save_ng_cycle_max", global.ng_cycle_max);
var save_result_store = ds_list_create();
ds_list_copy(save_result_store, global.result_store);
ds_map_add_list(save_data, "save_result_store", save_result_store);
var save_event = ds_list_create();
for (var i = 0; i < global.event_list_size; i++)
{
    ds_list_add(save_event, global.event[i]);
}
ds_map_add_list(save_data, "save_event", save_event);
ds_map_set(save_data, "save_tag_secret_completed", global.tag_secret_completed);
ds_map_set(save_data, "save_tag_health_enabled", global.tag_health_enabled);
ds_map_set(save_data, "save_tag_energy_enabled", global.tag_energy_enabled);
ds_map_set(save_data, "save_tag_secret_unlock", global.tag_secret_unlock);
ds_map_set(save_data, "save_tag_colonel_soul_claimed", global.tag_colonel_soul_claimed);
ds_map_set(save_data, "save_tag_deferred_blade", global.tag_deferred_blade);
ds_map_set(save_data, "save_tag_deferred_buster", global.tag_deferred_buster);
json_export_string = json_encode(save_data);
export_json("save_" + string(save_slot) + ".txt", save_data);
ds_map_destroy(save_data);
if (instance_exists(obj_coop_net))
{
    obj_coop_net.profile_dirty = true;
}
