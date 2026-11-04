
if (global.caixa_aberta && global.caixa_texto != "") {

    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    // Escala inteira para manter os pixels mais nítidos
    var _escala = clamp(floor(_gui_h / 200), 1, 6);

    var _box_w = sprite_width * _escala;
    var _box_h = sprite_height * _escala;

    var _box_x = floor((_gui_w - _box_w) / 2);
    var _box_y = floor(_gui_h - _box_h - 10 * _escala);

    // Desenha a caixa
    draw_sprite_ext(
        sprite_index, 0,
        _box_x, _box_y,
        _escala, _escala,
        0, c_white, 1
    );

    // Configura o texto
    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_black);

    // Mostra apenas as letras liberadas
    var _texto = string_copy(
        global.caixa_texto,
        1,
        floor(letras_visiveis)
    );

    draw_text_ext_transformed(
        _box_x + 12 * _escala,
        _box_y + 11 * _escala,
        _texto,
        12,
        sprite_width - 24,
        _escala, _escala,
        0
    );

    draw_set_color(c_white);
    draw_set_font(-1);
}
