
var _s = (display_get_gui_height() * 0.184) / sprite_get_height(spr);

// Área clicável da mochila
var _x1 = sprite_get_bbox_left(spr) * _s;
var _x2 = (sprite_get_bbox_right(spr) + 1) * _s;
var _y1 = sprite_get_bbox_top(spr) * _s;
var _y2 = (sprite_get_bbox_bottom(spr) + 1) * _s;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// Verifica clique na mochila
var _clicou_mochila =
    mouse_check_button_pressed(mb_left)
    && _mx >= _x1 && _mx <= _x2
    && _my >= _y1 && _my <= _y2;

// Verifica tecla Tab
var _apertou_tab = keyboard_check_pressed(vk_tab);

// Abre ou fecha o inventário
if (_clicou_mochila || _apertou_tab) {

    if (instance_exists(Obj_inventario)) {
        instance_destroy(Obj_inventario);
    } else {
        instance_create_depth(
            0, 0, -1000, Obj_inventario
        );
    }
}
