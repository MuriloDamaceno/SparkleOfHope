
/// OBJ_CUTSCENE_TARDE - DRAW GUI

var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_set_alpha(1);
draw_set_color(c_black);


// =====================================
// TRANSICAO DIAGONAL
// =====================================

if (cobertura >= 1) {

    // Tela inteiramente preta
    draw_rectangle(
        0, 0,
        _w, _h,
        false
    );

} else if (cobertura > 0) {

    // A diagonal atravessa toda a tela
    var _topo = -_h + (_w + 2 * _h) * cobertura;
    var _baixo = _topo - _h;

    draw_primitive_begin(pr_trianglefan);

    draw_vertex(0, 0);
    draw_vertex(_topo, 0);
    draw_vertex(_baixo, _h);
    draw_vertex(0, _h);

    draw_primitive_end();
}


// =====================================
// NARRACAO NA TELA PRETA
// =====================================

if (etapa == 1) {

    draw_set_font(fnt_dialogo);
    draw_set_color(c_white);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var _texto = string_copy(
        texto_narracao,
        1,
        floor(letras_narracao)
    );

    draw_text_ext_transformed(
        _w / 2,
        _h / 2,
        _texto,
        14,
        _w * 0.75,
        2, 2,
        0
    );
}


// =====================================
// RESTAURA CONFIGURACOES
// =====================================

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
