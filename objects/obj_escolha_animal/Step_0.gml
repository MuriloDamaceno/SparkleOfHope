
/// OBJ_ESCOLHA_ANIMAL - STEP

if (mouse_check_button_pressed(mb_left)) {

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    // =====================================
    // ESCOLHEU AFASTAR O GATO
    // =====================================

    if (point_in_rectangle(
        _mx, _my,
        gato_x, opcoes_y,
        gato_x + opcao_w,
        opcoes_y + opcao_h
    )) {

        global.animal_escolhido = 1;

        show_debug_message(
            "ESCOLHA: AFASTAR O GATO"
        );

        instance_destroy();
        exit;
    }

    // =====================================
    // ESCOLHEU AFASTAR O CACHORRO
    // =====================================

    if (point_in_rectangle(
        _mx, _my,
        cachorro_x, opcoes_y,
        cachorro_x + opcao_w,
        opcoes_y + opcao_h
    )) {

        global.animal_escolhido = 2;

        show_debug_message(
            "ESCOLHA: AFASTAR O CACHORRO"
        );

        instance_destroy();
        exit;
    }
}
