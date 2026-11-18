
/// OBJ_ESCOLHA_APROXIMACAO - DRAW GUI

draw_set_color(c_white);
draw_set_alpha(1);


// Caixa principal
principal_w = _w * 0.48;
principal_h = _h * 0.10;

principal_x = (_w - principal_w) / 2;
principal_y = _h * 0.50;

// Caixas menores
opcao_w = _w * 0.23;
opcao_h = _h * 0.085;

// Centraliza as duas opcoes
esquerda_x = _w * 0.26;
direita_x = _w * 0.51;

opcoes_y = _h * 0.62;


// Textos
draw_set_font(fnt_dialogo);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _escala = max(
    1,
    floor(display_get_gui_height() / 256)
);

// Pergunta principal
draw_text_transformed(
    principal_x + principal_w / 2,
    principal_y + principal_h / 2,
    "O bichinho parece assustado. O que fazer?",
    _escala, _escala, 0
);

// Primeira opcao
draw_text_transformed(
    esquerda_x + opcao_w / 2,
    opcoes_y + opcao_h / 2,
    "Aproximar-se devagar",
    _escala, _escala, 0
);

// Segunda opcao
draw_text_transformed(
    direita_x + opcao_w / 2,
    opcoes_y + opcao_h / 2,
    "Ficar onde esta",
    _escala, _escala, 0
);

// Restaura configuracoes
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
