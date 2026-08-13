if (global.caixa_aberta) {
    global.caixa_aberta = false;
} else {
    var _dist = point_distance(x, y, obj_jogador.x, obj_jogador.y);

    if (_dist <= 120) {
        global.caixa_aberta = true;
        global.caixa_texto = "Não sei porque a pia é tãooo alta...";
    } else {
        show_debug_message("Preciso chegar mais perto!");
    }
}