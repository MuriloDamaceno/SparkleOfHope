
function transicao_iniciar(_room) {

    // Impede transições duplicadas
    if (instance_exists(obj_transicao)) {
        return;
    }

    // Cria o controlador
    var _t = instance_create_depth(
        0, 0, -16000, obj_transicao
    );

    // Define o destino
    _t.room_destino = _room;

    show_debug_message("Transicao criada!");
}
