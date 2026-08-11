var _dist = point_distance(x, y, obj_jogador.x, obj_jogador.y);

if (_dist <= 60) {
    show_debug_message("Clicou na cama!"); // troca a mensagem pra cada objeto
} else {
    show_debug_message("Preciso chegar mais perto!");
}