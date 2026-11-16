
/// STEP - ENTRADA AUTOMATICA DA BIBLIOTECA

if (room != forabiblioteca) exit;

if (!instance_exists(obj_jogador)) exit;

if (global.caixa_aberta || instance_exists(Obj_inventario)) {
    exit;
}

// Detecta a personagem perto de toda a area da porta
var _perto = collision_rectangle(
    bbox_left - 30,
    bbox_top - 30,
    bbox_right + 30,
    bbox_bottom + 30,
    obj_jogador,
    false,
    true
);

if (_perto != noone) {

    with (obj_jogador) {
        has_target = false;
    }

    global.indo_para_porta = false;
    global.porta_alvo = noone;

    room_goto(biblioteca);
}
