
if (global.caixa_aberta || instance_exists(Obj_inventario)) {
    exit;
}


// Nao anda se houver dialogo
if (global.caixa_aberta) exit;

// Aviso ao clicar em uma area bloqueada
// fora da faixa de pedestres
if (room == rm_rua) {

    if (
        (mouse_x < 50 || mouse_x > 175) &&
        mouse_y >= 105 && mouse_y <= 165 &&
        position_meeting(
            mouse_x, mouse_y, obj_ruacasa
        )
    ) {

        has_target = false;

        global.caixa_aberta = true;
        global.caixa_texto =
            "Ei, não posso ir por aqui. . .";

        exit;
    }
}


if (!place_meeting(mouse_x, mouse_y, obj_solido)) {
    target_x = clamp(mouse_x, 8, room_width - 8);
    target_y = clamp(mouse_y, floor_top, room_height - 3);
    has_target = true;
}