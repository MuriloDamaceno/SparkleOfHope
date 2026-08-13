if (global.caixa_aberta && global.caixa_texto != "") {
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    // Fator de escala: compara a GUI atual com a altura "de design" da view (200px)
    var _escala = _gui_h / 200;
    _escala = clamp(_escala, 1, 6); // evita ficar gigante ou minúscula demais

    var _box_w = sprite_width * _escala;
    var _box_h = sprite_height * _escala;

    var _box_x = (_gui_w - _box_w) / 2;
    var _box_y = _gui_h - _box_h - (10 * _escala);

    draw_sprite_ext(sprite_index, image_index, _box_x, _box_y, _escala, _escala, 0, c_white, 1);

    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_black);

    draw_text_ext_transformed(
    _box_x + 20 * _escala,
    _box_y + 15 * _escala,
    global.caixa_texto,
    18,
    (sprite_width - 40),
    _escala, _escala,
    0
);

    draw_set_color(c_white);
    draw_set_font(-1);
}