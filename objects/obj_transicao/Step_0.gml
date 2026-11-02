
var _dt = min(delta_time / 1000000, 0.05);

switch (estado) {

    case 0:
        // Cobre a tela
        progresso = min(
            1,
            progresso + _dt / dur_cobrir
        );

        if (progresso >= 1) {
            estado = 1;

            if (room_exists(room_destino)) {
                room_goto(room_destino);
            } else {
                global.em_transicao = false;
                instance_destroy();
            }
        }
        break;

    case 2:
        // Revela a nova room
        progresso = min(
            1,
            progresso + _dt / dur_revelar
        );

        if (progresso >= 1) {
            global.em_transicao = false;
            instance_destroy();
        }
        break;
}
