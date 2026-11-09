
// Nao abre outro dialogo se ja existir um
if (global.caixa_aberta || instance_exists(Obj_inventario)) {
    exit;
}

// Verifica se a protagonista existe
if (!instance_exists(obj_jogador)) {
    exit;
}

// So permite interagir quando estiver perto
var _dist = point_distance(
    obj_jogador.x,
    obj_jogador.y,
    x,
    y
);

if (_dist > 75) {
    exit;
}

// Garante que exista uma caixa de dialogo
if (!instance_exists(obj_caixa_dialogo)) {
    instance_create_depth(
        0, 0, -1000, obj_caixa_dialogo
    );
}

// Interrompe a caminhada
with (obj_jogador) {
    has_target = false;
    image_speed = 0;
}

global.indo_para_porta = false;

// Abre o dialogo
global.caixa_texto = texto_dialogo;
global.caixa_aberta = true;
