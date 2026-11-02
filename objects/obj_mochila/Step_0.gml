// tamanho proporcional à altura da GUI (equivale ao 0.05 que você usava numa room de 200px)
var _s = (display_get_gui_height() * 0.184) / sprite_get_height(spr);

// área clicável: usa a parte visível da sprite
var _x1 = sprite_get_bbox_left(spr) * _s;
var _x2 = (sprite_get_bbox_right(spr) + 1) * _s;
var _y1 = sprite_get_bbox_top(spr) * _s;
var _y2 = (sprite_get_bbox_bottom(spr) + 1) * _s;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left)
    && _mx >= _x1 && _mx <= _x2 && _my >= _y1 && _my <= _y2) {

    if (instance_exists(Obj_inventario)) {
        instance_destroy(Obj_inventario);
    } else {
        instance_create_depth(0, 0, -1000, Obj_inventario);
    }
}