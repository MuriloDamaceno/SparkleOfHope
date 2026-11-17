
/// STEP - VOLTAR PARA O BECO

if (room != forabiblioteca) exit;
if (!instance_exists(obj_jogador)) exit;

if (global.caixa_aberta || instance_exists(Obj_inventario)) exit;

// Saida pelo lado esquerdo da rua
if (obj_jogador.x <= 9) {

    global.spawn_room = rua_beco;
    global.spawn_x = 360;
    global.spawn_y = 110;

    // Evita retornar imediatamente
    global.bloquear_entrada_fora = true;

    global.indo_para_porta = false;
    obj_jogador.has_target = false;

    room_goto(rua_beco);
}
