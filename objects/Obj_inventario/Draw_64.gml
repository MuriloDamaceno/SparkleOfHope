var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _escala = (_gh * 0.95) / sprite_get_height(spr);
var _x = (_gw - sprite_get_width(spr) * _escala) / 2;
var _y = (_gh - sprite_get_height(spr) * _escala) / 2;

draw_sprite_ext(spr, 0, _x, _y, _escala, _escala, 0, c_white, 1);