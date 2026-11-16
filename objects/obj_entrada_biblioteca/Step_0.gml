
/// STEP - ENTRADA AUTOMATICA DA BIBLIOTECA

// Apenas funciona fora da biblioteca
if (room != forabiblioteca) exit;

// Verifica se a personagem existe
if (!instance_exists(obj_jogador)) exit;

// Impede entrada durante dialogos ou inventario
if (global.caixa_aberta || instance_exists(Obj_inventario)) {
    exit;
}

// Verifica se Celeste esta perto da entrada
var _perto = collision_circle(
    x, y,
    35,
    obj_jogador,
    false,
    true
);

// Quando chegar perto, entra automaticamente
if (_perto != noone) {

    // Cancela movimentacao
    with (obj_jogador) {
        has_target = false;
    }

    global.indo_para_porta = false;
    global.porta_alvo = noone;

    // Entra na biblioteca
    room_goto(biblioteca);
}
