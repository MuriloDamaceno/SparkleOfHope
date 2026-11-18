
/// OBJ_ESCOLHA_ANIMAL - DRAW GUI

draw_set_color(c_white);
draw_set_alpha(1);

// =====================================
// CAIXA PRINCIPAL - PERGUNTA
// =====================================

draw_sprite_stretched(
    spr_dialogo,
    0,
    principal_x,
    principal_y,
    principal_w,
    principal_h
);

// =====================================
// CAIXA DA ESQUERDA - GATO
// =====================================

draw_sprite_stretched(
    spr_dialogo,
    0,
    gato_x,
    opcoes_y,
    opcao_w,
    opcao_h
);

// =====================================
// CAIXA DA DIREITA - CACHORRO
// =====================================

draw_sprite_stretched(
    spr_dialogo,
    0,
    cachorro_x,
    opcoes_y,
    opcao_w,
    opcao_h
);

// =====================================
// TEXTOS CENTRALIZADOS
// =====================================

draw_set_font(fnt_dialogo);
draw_set_color(c_black);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _escala = max(
    1,
    floor(display_get_gui_height() / 256)
);

// Pergunta
draw_text_transformed(
    principal_x + principal_w / 2,
    principal_y + principal_h / 2,
    "Qual deles devo afastar?",
    _escala,
    _escala,
    0
);

// Opcao gato
draw_text_transformed(
    gato_x + opcao_w / 2,
    opcoes_y + opcao_h / 2,
    "Afastar o gato",
    _escala,
    _escala,
    0
);

// Opcao cachorro
draw_text_transformed(
    cachorro_x + opcao_w / 2,
    opcoes_y + opcao_h / 2,
    "Afastar o cachorro",
    _escala,
    _escala,
    0
);

// Restaura as configuracoes
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
