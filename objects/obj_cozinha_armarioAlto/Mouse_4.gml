if (global.caixa_aberta) {
    global.caixa_aberta = false;
} else {
    var _dist = point_distance(x, y, obj_jogador.x, obj_jogador.y);

    if (_dist <= 250) {
        global.caixa_aberta = true;
        global.caixa_texto = "Esta muito alto eu não alcanço.";
    } else {
        show_debug_message("Preciso chegar mais perto!");
    }
}