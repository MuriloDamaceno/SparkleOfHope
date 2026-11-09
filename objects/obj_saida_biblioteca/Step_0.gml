
/// ENTRADA AUTOMATICA DA BIBLIOTECA

// Verifica se a protagonista existe
if (!instance_exists(obj_jogador)) {
    exit;
}

// Calcula a distancia ate a entrada
var _dist = point_distance(
    x, y,
    obj_jogador.x,
    obj_jogador.y
);

// Quando a protagonista se aproxima
if (_dist <= 20) {

    obj_jogador.has_target = false;
    global.indo_para_porta = false;

    // Entra automaticamente no novo cenario
    room_goto(forabiblioteca);
}
