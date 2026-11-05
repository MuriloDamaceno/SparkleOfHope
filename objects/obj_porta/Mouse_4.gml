var _dist = point_distance(x, y, obj_jogador.x, obj_jogador.y);

if (_dist <= 120) {
    global.indo_para_porta = false;   // cancela qualquer "ida até outra porta" pendente
    room_goto(rm_corredor);
} else {
    obj_jogador.target_x = x;
    obj_jogador.target_y = obj_jogador.floor_top;
    obj_jogador.has_target = true;
    global.indo_para_porta = true;
    global.porta_alvo = id;
    global.room_alvo = rm_corredor;
}