var _celeste = instance_find(obj_jogador, 0);
var _dx = -velocidade;
var _livre = true;

if (_celeste != noone) {
    _livre = !scr_pes_se_encostam(id, _dx, 0, _celeste);
}

if (_livre) {
    x += _dx;
    image_speed = 0.12;
} else {
    image_speed = 0;
    image_index = 0;
}

if (bbox_right < 0) {
    x = room_width + sprite_width;
}