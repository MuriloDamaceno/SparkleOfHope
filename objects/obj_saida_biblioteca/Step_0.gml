
/// ENTRADA AUTOMATICA DA BIBLIOTECA

if (room != rua_beco) exit;

if (!instance_exists(obj_jogador)) exit;

// Detecta a protagonista perto da area
// do objeto, sem precisar clicar
var _jogador_perto = collision_rectangle(
    bbox_left - 20,
    bbox_top - 20,
    bbox_right + 20,
    bbox_bottom + 20,
    obj_jogador,
    false,
    true
);

if (_jogador_perto != noone) {

    obj_jogador.has_target = false;
    global.indo_para_porta = false;

    room_goto(forabiblioteca);
}
