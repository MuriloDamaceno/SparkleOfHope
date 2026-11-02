// Controle global das transições
global.em_transicao = false;

spd = 1.5;
image_speed = 0;
image_index = 0;

// guarda a escala que você colocou na room (0.5 no pátio, 0.7 na rua etc.)
escala = abs(image_xscale);

target_x = x;
target_y = y;
has_target = false;

stuck_timer = 0;
last_x = x;
last_y = y;

// controle do som de passo
passo_timer = 0;
passo_intervalo = 20;
passo_som_id = -1;

// limite do chão e velocidade por room
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

// ponto de nascimento definido por uma porta (se houver)
if (variable_global_exists("spawn_room") && global.spawn_room == room) {
    x = global.spawn_x;
    y = global.spawn_y;
    target_x = x;
    target_y = y;
    global.spawn_room = noone;   // usa uma vez só
}