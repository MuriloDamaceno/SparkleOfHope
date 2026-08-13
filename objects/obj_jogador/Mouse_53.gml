if (!place_meeting(mouse_x, mouse_y, obj_solido)) {
    target_x = clamp(mouse_x, 8, room_width - 8);
    target_y = clamp(mouse_y, floor_top, room_height - 3);
    has_target = true;
}