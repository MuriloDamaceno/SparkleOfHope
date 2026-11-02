// Variável global: true enquanto a transição está rodando
global.em_transicao = false;

/// @desc Inicia a transição em blocos pretos e troca para a room de destino
function transicao_iniciar(_room) {
    if (instance_exists(obj_transicao)) return; // impede duas transições ao mesmo tempo
    instance_create_depth(0, 0, -16000, obj_transicao, { room_destino: _room });
}