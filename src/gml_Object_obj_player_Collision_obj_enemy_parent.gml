if (coop_client() && (other.object_index == obj_coop_foe || other.object_index == obj_coop_enemy_shot) && !coop_source_can_hit(other))
{
    exit;
}
if (coop_client() && other.object_index == obj_coop_foe && other.collide_vertical && yspeed >= 0 && bbox_bottom <= (other.bbox_top + 4))
{
    exit;
}
if (coop_client() && other.object_index != obj_coop_foe)
{
    exit;
}
if (other.life > 0 && other.image_alpha > 0 && invul_contact == false)
{
    event_user(2);
}
