if (coop_client() && (other.object_index == obj_coop_foe || other.object_index == obj_coop_enemy_shot) && !coop_source_can_hit(other))
{
    exit;
}
if (coop_client() && other.villainy == 2 && other.object_index != obj_coop_enemy_shot)
{
    exit;
}
if (other.villainy != 0 && invul_bullet == false && other.passive == false)
{
    event_user(2);
}
