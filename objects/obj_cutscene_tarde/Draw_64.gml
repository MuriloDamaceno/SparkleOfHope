
/// OBJ_CUTSCENE_TARDE - DRAW GUI

var _w = display_get_gui_width();
var _h = display_get_gui_height();

// Tela preta durante a narracao e troca de room
if (etapa == 1 || etapa == 2 || etapa == 9) {

    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_rectangle(0, 0, _w, _h, false);

}

// Usa os quadros do spritesheet na transicao
else if (
    cobertura > 0 &&
    transicao_sprite != -1
) {

    var _total = sprite_get_number(transicao_sprite);
    var _quadro = clamp(
        floor(cobertura * (_total - 1)),
        0,
        _total - 1
    );

    draw_set_color(c_white);
    draw_set_alpha(1);

    draw_sprite_stretched(
        transicao_sprite,
        _quadro,
        0, 0,
        _w, _h
    );
}

// Texto durante a tela preta
if (etapa == 1) {

    draw_set_font(fnt_dialogo);
    draw_set_color(c_white);
    draw_set_alpha(1);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var _texto = string_copy(
        texto_narracao,
        1,
        floor(letras_narracao)
    );

    draw_text(
        _w / 2,
        _h / 2,
        _texto
    );
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
