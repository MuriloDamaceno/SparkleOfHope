if (global.caixa_aberta) {
    draw_self();

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_black);
    draw_text_ext(x + 20, y + 15, global.caixa_texto, 20, sprite_width - 40);
    draw_set_color(c_white);
}