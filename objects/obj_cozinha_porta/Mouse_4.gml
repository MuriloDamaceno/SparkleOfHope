
if (global.caixa_aberta || instance_exists(Obj_inventario)) exit;

// Se não tem o livro, não pode sair
if (!global.tem_livro) {

    global.indo_para_porta = false;
    obj_jogador.has_target = false;

    global.caixa_aberta = true;
    global.caixa_texto = "Não tenho o porque sair.";

    exit;
}

// Distância entre jogador e porta
var _dist = point_distance(
    x, y,
    obj_jogador.x, obj_jogador.y
);

if (_dist <= 200) {

    // Impede a saída imediata
    global.indo_para_porta = false;
    obj_jogador.has_target = false;

    // Começa a despedida
    global.despedida_etapa = 1;
    global.caixa_aberta = true;
    global.caixa_texto = "Mãe, vou levar o livro pra Hope! Tchau!";

} else {

    // Se estiver longe, caminha até a porta
    obj_jogador.target_x = x;
    obj_jogador.target_y = obj_jogador.floor_top;
    obj_jogador.has_target = true;

    global.indo_para_porta = true;
    global.porta_alvo = id;
    global.room_alvo = rm_patio;
}
