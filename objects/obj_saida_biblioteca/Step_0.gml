
if (
    variable_global_exists("cutscene_bloqueio") &&
    global.cutscene_bloqueio
) {
    exit;
}


/// STEP - BECO PARA FORA DA BIBLIOTECA

if (room != rua_beco) exit;
if (!instance_exists(obj_jogador)) exit;

if (global.caixa_aberta || instance_exists(Obj_inventario)) exit;

var _perto = collision_rectangle(
    bbox_left - 20,
    bbox_top - 20,
    bbox_right + 20,
    bbox_bottom + 20,
    obj_jogador,
    false,
    true
);

// Protecao ao retornar do lado de fora
if (variable_global_exists("bloquear_entrada_fora")) {

    if (global.bloquear_entrada_fora) {

        if (_perto == noone) {
            global.bloquear_entrada_fora = false;
        }

        exit;
    }
}

// Entrada normal
if (_perto != noone) {

    global.spawn_room = forabiblioteca;
    global.spawn_x = 500;
    global.spawn_y = 350;

    obj_jogador.has_target = false;
    global.indo_para_porta = false;

    room_goto(forabiblioteca);
}
