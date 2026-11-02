// limita o dt para o tempo de carregamento da room não "pular" a animação
var _dt = min(delta_time / 1000000, 0.05);

if (estado == 0) {
    progresso += _dt / dur_cobrir;
    if (progresso >= 1) {
        progresso = 1;
        estado = 1;
        room_goto(room_destino);   // tela 100% preta aqui
    }
} else if (estado == 2) {
    progresso += _dt / dur_revelar;
    if (progresso >= 1) {
        global.em_transicao = false;
        instance_destroy();
    }
}