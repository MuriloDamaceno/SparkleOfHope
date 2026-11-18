
/// OBJ_ESCOLHA_CONFIANCA - STEP

if (mouse_check_button_pressed(mb_left)) {

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    // OPCAO 1 - ESTENDER A MAO
    if (point_in_rectangle(
        _mx, _my,
        esquerda_x, opcoes_y,
        esquerda_x + opcao_w,
        opcoes_y + opcao_h
    )) {

        global.escolha_confianca = 1;

        instance_destroy();
        exit;
    }

    // OPCAO 2 - FALAR BAIXINHO
    if (point_in_rectangle(
        _mx, _my,
        direita_x, opcoes_y,
        direita_x + opcao_w,
        opcoes_y + opcao_h
    )) {

        global.escolha_confianca = 2;

        instance_destroy();
        exit;
    }
}
