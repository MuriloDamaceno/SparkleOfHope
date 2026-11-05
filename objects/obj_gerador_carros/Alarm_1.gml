
/// FAIXA 2 - ESQUERDA PARA DIREITA

var _carro = instance_create_depth(
    -10,
    y_faixa_2,
    50,
    obj_carro
);

// Cor do carro
_carro.sprite_index = sprites_carros[indice_2];

// Direcao e velocidade
_carro.velocidade = vel_faixa_2;

// Espelha o carro para apontar
// para o lado contrario
_carro.image_xscale = -1;

// Ordem de cores inversa
indice_2 = (indice_2 + 2) mod 3;

// Intervalo aleatorio: 4 a 7 segundos
var _tempo = random_range(4, 7);

alarm[1] = max(
    1,
    round(_tempo * game_get_speed(gamespeed_fps))
);
