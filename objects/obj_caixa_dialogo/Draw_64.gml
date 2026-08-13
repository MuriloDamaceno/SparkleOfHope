if (global.caixa_aberta && global.caixa_texto != "") {
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    var _box_x = (_gui_w - sprite_width) / 2;
    var _box_y = _gui_h - sprite_height - 10;

    draw_sprite(sprite_index, image_index, _box_x, _box_y);

    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_black);
    draw_text_ext(_box_x + 20, _box_y + 15, global.caixa_texto, 20, sprite_width - 40);
    draw_set_color(c_white);
    draw_set_font(-1);
}