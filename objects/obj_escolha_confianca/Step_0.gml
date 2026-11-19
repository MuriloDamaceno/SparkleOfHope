if (!mouse_check_button_pressed(mb_left)) exit;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _escolha = 0;

if (point_in_rectangle(
    _mx, _my,
    esquerda_x, opcoes_y,
    esquerda_x + opcao_w, opcoes_y + opcao_h
)) {
    _escolha = 1;
}
else if (point_in_rectangle(
    _mx, _my,
    direita_x, opcoes_y,
    direita_x + opcao_w, opcoes_y + opcao_h
)) {
    _escolha = 2;
}

if (_escolha == 0) exit;

if (modo_destino) {
    global.destino_bichinhos = _escolha;
} else {
    global.escolha_confianca = _escolha;
}

instance_destroy();