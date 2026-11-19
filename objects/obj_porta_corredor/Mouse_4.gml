if (!instance_exists(obj_jogador)) exit;
if (global.caixa_aberta || instance_exists(Obj_inventario)) exit;
if (variable_global_exists("cutscene_bloqueio") && global.cutscene_bloqueio) exit;

var _celeste = instance_find(obj_jogador, 0);

if (point_distance(_celeste.x, _celeste.y, x, y) <= 120) {
    _celeste.has_target = false;
    global.indo_para_porta = false;
    global.porta_alvo = noone;
    room_goto(Room1);
    exit;
}

// Caminha até o chão em frente à porta do quarto.
_celeste.target_x = x + 22;
_celeste.target_y = _celeste.floor_top + 8;
_celeste.has_target = true;

global.porta_alvo = id;
global.room_alvo = Room1;
global.indo_para_porta = true;