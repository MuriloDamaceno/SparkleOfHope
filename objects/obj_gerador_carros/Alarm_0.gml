
/// FAIXA 1 - DIREITA PARA ESQUERDA

var _carro = instance_create_depth(
    room_width + 10,
    y_faixa_1,
    50,
    obj_carro
);

// Cor do carro
_carro.sprite_index = sprites_carros[indice_1];

// Direcao e velocidade
_carro.velocidade = vel_faixa_1;
_carro.image_xscale = 1;

// Proxima cor
indice_1 = (indice_1 + 1) mod 3;

// Intervalo aleatorio: 3 a 6 segundos
var _tempo = random_range(3, 6);

alarm[0] = max(
    1,
    round(_tempo * game_get_speed(gamespeed_fps))
);
