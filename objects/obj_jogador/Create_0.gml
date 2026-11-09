
/// OBJ_JOGADOR - CREATE

// =====================================
// CONFIGURACOES INICIAIS
// =====================================

spd = 1.5;

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
    spd = 0.8;

} else if (room == rm_rua) {

    floor_top = 0;
    spd = 0.8;

} else if (room == rua_beco) {

    floor_top = 0;
    spd = 0.8;

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
