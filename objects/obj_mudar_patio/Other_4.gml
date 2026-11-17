
// MUDA O CENARIO DEPOIS DE FALAR COM HOPE

if (
    variable_global_exists("hope_concluida") &&
    global.hope_concluida
) {

    layer_background_sprite(
        layer_get_id("Background"),
        spr_patio_depois
    );
}
