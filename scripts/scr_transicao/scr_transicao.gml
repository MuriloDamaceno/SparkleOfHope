
function transicao_iniciar(_room) {

    show_debug_message("TRANSICAO: funcao chamada!");

    if (instance_exists(obj_transicao)) {
        show_debug_message("TRANSICAO: objeto ja existe!");
        return;
    }

    var _t = instance_create_depth(
        0, 0, -16000, obj_transicao
    );

    _t.room_destino = _room;

    show_debug_message(
        "TRANSICAO: objeto criado! ID=" + string(_t)
    );
}
