
/// STEP - ENTRADA AUTOMATICA DA BIBLIOTECA

if (room != forabiblioteca) exit;

if (!instance_exists(obj_jogador)) exit;

if (global.caixa_aberta || instance_exists(Obj_inventario)) {
    exit;
}

// Detecta Celeste perto da porta
var _perto = collision_rectangle(
    bbox_left - 30,
    bbox_top - 30,
    bbox_right + 30,
    bbox_bottom + 30,
    obj_jogador,
    false,
    true
);

// Protecao depois de sair da biblioteca
if (variable_global_exists("biblioteca_bloquear_entrada")) {

    if (global.biblioteca_bloquear_entrada) {

        // Precisa se afastar da porta primeiro
        if (_perto == noone) {
            global.biblioteca_bloquear_entrada = false;
        }

        exit;
    }
}

// Entrada normal
if (_perto != noone) {

    with (obj_jogador) {
        has_target = false;
    }

    global.indo_para_porta = false;
    global.porta_alvo = noone;

    room_goto(biblioteca);
}
