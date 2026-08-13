// --- Câmera segue o jogador, sem mostrar além das bordas do mapa ---
if (view_camera[0] != -1) {
    var _view_w = camera_get_view_width(view_camera[0]);
    var _view_h = camera_get_view_height(view_camera[0]);

    var _cam_x = x - _view_w / 2;
    var _cam_y = y - _view_h / 2;

    if (room_width > _view_w) {
        _cam_x = clamp(_cam_x, 0, room_width - _view_w);
    } else {
        _cam_x = (room_width - _view_w) / 2;
    }

    if (room_height > _view_h) {
        _cam_y = clamp(_cam_y, 0, room_height - _view_h);
    } else {
        _cam_y = (room_height - _view_h) / 2;
    }

    camera_set_view_pos(view_camera[0], _cam_x, _cam_y);
}