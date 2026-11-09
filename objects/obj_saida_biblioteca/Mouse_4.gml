
/// SAIDA DO BECO PARA FORA DA BIBLIOTECA

// Nao funciona durante dialogos ou inventario
if (global.caixa_aberta || instance_exists(Obj_inventario)) {
    exit;
}

// Confere se a protagonista existe
if (!instance_exists(obj_jogador)) {
    exit;
}

// Distancia ate a entrada
var _dist = point_distance(
    obj_jogador.x,
    obj_jogador.y,
    x,
    y
);

// So entra quando estiver perto
if (_dist <= 55) {

    obj_jogador.has_target = false;
    global.indo_para_porta = false;

    // Vai para fora da biblioteca
    room_goto(forabiblioteca);

} else {

    show_debug_message(
        "Preciso chegar mais perto da biblioteca."
    );
}
