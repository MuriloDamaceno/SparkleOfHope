
if (global.caixa_aberta && global.caixa_texto != "") {

    // Detecta um novo diálogo
    if (global.caixa_texto != ultimo_texto) {
        ultimo_texto = global.caixa_texto;
        letras_visiveis = 0;

        // Para o som anterior
        if (som_dialogo_id != -1) {
            audio_stop_sound(som_dialogo_id);
            som_dialogo_id = -1;
        }
    }

    // Faz as letras aparecerem
    letras_visiveis = min(
        letras_visiveis + velocidade_texto,
        string_length(global.caixa_texto)
    );

    // Espaço revela tudo
    if (keyboard_check_pressed(vk_space)) {
        letras_visiveis = string_length(global.caixa_texto);
    }

    // Enquanto as letras aparecem
    if (letras_visiveis < string_length(global.caixa_texto)) {

        // Começa a tocar o som
        if (som_dialogo_id == -1) {
            som_dialogo_id = audio_play_sound(
                Sound4, 1, true, global.volume_sfx
            );
        }

    } else {

        // Terminou a escrita: para o som
        if (som_dialogo_id != -1) {
            audio_stop_sound(som_dialogo_id);
            som_dialogo_id = -1;
        }
    }

} else {

    // Caixa fechada: para tudo
    letras_visiveis = 0;
    ultimo_texto = "";

    if (som_dialogo_id != -1) {
        audio_stop_sound(som_dialogo_id);
        som_dialogo_id = -1;
    }
}


// Verifica se clicou na caixa de diálogo
if (global.caixa_aberta
    && dialogo_estava_aberto
    && mouse_check_button_pressed(mb_left)) {

    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    var _escala = clamp(floor(_gui_h / 200), 1, 6);

    // Mesma posição usada no Draw GUI
    var _box_w = sprite_width * _escala;
    var _box_h = sprite_height * _escala;

    var _box_x = floor((_gui_w - _box_w) / 2);
    var _box_y = floor(_gui_h - _box_h - 10 * _escala);

    // Posição do mouse na GUI
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    // Só fecha se clicar dentro da caixa
    if (point_in_rectangle(
        _mx, _my,
        _box_x, _box_y,
        _box_x + _box_w,
        _box_y + _box_h
    )) {
        global.caixa_aberta = false;
    }
}

// Evita fechar no mesmo clique que abriu
dialogo_estava_aberto = global.caixa_aberta;
