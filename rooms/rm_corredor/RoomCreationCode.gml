view_enabled = true;
view_visible[0] = true;

view_wview[0] = 300;
view_hview[0] = 200;
view_wport[0] = 1152;
view_hport[0] = 768;

camera_set_view_target(view_camera[0], obj_jogador);
camera_set_view_border(view_camera[0], 100, 200);

window_set_size(room_width, room_height);
surface_resize(application_surface, room_width, room_height);