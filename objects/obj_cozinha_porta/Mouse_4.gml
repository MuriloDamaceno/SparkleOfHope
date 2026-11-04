
if (global.caixa_aberta) exit;

// Verifica se a personagem tem o livro
if (!global.tem_livro) {

    // Cancela qualquer movimento para a porta
    global.indo_para_porta = false;
    obj_jogador.has_target = false;

    // Mostra o diálogo
    global.caixa_aberta = true;
    global.caixa_texto = "Não tenho por que sair.";

    exit;
}

// Se tem o livro, permite sair
var _dist = point_distance(
    x, y,
    obj_jogador.x, obj_jogador.y
);

if (_dist <= 200) {

    room_goto(rm_patio);

} else {

    obj_jogador.target_x = x;
    obj_jogador.target_y = obj_jogador.floor_top;
    obj_jogador.has_target = true;

    global.indo_para_porta = true;
    global.porta_alvo = id;
    global.room_alvo = rm_patio;
}
