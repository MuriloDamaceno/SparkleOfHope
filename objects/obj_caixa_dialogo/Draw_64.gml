
if (global.caixa_aberta && global.caixa_texto != "") {

    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

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

    // Configura a fonte
    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
    draw_set_color(c_black);

    // Texto com animação
    var _texto = string_copy(
        global.caixa_texto,
        1,
        floor(letras_visiveis)
    );

    // Margens internas
    var _margem = 16;
    var _largura = sprite_width - (_margem * 2);

    // Centraliza verticalmente considerando
    // a altura da frase completa
    var _altura = string_height_ext(
        global.caixa_texto, 12, _largura
    );

    var _texto_x = _box_x + _margem * _escala;
    var _texto_y = _box_y
        + (sprite_height - _altura) / 2 * _escala;

    draw_text_ext_transformed(
        _texto_x,
        _texto_y,
        _texto,
        12,
        _largura,
        _escala, _escala,
        0
    );

    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_font(-1);
}
