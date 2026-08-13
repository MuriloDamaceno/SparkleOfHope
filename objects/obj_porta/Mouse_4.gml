var _dist = point_distance(x, y, obj_jogador.x, obj_jogador.y);

if (_dist <= 120) {
    // já está perto o suficiente: troca de sala na hora
    room_goto(rm_NOME_DA_SALA); // <-- troque pelo nome real da sala
} else {
    // manda o personagem andar até a porta
    obj_jogador.target_x = x;
    obj_jogador.target_y = obj_jogador.floor_top;
    obj_jogador.has_target = true;
    global.indo_para_porta = true;
}