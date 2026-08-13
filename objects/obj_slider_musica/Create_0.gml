event_inherited();

// Pega a posição do painel de opções automaticamente
barra_x0 = obj_painel_opcoes.x + 60;   // canto esquerdo da barra de música dentro do painel
barra_y0 = obj_painel_opcoes.y + 45;   // topo da barra de música
comprimento = 100;                     // largura total da barra
altura_barra = 12;                     // altura da barra

nivel = global.volume_musica;

// Posiciona a instância em cima da barra desenhada
x = barra_x0;
y = barra_y0;

// Dá uma hitbox invisível do tamanho da barra, pra detectar clique/arraste
sprite_index = spr_hotspot;
image_alpha = 0;
image_xscale = comprimento / sprite_width;
image_yscale = altura_barra / sprite_height;