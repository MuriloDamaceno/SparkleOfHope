
// Calcula a distância entre a porta e o jogador
if (!instance_exists(obj_jogador)) {
    exit;
}

var _dist = point_distance(
    x, y,
    obj_jogador.x,
    obj_jogador.y
);

// Se o jogador estiver perto da porta
if (_dist <= 200) {

    global.indo_para_porta = false;

    // Inicia a animação antes de entrar no pátio
    transicao_iniciar(rm_patio);

} else {

    // Se estiver longe, caminha até a porta
    obj_jogador.target_x = x;
    obj_jogador.target_y = obj_jogador.floor_top;
    obj_jogador.has_target = true;

    global.indo_para_porta = true;
    global.porta_alvo = id;
    global.room_alvo = rm_patio;
}
