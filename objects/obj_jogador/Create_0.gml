
/// OBJ_JOGADOR - CREATE

// =====================================
// CONFIGURACOES INICIAIS
// =====================================

spd = 5;

image_speed = 0;
image_index = 0;

// Guarda a escala original da personagem
// para usar nas animacoes e cutscenes
escala = abs(image_xscale);

// Corrige a proporcao da personagem no patio
if (room == rm_patio) {
    image_yscale = 0.6;
}



// =====================================
// MOVIMENTACAO
// =====================================

target_x = x;
target_y = y;
has_target = false;

stuck_timer = 0;

last_x = x;
last_y = y;


// =====================================
// SOM DOS PASSOS
// =====================================

passo_timer = 0;
passo_intervalo = 20;
passo_som_id = -1;


// =====================================
// LIMITES E VELOCIDADE DAS SALAS
// =====================================

if (room == rm_patio) {

    floor_top = 0;
    spd = 5;

} else if (room == rm_rua) {

    floor_top = 0;
    spd = 5;

} else if (room == rua_beco) {

    floor_top = 0;
    spd = 5;

} else {

    floor_top = 161;
}


// =====================================
// POSICAO AO ENTRAR POR UMA PORTA
// =====================================

// Verifica se alguma porta definiu
// onde a personagem deve aparecer
if (
    variable_global_exists("spawn_room") &&
    global.spawn_room == room
) {

    // Posiciona na porta correta
    x = global.spawn_x;
    y = global.spawn_y;

    // Atualiza o destino do movimento
    target_x = x;
    target_y = y;

    has_target = false;

    last_x = x;
    last_y = y;

    // Limpa a posicao salva
    global.spawn_room = noone;
}


// =====================================
// ESCONDER CELESTE NO TIME SKIP
// =====================================

if (
    room == rua_beco &&
    variable_global_exists("cutscene_bloqueio") &&
    global.cutscene_bloqueio &&
    instance_exists(obj_cutscene_tarde)
) {
    visible = false;
}
if (room == rm_beco_interno) {
    floor_top = 119;
}

// Verifica a posição onde a Celeste quer pisar.
pode_pisar = function(_x, _y) {
    if (place_meeting(_x, _y, obj_solido)) return false;
	if (room == rua_beco) {
    var _total = instance_number(obj_andante);

    for (var i = 0; i < _total; i++) {
        var _andante = instance_find(obj_andante, i);

        if (scr_pes_se_encostam(id, _x - x, _y - y, _andante)) {
            return false;
        }
    }
}
    if (room != rm_beco_interno) return true;

    // Área ocupada pelos pés da Celeste.
    var _esq = _x - 6;
    var _dir = _x + 6;
    var _cima = _y - 3;
    var _baixo = _y;

    // Parede de tijolos ao fundo.
    if (_cima < 116) return false;

    // Parede vermelha à esquerda. A borda é inclinada.
    var _borda_parede = lerp(49, 18, clamp(_y / 256, 0, 1));
    if (_esq <= _borda_parede) return false;

    // Lixeira verde comprida, encostada na parede esquerda.
    var _borda_lixeira = lerp(95, 83, clamp((_y - 96) / 119, 0, 1));
    if (_cima <= 215 && _baixo >= 96 && _esq <= _borda_lixeira) {
        return false;
    }

    // Lixeira cinza junto à parede do fundo.
    if (rectangle_in_rectangle(
        _esq, _cima, _dir, _baixo, 154, 78, 197, 127
    )) return false;

    // Lixeira redonda no canto inferior esquerdo.
    if (rectangle_in_rectangle(
        _esq, _cima, _dir, _baixo, 20, 220, 65, 255
    )) return false;

    // Usa a base do bichinho para a Celeste poder passar atrás dele.
    var _animal = instance_find(obj_bichinho, 0);
    if (_animal != noone) {
        if (rectangle_in_rectangle(
            _esq, _cima, _dir, _baixo,
            _animal.bbox_left,  _animal.bbox_bottom - 6,
            _animal.bbox_right, _animal.bbox_bottom
        )) return false;
    }

    return true;
};
escala_da_room = abs(image_xscale);

atualizar_perspectiva = function() {
    var _fundo = 0;
    var _frente = room_height;
    var _menor = escala_da_room;
    var _maior = escala_da_room;

    switch (room) {
        case rm_patio:
            _fundo = 95;
            _frente = 185;
            _menor = 0.48;
            _maior = 0.68;
            break;

        case rm_rua:
            _fundo = 75;
            _frente = 180;
            _menor = 0.44;
            _maior = 0.68;
            break;

        case rua_beco:
            _fundo = 102;
            _frente = 125;
            _menor = 0.43;
            _maior = 0.51;
            break;

        case forabiblioteca:
            _fundo = 275;
            _frente = 395;
            _menor = 0.68;
            _maior = 1.35;
            break;

        case biblioteca:
            _fundo = 250;
            _frente = 390;
            _menor = 0.95;
            _maior = 1.65;
            break;
    }

    var _t = clamp((y - _fundo) / max(1, _frente - _fundo), 0, 1);
    var _lado = (image_xscale < 0) ? -1 : 1;

    escala = lerp(_menor, _maior, _t);
    image_xscale = _lado * escala;
    image_yscale = escala;

    // Em mapas maiores ela percorre mais pixels por segundo.
    // No fundo da cena, o passo diminui junto com o sprite.
    var _vel_mapa = clamp(room_width * 0.19, 57, 145);
    var _fator = escala / max(0.01, _maior);
    spd = (_vel_mapa * _fator) / game_get_speed(gamespeed_fps);
};

atualizar_perspectiva();