var edge = (beam_face < 0) ? 64 : 384;
var distance_to_wall = abs(edge - x);
var sx = 0.55;
var sy = beam_big ? 0.6 : 0.38;
var source_left = max(0, 390 - (distance_to_wall / sx));
var source_width = 398 - source_left;
var grow = clamp(beam_timer / 14, 0, 1);
var frame = floor(beam_timer / 2) % 8;
draw_sprite_part_ext(spr_tag_satan_laser_full, frame, source_left, 0, source_width, 208, x + (beam_face * (390 - source_left) * sx), y - (104 * sy * grow), -beam_face * sx, sy * grow, c_white, 1);
