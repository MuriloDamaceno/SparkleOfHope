event_inherited();

barra_x0 = obj_painel_opcoes.x + 60;   // canto esquerdo da barra de efeitos
barra_y0 = obj_painel_opcoes.y + 70;   // topo da barra de efeitos (mais embaixo que a de música)
comprimento = 100;
altura_barra = 12;

nivel = global.volume_sfx;

x = barra_x0;
y = barra_y0;

sprite_index = spr_hotspot;
image_alpha = 0;
image_xscale = comprimento / sprite_width;
image_yscale = altura_barra / sprite_height;