if (!global.opcoes_aberta) exit;

// Desenha o retângulo colorido representando o volume atual, por cima da barra vazia
var _largura_preenchida = nivel * comprimento;
draw_set_color(c_white); // troque pela cor que combinar com sua arte
draw_rectangle(barra_x0, barra_y0, barra_x0 + _largura_preenchida, barra_y0 + altura_barra, false);
draw_set_color(c_black); // reseta a cor padrão pro resto do jogo