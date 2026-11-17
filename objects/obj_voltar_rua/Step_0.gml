
if (
    variable_global_exists("cutscene_bloqueio") &&
    global.cutscene_bloqueio
) {
    exit;
}


/// STEP - BECO PARA RUA

if (room != rua_beco) exit;
if (!instance_exists(obj_jogador)) exit;

if (global.caixa_aberta || instance_exists(Obj_inventario)) exit;

// Volta pela borda esquerda do beco
if (obj_jogador.x <= 9) {

    global.spawn_room = rm_rua;
    global.spawn_x = 265;
    global.spawn_y = 110;

    global.bloquear_entrada_beco = true;

    global.indo_para_porta = false;
    obj_jogador.has_target = false;

    room_goto(rm_rua);
}
