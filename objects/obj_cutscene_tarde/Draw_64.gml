
/// OBJ_CUTSCENE_TARDE - DRAW

// Mostra o novo fundo durante a cutscene
if (
    room == rua_beco &&
    preparado
) {

    draw_sprite(
        spr_ruabeco_depois,
        0,
        0,
        0
    );
}
