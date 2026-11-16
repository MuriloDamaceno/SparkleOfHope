
/// STEP - SAIDA DA BIBLIOTECA

if (room != biblioteca) exit;

if (!instance_exists(obj_jogador)) exit;

// So permite sair depois de conversar com Hope
if (!variable_global_exists("hope_concluida")) exit;
if (!global.hope_concluida) exit;

// Nao sai durante dialogos ou inventario
if (global.caixa_aberta || instance_exists(Obj_inventario)) {
    exit;
}

// Verifica se Celeste chegou na saida
var _perto = collision_rectangle(
    bbox_left - 10,
    bbox_top - 10,
    bbox_right + 10,
    bbox_bottom + 10,
    obj_jogador,
    false,
    true
);

if (_perto != noone) {

    // Define onde Celeste vai aparecer
    global.spawn_room = forabiblioteca;
    global.spawn_x = 500;
    global.spawn_y = 350;

    // Impede que entre novamente de imediato
    global.biblioteca_bloquear_entrada = true;

    global.indo_para_porta = false;
    global.porta_alvo = noone;

    with (obj_jogador) {
        has_target = false;
    }

    room_goto(forabiblioteca);
}
