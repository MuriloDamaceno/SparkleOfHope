
/// FAIXA 2 - ESQUERDA PARA DIREITA

var _carro = instance_create_depth(
    0,
    y_faixa_2,
    50,
    obj_carro
);

// Escolhe a cor
_carro.sprite_index = sprites_carros[indice_2];

// Anda da esquerda para a direita
_carro.velocidade = 0.7;

_carro.image_xscale = -1;
_carro.image_yscale = 1;

// Comeca totalmente fora da tela
_carro.x = 0;

// Ordem inversa das cores
indice_2 = (indice_2 + 2) mod 3;

// Intervalo aleatorio de 4 a 7 segundos
var _tempo = random_range(4, 7);

alarm[1] = max(
    1,
    round(_tempo * game_get_speed(gamespeed_fps))
);
