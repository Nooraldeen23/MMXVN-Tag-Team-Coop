var beam_frame = min(11, floor((beam_timer * 12) / 27));
draw_sprite_ext(spr_tag_ultimate_anim, beam_frame, x, y, beam_face, 1, 0, c_white, clamp((27 - beam_timer) / 5, 0, 1));
