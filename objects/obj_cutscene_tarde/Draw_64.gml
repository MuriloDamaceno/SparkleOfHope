
/// OBJ_CUTSCENE_TARDE - DRAW GUI

var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_set_alpha(1);
draw_set_color(c_white);


// =====================================
// TRANSICAO COM SPR_TRANSICAO
// =====================================

if (etapa == 1 || etapa == 2 || etapa == 9) {

    // Tela completamente preta
    draw_set_color(c_black);

    draw_rectangle(
        0, 0,
        _w, _h,
        false
    );

} else if (cobertura > 0) {

    if (cobertura >= 1) {

        draw_set_color(c_black);
        draw_rectangle(0, 0, _w, _h, false);

    } else {

        var _total = sprite_get_number(spr_transicao);

        var _quadro = clamp(
            floor(cobertura * (_total - 1)),
            0,
            _total - 1
        );

        draw_set_color(c_white);

        draw_sprite_stretched(
            spr_transicao,
            _quadro,
            0, 0,
            _w, _h
        );
    }
}


// =====================================
// TEXTO DO TIME SKIP
// =====================================

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

    draw_text_ext(
        _w * 0.5,
        _h * 0.5,
        _texto,
        12,
        _w * 0.7
    );

    // Indicacao para avancar
    if (
        letras_narracao >=
        string_length(texto_narracao) &&
        tempo_narracao >= 30
    ) {

        draw_text(
            _w * 0.5,
            _h * 0.75,
            "Clique para continuar"
        );
    }
}


// =====================================
// RESTAURA CONFIGURACOES
// =====================================

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
