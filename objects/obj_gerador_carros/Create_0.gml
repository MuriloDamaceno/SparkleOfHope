
/// GERADOR DE CARROS - CREATE

// Sprites disponiveis
sprites_carros = [
    spr_carro,
    spr_carrocamarelo,
    spr_carroverde
];

// Altura das duas faixas
y_faixa_1 = 140;
y_faixa_2 = 115;

// Velocidade de cada faixa
vel_faixa_1 = -1;
vel_faixa_2 = 0.7;

// Ordem independente das cores
indice_1 = irandom(2);
indice_2 = (indice_1 + 1) mod 3;

// Primeira faixa comeca em 1 segundo
alarm[0] = game_get_speed(gamespeed_fps);

// Segunda faixa comeca em 3 segundos
alarm[1] = game_get_speed(gamespeed_fps) * 3;
