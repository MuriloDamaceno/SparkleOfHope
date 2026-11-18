
/// OBJ_ESCOLHA_CONFIANCA - DRAW GUI

draw_set_color(c_white);
draw_set_alpha(1);

// =====================================
// DESENHA AS TRES CAIXAS
// =====================================

// Caixa principal
draw_sprite_stretched(
    spr_dialogo, 0,
    principal_x, principal_y,
    principal_w, principal_h
);

// Caixa esquerda
draw_sprite_stretched(
    spr_dialogo, 0,
    esquerda_x, opcoes_y,
    opcao_w, opcao_h
);

// Caixa direita
draw_sprite_stretched(
    spr_dialogo, 0,
    direita_x, opcoes_y,
    opcao_w, opcao_h
);

// =====================================
// TEXTOS
// =====================================

draw_set_font(fnt_dialogo);
draw_set_color(c_black);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Escala pequena, igual a escolha anterior
var _escala = max(
    0.5,
    display_get_gui_height() / 550
);

// Pergunta
draw_text_transformed(
    principal_x + principal_w / 2,
    principal_y + principal_h / 2,
    "Como tentar tranquiliza-lo?",
    _escala, _escala, 0
);

// Opcao esquerda
draw_text_transformed(
    esquerda_x + opcao_w / 2,
    opcoes_y + opcao_h / 2,
    "Estender a mao",
    _escala, _escala, 0
);

// Opcao direita
draw_text_transformed(
    direita_x + opcao_w / 2,
    opcoes_y + opcao_h / 2,
    "Falar baixinho",
    _escala, _escala, 0
);

// Restaura as configuracoes
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
